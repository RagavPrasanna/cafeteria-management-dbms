# Campus Dining Portal

A database-backed campus cafeteria ordering prototype. Students can browse a dining-hall menu, manage a wallet, place orders, view recent order history, and check dining-hall activity. The project was built as a DBMS course project and demonstrates relational schema design, constraints, stored procedures, and triggers.

## Features

- Student sign-in and wallet balance display
- Live menu by dining hall, with cart and checkout
- Wallet recharge and recent order history
- Dining-hall activity indicator
- MySQL schema with sample data, foreign keys, stored procedures, and triggers
- Express API using parameterized SQL queries

## Technology

- Node.js 20.6 or newer
- Express 5
- MySQL 8.0
- `mysql2` and `cors`
- Plain HTML, CSS, and JavaScript

## Run locally

### 1. Prepare the database

Create a MySQL database, then import the included dump (`front end/sodexo_dump.sql`). The dump defines tables and sample rows, but does not create the database itself. For example, in MySQL Workbench:

1. Connect to your local MySQL 8 server.
2. Run `CREATE DATABASE sodexo CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;`.
3. Select the `sodexo` schema and import `front end/sodexo_dump.sql` using **Server → Data Import** or open and execute the SQL file.

The dump is for local development. Review or replace its sample records before using the project with real data.

### 2. Configure the application

In a terminal, from the repository root:

```sh
cd "front end"
```

Copy `.env.example` to `.env` and update the database credentials for your local MySQL instance. Do not commit `.env`.

```sh
# PowerShell
Copy-Item .env.example .env

# macOS / Linux
cp .env.example .env
```

```dotenv
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your-local-password
DB_NAME=sodexo
PORT=3000
```

### 3. Install and start

```sh
npm install
npm start
```

Open [http://localhost:3000](http://localhost:3000). The server serves the login page and the API. The database must be running and configured before using the application.

## API overview

All endpoints are served from `http://localhost:3000`.

| Method | Endpoint | Purpose |
| --- | --- | --- |
| `POST` | `/api/login` | Sign in using an SNU ID and date-of-birth year |
| `GET` | `/api/menu/:dh_id` | Fetch a dining hall's current menu |
| `POST` | `/api/checkout` | Place an order from the cart |
| `GET` | `/api/history/:customerId` | Fetch the customer's recent orders |
| `POST` | `/api/recharge` | Add funds to a customer's wallet |
| `GET` | `/api/crowd/:dhId` | Get recent activity for a dining hall |
| `DELETE` | `/api/cart/clear/:customerId` | Clear a customer's cart |

## Project layout

```text
.
├── .github/                 # Issue and pull request templates
├── front end/
│   ├── index.html            # Sign-in page
│   ├── menu.html             # Menu, cart, and wallet UI
│   ├── server.js             # Express API and web server
│   ├── sodexo_dump.sql       # MySQL schema and sample data
│   ├── .env.example          # Local configuration template
│   └── package.json
├── .gitignore
└── README.md
```

## Development notes

- The sign-in flow uses an SNU ID and birth year as a course-project demonstration; it is not production authentication.
- The browser stores the signed-in user's details in `localStorage`. Do not use real credentials or personal data with this prototype.
- Database credentials belong in the local `.env` file, never in source code or commits.
- There is currently no automated test suite. Please verify database-backed flows locally before submitting changes.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for setup and pull request guidelines. Please use the issue templates for bug reports and feature requests.
