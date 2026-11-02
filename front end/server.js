const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const path = require('path');

const app = express();
const port = Number(process.env.PORT || 3000);

// Middleware to parse JSON and allow cross-origin requests
app.use(express.json());
app.use(cors());

// Serve only the application pages; keep the database dump and configuration private.
app.get('/', (req, res) => res.sendFile(path.join(__dirname, 'index.html')));
app.get('/menu.html', (req, res) => res.sendFile(path.join(__dirname, 'menu.html')));

// 1. Connect to your MySQL Database
const db = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    port: Number(process.env.DB_PORT || 3306),
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'sodexo'
});

db.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL:', err);
        return;
    }
    console.log('✅ Connected successfully to MySQL Database!');
});

// 2. Create the Login API Endpoint
app.post('/api/login', (req, res) => {
    const { snuId, dobYear } = req.body;

    // Secure SQL Query using '?' to prevent SQL Injection
    const query = 'SELECT customer_name, acc_bal FROM customer WHERE customer_id = ? AND YEAR(dob) = ?';

    db.query(query, [snuId, dobYear], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ message: 'Database error' });
        }

        // If the array has length > 0, we found a match!
        if (results.length > 0) {
            const user = results[0]; // Get the first matched user
            res.status(200).json({
                success: true,
                message: 'Login successful',
                name: user.customer_name,
                balance: user.acc_bal
            });
        } else {
            // No match found
            res.status(401).json({
                success: false,
                message: 'Invalid SNU ID or DOB Year'
            });
        }
    });
});
// 3. Fetch Live Menu API (Using your Stored Procedure!)
app.get('/api/menu/:dh_id', (req, res) => {
    const dhId = req.params.dh_id;

    // Call the stored procedure directly
    const query = 'CALL get_current_menu(?)';

    db.query(query, [dhId], (err, results) => {
        if (err) {
            console.error('Error fetching menu:', err);
            return res.status(500).json({ success: false, message: 'Database error' });
        }

        // Stored procedures return an array of result sets.
        // results[0] contains the actual rows of food items.
        res.status(200).json({
            success: true,
            menuItems: results[0]
        });
    });
});

