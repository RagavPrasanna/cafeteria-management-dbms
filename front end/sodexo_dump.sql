-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: sodexo
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `acc_bal` decimal(10,2) DEFAULT '1960.00',
  `dob` date DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `customer_chk_1` CHECK ((`acc_bal` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1001,'C Ragav','cr123@snu.edu.in','9876543210',2139.00,'2004-03-15'),(1002,'Aarav Sharma','as456@snu.edu.in','8765432109',1660.00,'2005-07-22'),(1003,'Priya Patel','pp789@snu.edu.in','7654321098',1830.00,'2004-11-05'),(1004,'Neha Gupta','ng012@snu.edu.in','9988776655',1890.00,'2005-01-30'),(1005,'Rahul Verma','rv345@snu.edu.in','8877665544',1890.00,'2004-09-12'),(1006,'Ananya Singh','as678@snu.edu.in','7766554433',1960.00,'2005-04-18'),(1007,'Karan Malhotra','km901@snu.edu.in','9123456780',1960.00,'2004-12-01'),(1008,'Sneha Reddy','sr234@snu.edu.in','8123456789',1890.00,'2005-06-25'),(1009,'Rohan Desai','rd567@snu.edu.in','7123456788',1960.00,'2004-08-14'),(1010,'Ishaan Kumar','ik890@snu.edu.in','9234567891',1860.00,'2005-03-09'),(1011,'Kavya Iyer','ki123@snu.edu.in','8234567892',1960.00,'2004-10-21'),(1012,'Aditya Joshi','aj456@snu.edu.in','7234567893',1960.00,'2005-05-16'),(1013,'Meera Nair','mn789@snu.edu.in','9345678912',1960.00,'2004-02-28'),(1014,'Vikram Chawla','vc012@snu.edu.in','8345678913',1960.00,'2005-08-03'),(1015,'Sanya Kapoor','sk345@snu.edu.in','7345678914',1830.00,'2004-06-11'),(1016,'Arjun Menon','am678@snu.edu.in','9456789123',1960.00,'2005-09-27'),(1017,'Diya Das','dd901@snu.edu.in','8456789124',1960.00,'2004-04-04'),(1018,'Nikhil Rao','nr234@snu.edu.in','7456789125',1960.00,'2005-10-19'),(1019,'Tanya Bhatia','tb567@snu.edu.in','9567891234',1960.00,'2004-01-25'),(1020,'Varun Chatterjee','vc890@snu.edu.in','8567891235',1895.00,'2005-11-08');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dining_hall`
--

DROP TABLE IF EXISTS `dining_hall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dining_hall` (
  `dh_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `capacity` int NOT NULL,
  PRIMARY KEY (`dh_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `location` (`location`),
  CONSTRAINT `dining_hall_chk_1` CHECK ((`capacity` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dining_hall`
--

LOCK TABLES `dining_hall` WRITE;
/*!40000 ALTER TABLE `dining_hall` DISABLE KEYS */;
INSERT INTO `dining_hall` VALUES (1,'Dining Hall 1','Cluster 2',200),(2,'Dining Hall 2','Cluster 4',200),(3,'Dining Hall 3','Cluster 3',200);
/*!40000 ALTER TABLE `dining_hall` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `menu_id` int NOT NULL,
  `item_id` int NOT NULL,
  `rating` int NOT NULL,
  `comment` text,
  PRIMARY KEY (`feedback_id`),
  KEY `customer_id` (`customer_id`),
  KEY `menu_id` (`menu_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`),
  CONSTRAINT `feedback_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `food_item` (`item_id`),
  CONSTRAINT `feedback_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,1001,103,708,5,'The Butter Chicken was amazing! Perfect post-Valorant dinner.'),(2,1004,101,125,3,'Coffee was a bit cold today, but I desperately needed the caffeine for my OS lab.'),(3,1003,102,803,4,'Solid Veg Thali, definitely hits the spot after a long day at the academic blocks.'),(4,1002,204,801,5,'Great breakfast combo to start the day. Portions were huge.'),(5,1008,208,303,2,'The dal was way too salty today. Usually it is much better.');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_item`
--

DROP TABLE IF EXISTS `food_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_item` (
  `item_id` int NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `item_type` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `cal` int DEFAULT NULL,
  `allergens` varchar(100) DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_item`
--

LOCK TABLES `food_item` WRITE;
/*!40000 ALTER TABLE `food_item` DISABLE KEYS */;
INSERT INTO `food_item` VALUES (101,'Methi Paratha','Breakfast',25.00,200,'Gluten',1),(102,'Uttpam','Breakfast',30.00,180,'None',1),(103,'Pav','Bread',15.00,150,'Gluten',1),(104,'Idli','Breakfast',25.00,120,'None',1),(105,'Poori','Bread',20.00,250,'Gluten',1),(106,'Vermicelli Upma','Breakfast',30.00,220,'Gluten',1),(107,'Bhature','Bread',30.00,300,'Gluten',1),(108,'Aloo Bhaji','Accompaniment',20.00,150,'None',1),(109,'Mix Veg Bhaji','Accompaniment',20.00,140,'None',1),(110,'Chole','Accompaniment',25.00,180,'None',1),(111,'Sambhar','Accompaniment',20.00,120,'Mustard',1),(112,'Coconut Chutney','Condiment',10.00,50,'Nuts',1),(113,'Tomato Peanut Chutney','Condiment',10.00,60,'Peanuts',1),(114,'Brown Bread/Jam/Butter','Breakfast',25.00,200,'Gluten, Dairy',1),(115,'Coleslaw Sandwich','Breakfast',35.00,250,'Gluten, Dairy, Egg',1),(116,'Vegetable Sandwich','Breakfast',30.00,220,'Gluten',1),(117,'Corn Spinach Sandwich','Breakfast',35.00,240,'Gluten, Dairy',1),(118,'Peri Peri Sandwich','Breakfast',40.00,260,'Gluten',1),(119,'Boiled Egg','Protein',15.00,70,'Egg',1),(120,'Banana','Fruit',10.00,105,'None',1),(121,'Kinnu','Fruit',15.00,50,'None',1),(122,'Cut Papaya','Fruit',15.00,60,'None',1),(123,'Watermelon','Fruit',15.00,45,'None',1),(124,'Sprouts','Salad',15.00,80,'None',1),(125,'Tea / Coffee','Beverage',15.00,80,'Dairy',1),(126,'Mix Pickle','Condiment',5.00,20,'Mustard',1),(201,'Veg Jalfrezi','Veg Main',50.00,250,'None',1),(202,'Khata Metha Petha','Veg Main',40.00,200,'None',1),(203,'Paneer Makhni','Veg Main',70.00,400,'Dairy, Nuts',1),(204,'Aloo Shimla Mirch','Veg Main',45.00,220,'None',1),(205,'Corn Palak','Veg Main',55.00,240,'Dairy',1),(206,'Paneer Lababdar','Veg Main',70.00,420,'Dairy, Nuts',1),(207,'Gobhi Aloo Matar','Veg Main',50.00,230,'None',1),(208,'Aloo Palak Dry','Veg Main',45.00,210,'None',1),(209,'Bhaigan Ka Bharta','Veg Main',45.00,190,'None',1),(210,'Lauki Masala','Veg Main',35.00,150,'None',1),(211,'Gatta Curry','Veg Main',55.00,280,'Dairy',1),(212,'Mattar Mushroom','Veg Main',65.00,260,'Dairy',1),(213,'Soya Chaap Masala','Veg Main',60.00,300,'Gluten, Soy',1),(214,'Sarso Ka Saag','Veg Main',50.00,220,'Dairy',1),(301,'Arhar Dal Tadka','Dal',35.00,180,'None',1),(302,'Pindi Choley','Dal',45.00,250,'None',1),(303,'Black Masoor','Dal',40.00,200,'None',1),(304,'Punjabi Kadi','Dal',40.00,220,'Dairy',1),(305,'Rajma Masala','Dal',45.00,260,'None',1),(306,'Dal Dhaba','Dal',40.00,210,'None',1),(307,'Dal Makhani','Dal',50.00,300,'Dairy',1),(308,'Dal Maharani','Dal',45.00,280,'Dairy',1),(309,'Rajma Rasella','Dal',45.00,250,'None',1),(310,'Green Moong Lehsooni','Dal',40.00,190,'None',1),(311,'Black Channa','Dal',40.00,220,'None',1),(312,'Rasam','Dal/Soup',20.00,90,'Mustard',1),(401,'Pea Pulao','Rice',35.00,240,'None',1),(402,'Steamed Rice','Rice',25.00,200,'None',1),(403,'Jeera Rice','Rice',30.00,220,'None',1),(404,'Dhaniya Pulao','Rice',35.00,230,'None',1),(405,'Dum Ka Pulao','Rice',40.00,260,'None',1),(406,'Chapati','Bread',8.00,100,'Gluten',1),(407,'Palak Poori','Bread',15.00,150,'Gluten',1),(408,'Missi Roti','Bread',12.00,120,'Gluten',1),(501,'Green Salad','Salad',20.00,30,'None',1),(502,'Masala Onion/ Green Chutney','Salad',15.00,40,'None',1),(503,'Summer Salad','Salad',25.00,50,'None',1),(504,'Beetroot Kachumber Salad','Salad',25.00,45,'None',1),(505,'Fryums','Accompaniment',10.00,100,'Gluten',1),(506,'Garden Green Salad','Salad',20.00,35,'None',1),(507,'Vegetable Pasta Salad','Salad',35.00,180,'Gluten',1),(508,'Bhel Chaat/ Chutney','Salad',30.00,150,'None',1),(509,'Masala Mooli','Salad',15.00,25,'None',1),(510,'Lemon Water','Beverage',10.00,40,'None',1),(511,'Sweet Lassi','Beverage',25.00,150,'Dairy',1),(512,'Watermelon Mint','Beverage',20.00,60,'None',1),(513,'Tang','Beverage',15.00,80,'None',1),(514,'Masala Chaas','Beverage',15.00,60,'Dairy',1),(515,'Mix Veg Raita','Raita',20.00,80,'Dairy',1),(516,'Boondi Raita','Raita',20.00,90,'Dairy, Gluten',1),(517,'Tomato Soup','Soup',30.00,110,'None',1),(518,'Hot n Sour Soup','Soup',30.00,120,'Soy',1),(519,'Veg Clear Soup','Soup',25.00,80,'None',1),(520,'Tomato Shorba Soup','Soup',30.00,110,'None',1),(521,'Lemon Corriander Soup','Soup',30.00,90,'None',1),(522,'Manchow Soup','Soup',35.00,140,'Soy, Gluten',1),(523,'Veg Sweet Corn Soup','Soup',35.00,130,'None',1),(601,'Besan Halwa','Dessert',40.00,350,'Dairy, Nuts',1),(602,'Seviya Kheer','Dessert',40.00,320,'Dairy, Gluten, Nuts',1),(701,'Spicy Chicken Korma','Non-Veg Main',90.00,450,'Dairy, Nuts',1),(702,'Home Style Chicken','Non-Veg Main',80.00,380,'None',1),(703,'Kadhai Chicken','Non-Veg Main',85.00,420,'None',1),(704,'Chilli Chicken','Non-Veg Main',85.00,400,'Soy, Gluten',1),(705,'Chicken Do Payza','Non-Veg Main',85.00,410,'None',1),(706,'Chicken Kolhapuri','Non-Veg Main',90.00,440,'None',1),(707,'Fried Chicken/ Cocktail sauce','Non-Veg Main',95.00,480,'Gluten, Egg',1),(708,'Butter Chicken','Non-Veg Main',100.00,500,'Dairy, Nuts',1),(709,'Chicken Musalam Curry','Non-Veg Main',95.00,460,'Dairy, Nuts',1),(710,'Chicken 65','Non-Veg Main',90.00,430,'Gluten, Egg, Soy',1),(711,'Methi Chicken','Non-Veg Main',85.00,400,'Dairy',1),(712,'Punjabi Chicken Curry','Non-Veg Main',85.00,420,'None',1),(713,'Dum Ka Murg','Non-Veg Main',90.00,450,'Dairy, Nuts',1),(714,'Chicken Lababdar','Non-Veg Main',95.00,470,'Dairy, Nuts',1),(801,'Daily Veg Breakfast Combo','Combo',70.00,600,'Gluten, Dairy',1),(802,'Daily Breakfast Combo (with Egg)','Combo',80.00,670,'Gluten, Dairy, Egg',1),(803,'Daily Veg Lunch Thali','Combo',100.00,850,'Gluten, Dairy',1),(804,'Daily Non-Veg Lunch Thali','Combo',130.00,950,'Gluten, Dairy, Nuts',1),(805,'Daily Veg Dinner Thali','Combo',100.00,800,'Gluten, Dairy',1),(806,'Daily Non-Veg Dinner Thali','Combo',130.00,900,'Gluten, Dairy, Nuts',1);
/*!40000 ALTER TABLE `food_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `menu_id` int NOT NULL,
  `dh_id` int NOT NULL,
  `meal_type` varchar(20) NOT NULL,
  `menu_day` varchar(15) NOT NULL,
  `available_from` time NOT NULL,
  `available_to` time NOT NULL,
  PRIMARY KEY (`menu_id`),
  KEY `dh_id` (`dh_id`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`dh_id`) REFERENCES `dining_hall` (`dh_id`),
  CONSTRAINT `menu_chk_1` CHECK ((`meal_type` in (_utf8mb4'Breakfast',_utf8mb4'Lunch',_utf8mb4'Dinner'))),
  CONSTRAINT `menu_chk_2` CHECK ((`menu_day` in (_utf8mb4'Monday',_utf8mb4'Tuesday',_utf8mb4'Wednesday',_utf8mb4'Thursday',_utf8mb4'Friday',_utf8mb4'Saturday',_utf8mb4'Sunday')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (101,1,'Breakfast','Monday','07:00:00','10:00:00'),(102,1,'Lunch','Monday','12:00:00','15:00:00'),(103,1,'Dinner','Monday','19:00:00','22:00:00'),(104,1,'Breakfast','Tuesday','07:00:00','10:00:00'),(105,1,'Lunch','Tuesday','12:00:00','15:00:00'),(106,1,'Dinner','Tuesday','19:00:00','22:00:00'),(107,1,'Breakfast','Wednesday','07:00:00','10:00:00'),(108,1,'Lunch','Wednesday','12:00:00','15:00:00'),(109,1,'Dinner','Wednesday','19:00:00','22:00:00'),(110,1,'Breakfast','Thursday','07:00:00','10:00:00'),(111,1,'Lunch','Thursday','12:00:00','15:00:00'),(112,1,'Dinner','Thursday','19:00:00','22:00:00'),(113,1,'Breakfast','Friday','07:00:00','10:00:00'),(114,1,'Lunch','Friday','12:00:00','15:00:00'),(115,1,'Dinner','Friday','19:00:00','22:00:00'),(116,1,'Breakfast','Saturday','07:00:00','10:00:00'),(117,1,'Lunch','Saturday','12:00:00','15:00:00'),(118,1,'Dinner','Saturday','19:00:00','22:00:00'),(119,1,'Breakfast','Sunday','07:00:00','10:00:00'),(120,1,'Lunch','Sunday','12:00:00','15:00:00'),(121,1,'Dinner','Sunday','19:00:00','22:00:00'),(201,2,'Breakfast','Monday','07:00:00','10:00:00'),(202,2,'Lunch','Monday','12:00:00','15:00:00'),(203,2,'Dinner','Monday','19:00:00','22:00:00'),(204,2,'Breakfast','Tuesday','07:00:00','10:00:00'),(205,2,'Lunch','Tuesday','12:00:00','15:00:00'),(206,2,'Dinner','Tuesday','19:00:00','22:00:00'),(207,2,'Breakfast','Wednesday','07:00:00','10:00:00'),(208,2,'Lunch','Wednesday','12:00:00','15:00:00'),(209,2,'Dinner','Wednesday','19:00:00','22:00:00'),(210,2,'Breakfast','Thursday','07:00:00','10:00:00'),(211,2,'Lunch','Thursday','12:00:00','15:00:00'),(212,2,'Dinner','Thursday','19:00:00','22:00:00'),(213,2,'Breakfast','Friday','07:00:00','10:00:00'),(214,2,'Lunch','Friday','12:00:00','15:00:00'),(215,2,'Dinner','Friday','19:00:00','22:00:00'),(216,2,'Breakfast','Saturday','07:00:00','10:00:00'),(217,2,'Lunch','Saturday','12:00:00','15:00:00'),(218,2,'Dinner','Saturday','19:00:00','22:00:00'),(219,2,'Breakfast','Sunday','07:00:00','10:00:00'),(220,2,'Lunch','Sunday','12:00:00','15:00:00'),(221,2,'Dinner','Sunday','19:00:00','22:00:00'),(301,3,'Breakfast','Monday','07:00:00','10:00:00'),(302,3,'Lunch','Monday','12:00:00','15:00:00'),(303,3,'Dinner','Monday','19:00:00','22:00:00'),(304,3,'Breakfast','Tuesday','07:00:00','10:00:00'),(305,3,'Lunch','Tuesday','12:00:00','15:00:00'),(306,3,'Dinner','Tuesday','19:00:00','22:00:00'),(307,3,'Breakfast','Wednesday','07:00:00','10:00:00'),(308,3,'Lunch','Wednesday','12:00:00','15:00:00'),(309,3,'Dinner','Wednesday','19:00:00','22:00:00'),(310,3,'Breakfast','Thursday','07:00:00','10:00:00'),(311,3,'Lunch','Thursday','12:00:00','15:00:00'),(312,3,'Dinner','Thursday','19:00:00','22:00:00'),(313,3,'Breakfast','Friday','07:00:00','10:00:00'),(314,3,'Lunch','Friday','12:00:00','15:00:00'),(315,3,'Dinner','Friday','19:00:00','22:00:00'),(316,3,'Breakfast','Saturday','07:00:00','10:00:00'),(317,3,'Lunch','Saturday','12:00:00','15:00:00'),(318,3,'Dinner','Saturday','19:00:00','22:00:00'),(319,3,'Breakfast','Sunday','07:00:00','10:00:00'),(320,3,'Lunch','Sunday','12:00:00','15:00:00'),(321,3,'Dinner','Sunday','19:00:00','22:00:00');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_items` (
  `menu_id` int NOT NULL,
  `item_id` int NOT NULL,
  PRIMARY KEY (`menu_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `menu_items_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`),
  CONSTRAINT `menu_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `food_item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (101,101),(201,101),(301,101),(104,102),(204,102),(304,102),(107,103),(207,103),(307,103),(110,104),(210,104),(310,104),(113,105),(213,105),(313,105),(116,106),(216,106),(316,106),(119,107),(219,107),(319,107),(101,108),(113,108),(201,108),(213,108),(301,108),(313,108),(107,109),(207,109),(307,109),(119,110),(219,110),(319,110),(103,111),(104,111),(105,111),(109,111),(110,111),(111,111),(115,111),(117,111),(121,111),(203,111),(204,111),(205,111),(209,111),(210,111),(211,111),(215,111),(217,111),(221,111),(303,111),(304,111),(305,111),(309,111),(310,111),(311,111),(315,111),(317,111),(321,111),(104,112),(110,112),(204,112),(210,112),(304,112),(310,112),(116,113),(216,113),(316,113),(101,114),(113,114),(119,114),(201,114),(213,114),(219,114),(301,114),(313,114),(319,114),(104,115),(204,115),(304,115),(107,116),(207,116),(307,116),(110,117),(210,117),(310,117),(116,118),(216,118),(316,118),(107,119),(116,119),(207,119),(216,119),(307,119),(316,119),(101,120),(116,120),(201,120),(216,120),(301,120),(316,120),(104,121),(113,121),(204,121),(213,121),(304,121),(313,121),(107,122),(207,122),(307,122),(110,123),(210,123),(310,123),(119,124),(219,124),(319,124),(101,125),(104,125),(107,125),(110,125),(113,125),(116,125),(119,125),(201,125),(204,125),(207,125),(210,125),(213,125),(216,125),(219,125),(301,125),(304,125),(307,125),(310,125),(313,125),(316,125),(319,125),(101,126),(102,126),(103,126),(104,126),(105,126),(106,126),(107,126),(108,126),(109,126),(110,126),(111,126),(112,126),(113,126),(114,126),(115,126),(116,126),(117,126),(118,126),(119,126),(120,126),(121,126),(201,126),(202,126),(203,126),(204,126),(205,126),(206,126),(207,126),(208,126),(209,126),(210,126),(211,126),(212,126),(213,126),(214,126),(215,126),(216,126),(217,126),(218,126),(219,126),(220,126),(221,126),(301,126),(302,126),(303,126),(304,126),(305,126),(306,126),(307,126),(308,126),(309,126),(310,126),(311,126),(312,126),(313,126),(314,126),(315,126),(316,126),(317,126),(318,126),(319,126),(320,126),(321,126),(102,201),(202,201),(302,201),(105,202),(205,202),(305,202),(108,203),(208,203),(308,203),(111,204),(211,204),(311,204),(114,205),(214,205),(314,205),(117,206),(217,206),(317,206),(120,207),(220,207),(320,207),(103,208),(203,208),(303,208),(106,209),(206,209),(306,209),(109,210),(209,210),(309,210),(112,211),(212,211),(312,211),(115,212),(215,212),(315,212),(118,213),(218,213),(318,213),(121,214),(221,214),(321,214),(102,301),(121,301),(202,301),(221,301),(302,301),(321,301),(105,302),(205,302),(305,302),(108,303),(208,303),(308,303),(111,304),(211,304),(311,304),(114,305),(214,305),(314,305),(106,306),(117,306),(206,306),(217,306),(306,306),(317,306),(112,307),(120,307),(212,307),(220,307),(312,307),(320,307),(103,308),(203,308),(303,308),(109,309),(209,309),(309,309),(115,310),(215,310),(315,310),(118,311),(218,311),(318,311),(102,312),(106,312),(108,312),(112,312),(114,312),(118,312),(120,312),(202,312),(206,312),(208,312),(212,312),(214,312),(218,312),(220,312),(302,312),(306,312),(308,312),(312,312),(314,312),(318,312),(320,312),(102,401),(121,401),(202,401),(221,401),(302,401),(321,401),(105,402),(106,402),(109,402),(118,402),(205,402),(206,402),(209,402),(218,402),(305,402),(306,402),(309,402),(318,402),(108,403),(120,403),(208,403),(220,403),(308,403),(320,403),(103,404),(111,404),(112,404),(114,404),(117,404),(203,404),(211,404),(212,404),(214,404),(217,404),(303,404),(311,404),(312,404),(314,404),(317,404),(115,405),(215,405),(315,405),(102,406),(103,406),(106,406),(108,406),(109,406),(111,406),(112,406),(114,406),(115,406),(117,406),(118,406),(120,406),(202,406),(203,406),(206,406),(208,406),(209,406),(211,406),(212,406),(214,406),(215,406),(217,406),(218,406),(220,406),(302,406),(303,406),(306,406),(308,406),(309,406),(311,406),(312,406),(314,406),(315,406),(317,406),(318,406),(320,406),(105,407),(205,407),(305,407),(121,408),(221,408),(321,408),(102,501),(106,501),(117,501),(202,501),(206,501),(217,501),(302,501),(306,501),(317,501),(105,502),(205,502),(305,502),(108,503),(208,503),(308,503),(111,504),(211,504),(311,504),(109,505),(114,505),(209,505),(214,505),(309,505),(314,505),(112,506),(118,506),(120,506),(212,506),(218,506),(220,506),(312,506),(318,506),(320,506),(103,507),(203,507),(303,507),(115,508),(215,508),(315,508),(121,509),(221,509),(321,509),(102,510),(202,510),(302,510),(105,511),(205,511),(305,511),(108,512),(208,512),(308,512),(111,513),(211,513),(311,513),(114,514),(214,514),(314,514),(117,515),(217,515),(317,515),(120,516),(220,516),(320,516),(103,517),(203,517),(303,517),(106,518),(206,518),(306,518),(109,519),(209,519),(309,519),(112,520),(212,520),(312,520),(115,521),(215,521),(315,521),(118,522),(218,522),(318,522),(121,523),(221,523),(321,523),(105,601),(205,601),(305,601),(118,602),(218,602),(318,602),(102,701),(202,701),(302,701),(105,702),(205,702),(305,702),(108,703),(208,703),(308,703),(111,704),(211,704),(311,704),(114,705),(214,705),(314,705),(117,706),(217,706),(317,706),(120,707),(220,707),(320,707),(103,708),(203,708),(303,708),(106,709),(206,709),(306,709),(109,710),(209,710),(309,710),(112,711),(212,711),(312,711),(115,712),(215,712),(315,712),(118,713),(218,713),(318,713),(121,714),(221,714),(321,714),(101,801),(104,801),(107,801),(110,801),(113,801),(116,801),(119,801),(201,801),(204,801),(207,801),(210,801),(213,801),(216,801),(219,801),(301,801),(304,801),(307,801),(310,801),(313,801),(316,801),(319,801),(101,802),(104,802),(107,802),(110,802),(113,802),(116,802),(119,802),(201,802),(204,802),(207,802),(210,802),(213,802),(216,802),(219,802),(301,802),(304,802),(307,802),(310,802),(313,802),(316,802),(319,802),(102,803),(105,803),(108,803),(111,803),(114,803),(117,803),(120,803),(202,803),(205,803),(208,803),(211,803),(214,803),(217,803),(220,803),(302,803),(305,803),(308,803),(311,803),(314,803),(317,803),(320,803),(102,804),(105,804),(108,804),(111,804),(114,804),(117,804),(120,804),(202,804),(205,804),(208,804),(211,804),(214,804),(217,804),(220,804),(302,804),(305,804),(308,804),(311,804),(314,804),(317,804),(320,804),(103,805),(106,805),(109,805),(112,805),(115,805),(118,805),(121,805),(203,805),(206,805),(209,805),(212,805),(215,805),(218,805),(221,805),(303,805),(306,805),(309,805),(312,805),(315,805),(318,805),(321,805),(103,806),(106,806),(109,806),(112,806),(115,806),(118,806),(121,806),(203,806),(206,806),(209,806),(212,806),(215,806),(218,806),(221,806),(303,806),(306,806),(309,806),(312,806),(315,806),(318,806),(321,806);
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `food_item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,10001,803,1,100.00),(2,10002,806,1,130.00),(3,10003,801,1,70.00),(4,10004,801,1,70.00),(5,10005,803,2,100.00),(6,10006,803,1,100.00),(7,10007,806,1,130.00),(8,10008,303,1,40.00),(9,10008,503,1,25.00),(10,10010,804,1,130.00),(11,10011,406,1,8.00),(12,10011,514,1,15.00),(14,10012,804,1,130.00),(15,10013,406,1,8.00),(16,10014,803,1,100.00),(17,10015,804,1,130.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50003 TRIGGER `enforce_menu_availability` BEFORE INSERT ON `order_items` FOR EACH ROW BEGIN
    DECLARE item_valid INT;


    SELECT COUNT(*)
    INTO item_valid
    FROM transactions t
    JOIN menu m ON t.dh_id = m.dh_id
                AND m.menu_day = DAYNAME(t.transaction_date)
                AND t.transaction_time >= m.available_from
                AND t.transaction_time <= m.available_to
    JOIN menu_items mi ON m.menu_id = mi.menu_id
    WHERE t.transaction_id = NEW.transaction_id
      AND mi.item_id = NEW.item_id;


    IF item_valid = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Menu Validation Failed: This item is not available at this dining hall during this meal time.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `shopping_cart`
--

DROP TABLE IF EXISTS `shopping_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopping_cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `customer_id` (`customer_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `shopping_cart_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `shopping_cart_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `food_item` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_cart`
--

LOCK TABLES `shopping_cart` WRITE;
/*!40000 ALTER TABLE `shopping_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `shopping_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `staff_name` varchar(100) NOT NULL,
  `role` varchar(50) NOT NULL,
  `dh_id` int DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `dh_id` (`dh_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`dh_id`) REFERENCES `dining_hall` (`dh_id`),
  CONSTRAINT `staff_chk_1` CHECK ((`role` in (_utf8mb4'Manager',_utf8mb4'Chef',_utf8mb4'Server',_utf8mb4'Cleaner')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (5001,'Ramesh Gupta','Manager',1),(5002,'Sanjeev Kapoor','Chef',1),(5003,'Vikas Khanna','Chef',1),(5004,'Amit Singh','Server',1),(5005,'Pooja Sharma','Server',1),(5006,'Rajesh Kumar','Server',1),(5007,'Neha Patil','Server',1),(5008,'Sunita Devi','Cleaner',1),(5009,'Manoj Paswan','Cleaner',1),(5010,'Kishore Lal','Cleaner',1),(5011,'Anita Desai','Manager',2),(5012,'Ranveer Brar','Chef',2),(5013,'Garima Arora','Chef',2),(5014,'Suresh Menon','Server',2),(5015,'Kavita Reddy','Server',2),(5016,'Deepak Verma','Server',2),(5017,'Anjali Rao','Server',2),(5018,'Lakshmi Bai','Cleaner',2),(5019,'Hari Om','Cleaner',2),(5020,'Ramu Kaka','Cleaner',2),(5021,'Vikram Singh','Manager',3),(5022,'Meghna Botawala','Chef',3),(5023,'Kunal Kapur','Chef',3),(5024,'Ravi Teja','Server',3),(5025,'Simran Kaur','Server',3),(5026,'Tariq Anwar','Server',3),(5027,'Bhavna Iyer','Server',3),(5028,'Gopal Das','Cleaner',3),(5029,'Shanti Devi','Cleaner',3),(5030,'Mohan Lal','Cleaner',3);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `dh_id` int NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `transaction_date` date NOT NULL,
  `transaction_time` time NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `customer_id` (`customer_id`),
  KEY `dh_id` (`dh_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`dh_id`) REFERENCES `dining_hall` (`dh_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (10001,1001,1,100.00,'2026-03-23','12:45:00'),(10002,1003,1,130.00,'2026-03-23','19:15:00'),(10003,1008,3,70.00,'2026-03-23','08:30:00'),(10004,1005,2,70.00,'2026-03-24','09:00:00'),(10005,1002,2,200.00,'2026-03-24','13:05:00'),(10006,1010,3,100.00,'2026-03-24','14:20:00'),(10007,1015,1,130.00,'2026-03-25','20:00:00'),(10008,1020,2,65.00,'2026-03-25','12:30:00'),(10009,1004,1,70.00,'2026-03-23','08:30:00'),(10010,1001,1,130.00,'2026-04-17','13:40:54'),(10011,1001,1,23.00,'2026-04-17','13:53:46'),(10012,1001,1,130.00,'2026-04-18','12:06:48'),(10013,1001,1,8.00,'2026-04-18','12:07:31'),(10014,1002,1,100.00,'2026-04-18','12:08:17'),(10015,1001,1,130.00,'2026-04-18','14:33:56');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50003 TRIGGER `check_dining_hall_hours` BEFORE INSERT ON `transactions` FOR EACH ROW BEGIN
    DECLARE active_menus INT;



    SELECT COUNT(*)
    INTO active_menus
    FROM menu
    WHERE dh_id = NEW.dh_id
      AND menu_day = DAYNAME(NEW.transaction_date)
      AND NEW.transaction_time >= available_from
      AND NEW.transaction_time <= available_to;


    IF active_menus = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction Failed: The dining hall is closed or not serving a meal at this time.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50003 TRIGGER `process_wallet_payment` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN

    UPDATE customer
    SET acc_bal = acc_bal - NEW.total_amount
    WHERE customer_id = NEW.customer_id;


    INSERT INTO wallet_transactions (customer_id, amount, txn_type, txn_datetime)
    VALUES (
        NEW.customer_id,
        NEW.total_amount,
        'DEBIT',
        CONCAT(NEW.transaction_date, ' ', NEW.transaction_time)
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `wallet_transactions`
--

DROP TABLE IF EXISTS `wallet_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_transactions` (
  `wallet_txn_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `txn_type` varchar(20) NOT NULL,
  `txn_datetime` datetime NOT NULL,
  PRIMARY KEY (`wallet_txn_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `wallet_transactions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `wallet_transactions_chk_1` CHECK ((`txn_type` in (_utf8mb4'DEBIT',_utf8mb4'CREDIT')))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_transactions`
--

LOCK TABLES `wallet_transactions` WRITE;
/*!40000 ALTER TABLE `wallet_transactions` DISABLE KEYS */;
INSERT INTO `wallet_transactions` VALUES (1,1001,100.00,'DEBIT','2026-03-23 12:45:00'),(2,1003,130.00,'DEBIT','2026-03-23 19:15:00'),(3,1008,70.00,'DEBIT','2026-03-23 08:30:00'),(4,1005,70.00,'DEBIT','2026-03-24 09:00:00'),(5,1002,200.00,'DEBIT','2026-03-24 13:05:00'),(6,1010,100.00,'DEBIT','2026-03-24 14:20:00'),(7,1015,130.00,'DEBIT','2026-03-25 20:00:00'),(8,1020,65.00,'DEBIT','2026-03-25 12:30:00'),(9,1004,70.00,'DEBIT','2026-03-23 08:30:00'),(10,1001,130.00,'DEBIT','2026-04-17 13:40:54'),(11,1001,23.00,'DEBIT','2026-04-17 13:53:46'),(12,1001,130.00,'DEBIT','2026-04-18 12:06:48'),(13,1001,8.00,'DEBIT','2026-04-18 12:07:31'),(14,1002,100.00,'DEBIT','2026-04-18 12:08:17'),(15,1001,130.00,'DEBIT','2026-04-18 14:33:56');
/*!40000 ALTER TABLE `wallet_transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-19 13:32:40