// Start the server
// 4. Process Checkout API (Using your Stored Procedure & Triggers!)
app.post('/api/checkout', async (req, res) => {
    const { customerId, dhId, cartItems } = req.body;

    // Convert the database connection to use Promises for cleaner async code
    const promisePool = db.promise();

    try {
        // Step A: Clear any old abandoned cart items for this user just in case
        await promisePool.query('DELETE FROM shopping_cart WHERE customer_id = ?', [customerId]);

        // Step B: Loop through the frontend cart and insert them into your `shopping_cart` table
        for (let item of cartItems) {
            // Look up the exact item_id based on the dish name
            const [rows] = await promisePool.query('SELECT item_id FROM food_item WHERE item_name = ?', [item.dish]);

            if (rows.length > 0) {
                // Insert into your database cart
                await promisePool.query(
                    'INSERT INTO shopping_cart (customer_id, item_id, quantity) VALUES (?, ?, ?)',
                    [customerId, rows[0].item_id, item.quantity]
                );
            }
        }

        // Step C: EXECUTE YOUR MASTER STORED PROCEDURE!
        // This will move items to order_items, delete the cart, and fire the wallet deduction trigger.
        await promisePool.query('CALL checkout_cart(?, ?)', [customerId, dhId]);

        // Step D: Fetch the new updated wallet balance to send back to the frontend
        const [userRows] = await promisePool.query('SELECT acc_bal FROM customer WHERE customer_id = ?', [customerId]);

        res.status(200).json({
            success: true,
            message: 'Order placed successfully!',
            newBalance: userRows[0].acc_bal
        });

    } catch (error) {
        console.error('Checkout Error:', error);

        // ✨ THE MAGIC OF DATABASE CONSTRAINTS ✨
        // If the trigger tries to deduct money but the balance drops below 0,
        // your CHECK (acc_bal >= 0) constraint blocks it and rolls back the transaction!
        if (error.code === 'ER_CHECK_CONSTRAINT_VIOLATED') {
            return res.status(400).json({ success: false, message: 'Insufficient funds in wallet!' });
        }

        res.status(500).json({ success: false, message: 'Checkout failed due to a database error.' });
    }
});
// 5. Fetch 1-Month Order History API
app.get('/api/history/:customerId', (req, res) => {
    const customerId = req.params.customerId;

    // This query grabs the transaction, joins the dining hall and food items,
    // and groups the food items together into a single text string!
    const query = `
        SELECT
            t.transaction_date,
            t.total_amount,
            dh.name AS dh_name,
            GROUP_CONCAT(CONCAT(oi.quantity, 'x ', f.item_name) SEPARATOR ', ') AS ordered_items
        FROM transactions t
        JOIN dining_hall dh ON t.dh_id = dh.dh_id
        JOIN order_items oi ON t.transaction_id = oi.transaction_id
        JOIN food_item f ON oi.item_id = f.item_id
        WHERE t.customer_id = ?
          AND t.transaction_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)
        GROUP BY t.transaction_id, t.transaction_date, t.total_amount, dh.name
        ORDER BY t.transaction_date DESC;
    `;

    db.query(query, [customerId], (err, results) => {
        if (err) {
            console.error('Error fetching history:', err);
            return res.status(500).json({ success: false, message: 'Database error' });
        }
        res.status(200).json({ success: true, history: results });
    });
});
// 6. Recharge Wallet API
app.post('/api/recharge', async (req, res) => {
    const { customerId, amount } = req.body;
    const promisePool = db.promise();

    try {
        // Ensure the amount is a valid positive number
        const rechargeAmount = parseFloat(amount);
        if (isNaN(rechargeAmount) || rechargeAmount <= 0) {
            return res.status(400).json({ success: false, message: 'Invalid amount' });
        }

        // 1. Add the money to their database record
        await promisePool.query(
            'UPDATE customer SET acc_bal = acc_bal + ? WHERE customer_id = ?',
            [rechargeAmount, customerId]
        );

        // 2. Fetch the newly updated balance
        const [rows] = await promisePool.query('SELECT acc_bal FROM customer WHERE customer_id = ?', [customerId]);

        res.status(200).json({
            success: true,
            message: `Successfully added ₹${rechargeAmount} to your wallet!`,
            newBalance: rows[0].acc_bal
        });

    } catch (error) {
        console.error('Recharge Error:', error);
        res.status(500).json({ success: false, message: 'Failed to recharge wallet.' });
    }
});
// 7. Live Crowd Tracker API
app.get('/api/crowd/:dhId', (req, res) => {
    const dhId = req.params.dhId;

    // Count how many orders were placed here in the last 30 minutes
    const query = `
        SELECT COUNT(transaction_id) AS recent_orders
        FROM transactions
        WHERE dh_id = ?
          AND transaction_date >= NOW() - INTERVAL 30 MINUTE
    `;

    db.query(query, [dhId], (err, results) => {
        if (err) {
            console.error('Error fetching crowd data:', err);
            return res.status(500).json({ success: false, message: 'Database error' });
        }

        const orderCount = results[0].recent_orders;

        // Logic to determine how crowded it is based on order volume
        let statusText = "🟢 Low Activity";
        let badgeColor = "#28a745"; // Green
        let textColor = "white";

        if (orderCount >= 15) {
            statusText = "🔴 Very Crowded";
            badgeColor = "#dc3545"; // Red
        } else if (orderCount >= 5) {
            statusText = "🟡 Moderate Traffic";
            badgeColor = "#ffc107"; // Yellow
            textColor = "black"; // Dark text looks better on yellow
        }

        res.status(200).json({
            success: true,
            count: orderCount,
            statusText: statusText,
            badgeColor: badgeColor,
            textColor: textColor
        });
    });
});
// 8. Clear Cart API (Calls your new Stored Procedure)
app.delete('/api/cart/clear/:customerId', async (req, res) => {
    const customerId = req.params.customerId;
    const promisePool = db.promise();

    try {
        // Execute the stored procedure
        await promisePool.query('CALL clear_shopping_cart(?)', [customerId]);

        res.status(200).json({ success: true, message: 'Cart cleared successfully from database.' });
    } catch (error) {
        console.error('Error clearing cart:', error);
        res.status(500).json({ success: false, message: 'Failed to clear cart in database.' });
    }
});
app.listen(port, () => {
    console.log(`🚀 Backend Server running on http://localhost:${port}`);
});
