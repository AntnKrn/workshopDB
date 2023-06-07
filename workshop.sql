-- MySQL dump 10.13  Distrib 8.0.30, for macos12 (x86_64)
--
-- Host: localhost    Database: workshop
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `brandInfo`
--

DROP TABLE IF EXISTS `brandInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brandInfo` (
  `id_Brand` int NOT NULL AUTO_INCREMENT,
  `brandName` varchar(45) NOT NULL,
  `website` varchar(45) NOT NULL,
  PRIMARY KEY (`id_Brand`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brandInfo`
--

LOCK TABLES `brandInfo` WRITE;
/*!40000 ALTER TABLE `brandInfo` DISABLE KEYS */;
INSERT INTO `brandInfo` VALUES (1,'Nike','www.nike.com'),(2,'Puma','www.puma.com'),(3,'Adidas','www.adidas.com'),(4,'S.Oliver','www.soliver.com'),(5,'Bershka','www.bershka.com'),(6,'Tom Tailor','www.tom-tailor.com'),(7,'Mark Formele','www.mark-formele.by'),(8,'Белинвест','www.belinvest.com'),(9,'Марко','www.marko.com'),(10,'Мегатоп','www.megatop.by');
/*!40000 ALTER TABLE `brandInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id_Client` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) NOT NULL,
  `phoneNumber` varchar(25) NOT NULL,
  `address` varchar(100) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `birthday` date NOT NULL,
  `id_Relative` int DEFAULT NULL,
  `id_Rating` int DEFAULT NULL,
  PRIMARY KEY (`id_Client`),
  KEY `clients_ibfk_1` (`id_Rating`),
  KEY `clients_ibfk_2` (`id_Relative`),
  CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`id_Rating`) REFERENCES `clientsRating` (`id_ClientsRating`) ON DELETE CASCADE,
  CONSTRAINT `clients_ibfk_2` FOREIGN KEY (`id_Relative`) REFERENCES `clientsRelatives` (`id_ClientsRelatives`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Дан С.Л.','+375291234567','Пушкинская 42, кв.7','johndoe123@gmail.com','1967-03-03',10,10),(2,'Вольт Е.И.','+375292345678','Ольшевского 43, кв.8','sarahsmith456@hotmail.com','1967-04-04',9,9),(3,'Одинцов Г.В.','+375293456789','Победителей 94, кв.9','alexanderjones789@yahoo.com','1943-05-05',8,8),(4,'Пихта Г.О.','+375294567890','Независимости 7, кв.10','emilywilson321@outlook.com','1976-06-06',7,7),(5,'Денус Г.В.','+375295678901','Макаенка 12, кв.392','davidthompson234@protonmail.com','1980-07-07',6,6),(6,'Пачка О.В','+375296789012','Аэродромная 42, кв.8','lisabrown678@gmail.com','1982-01-01',5,5),(7,'Денус В.В.','+375297890123','Центральная 87, кв. 22','michaeljohnson987@yahoo.com','1980-02-02',4,4),(8,'Горло О.С.','+375298901234','Маркса 65, кв.8','sophiamiller567@outlook.com','1990-08-08',3,3),(9,'Музин Г.Л.','+375299012345','Ленина 22, кв.10','williamtaylor123@gmail.com','1992-10-10',2,2),(10,'Бычкалова О.Г.','+375290123456','Калинина 83, кв.99','oliviarobinson456@yahoo.com','1999-12-12',1,1),(11,'Курьян А.В.','+375291631859','Макаенка 12В','super.tosh2016`2yandex.by','2004-04-09',NULL,NULL),(12,'Курьян А.В.','3854932932','Макаенка 12','super,tosh2016@yandex.by','2023-06-17',11,1);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientsRating`
--

DROP TABLE IF EXISTS `clientsRating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientsRating` (
  `id_ClientsRating` int NOT NULL AUTO_INCREMENT,
  `quantityOrders` int NOT NULL,
  `rating` int DEFAULT NULL,
  PRIMARY KEY (`id_ClientsRating`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientsRating`
--

LOCK TABLES `clientsRating` WRITE;
/*!40000 ALTER TABLE `clientsRating` DISABLE KEYS */;
INSERT INTO `clientsRating` VALUES (1,3,5),(2,10,9),(3,2,5),(4,1,6),(5,5,6),(6,3,8),(7,1,6),(8,4,8),(9,4,10),(10,2,1);
/*!40000 ALTER TABLE `clientsRating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientsRelatives`
--

DROP TABLE IF EXISTS `clientsRelatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientsRelatives` (
  `id_ClientsRelatives` int NOT NULL AUTO_INCREMENT,
  `fullnameRelative` varchar(45) NOT NULL,
  `phoneNumber` varchar(25) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id_ClientsRelatives`),
  KEY `fullname` (`fullnameRelative`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientsRelatives`
--

LOCK TABLES `clientsRelatives` WRITE;
/*!40000 ALTER TABLE `clientsRelatives` DISABLE KEYS */;
INSERT INTO `clientsRelatives` VALUES (1,'Бычкалов О.В.','+375291849574','Мать'),(2,'Музин В.И.','+375291849572','Отец'),(3,'Горло Е.Н.','+375291849577','Отчим'),(4,'Денус О.О.','+375291849570','Сестра'),(5,'Пачка Г.В.','+375291849579','Брат'),(6,'Дунько В.А.','+375291849571','Бабушка'),(7,'Яблык Е.Н.','+375291849576','Дедушка'),(8,'Марун Л.П.','+375291849578','Отец'),(9,'Одинцов Ш.В.','+375291849575','Мать'),(10,'Пихта Л.Д.','+375291849573','Брат'),(11,'Курьян В.В.','37592848439','Отец');
/*!40000 ALTER TABLE `clientsRelatives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliverymans`
--

DROP TABLE IF EXISTS `deliverymans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliverymans` (
  `id_Deliverysmans` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(45) NOT NULL,
  `phoneNumber` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id_Deliverysmans`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliverymans`
--

LOCK TABLES `deliverymans` WRITE;
/*!40000 ALTER TABLE `deliverymans` DISABLE KEYS */;
INSERT INTO `deliverymans` VALUES (1,'Петров П.А.','+375295671234','oliviarobinson456@yahoo.com'),(2,'Иванов И.И.','+375290008765','sarahsmith456@hotmail.com'),(3,'Сидоров А.С.','+375290003456','alexanderjones789@yahoo.com'),(4,'Козлов В.М.','+375290006789','emilywilson321@outlook.com'),(5,'Зайцева Е.В.','+375290002345','davidthompson234@protonmail.com'),(6,'Смирнова Н.И.','+375290009876','lisabrown678@gmail.com'),(7,'Ковалева Л.П.','+375290004321','michaeljohnson987@yahoo.com'),(8,'Морозов Д.Г.','+375290007654','sophiamiller567@outlook.com'),(9,'Николаев И.В.','+375290005678','williamtaylor123@gmail.com'),(10,'Лебедева А.Н.','+375290001987','oliviarobinson456@yahoo.com');
/*!40000 ALTER TABLE `deliverymans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `experienceworker`
--

DROP TABLE IF EXISTS `experienceworker`;
/*!50001 DROP VIEW IF EXISTS `experienceworker`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `experienceworker` AS SELECT 
 1 AS `ФИО работника`,
 1 AS `Дата начала работы`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `gender_count`
--

DROP TABLE IF EXISTS `gender_count`;
/*!50001 DROP VIEW IF EXISTS `gender_count`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `gender_count` AS SELECT 
 1 AS `Пол`,
 1 AS `Количество`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `highclientsrate`
--

DROP TABLE IF EXISTS `highclientsrate`;
/*!50001 DROP VIEW IF EXISTS `highclientsrate`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `highclientsrate` AS SELECT 
 1 AS `ФИО клиента`,
 1 AS `Рейтинг`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `material_count`
--

DROP TABLE IF EXISTS `material_count`;
/*!50001 DROP VIEW IF EXISTS `material_count`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `material_count` AS SELECT 
 1 AS `Материал`,
 1 AS `Количество`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id_Orders` int NOT NULL AUTO_INCREMENT,
  `id_Clients` int NOT NULL,
  `id_Shoes` int NOT NULL,
  `id_Workers` int NOT NULL,
  `id_Deliverymans` int DEFAULT NULL,
  `date_Order` date NOT NULL,
  `date_Return` date NOT NULL,
  `Price` int NOT NULL,
  PRIMARY KEY (`id_Orders`),
  KEY `orders_ibfk_1` (`id_Workers`),
  KEY `orders_ibfk_2` (`id_Clients`),
  KEY `orders_ibfk_3` (`id_Shoes`),
  KEY `orders_ibfk_4` (`id_Deliverymans`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`id_Workers`) REFERENCES `workers` (`id_Worker`) ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`id_Clients`) REFERENCES `clients` (`id_Client`) ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`id_Shoes`) REFERENCES `shoes` (`id_Shoe`) ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`id_Deliverymans`) REFERENCES `deliverymans` (`id_Deliverysmans`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,1,1,'2023-05-10','2023-05-12',100),(2,2,2,2,2,'2023-05-11','2023-05-13',200),(3,3,3,3,3,'2023-05-12','2023-05-14',300),(4,4,4,4,4,'2023-05-13','2023-05-15',2000),(5,5,5,5,5,'2023-05-14','2023-05-16',4000),(6,6,6,6,6,'2023-05-15','2023-05-17',1000),(7,7,7,7,7,'2023-05-16','2023-05-18',100),(8,8,8,8,8,'2023-05-17','2023-05-19',200),(9,9,9,9,9,'2023-05-18','2023-05-20',6000),(10,10,10,10,10,'2023-05-19','2023-05-21',899);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ordersinfo`
--

DROP TABLE IF EXISTS `ordersinfo`;
/*!50001 DROP VIEW IF EXISTS `ordersinfo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ordersinfo` AS SELECT 
 1 AS `ФИО работника`,
 1 AS `ФИО клиента`,
 1 AS `Дата заказа`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `shoes`
--

DROP TABLE IF EXISTS `shoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shoes` (
  `id_Shoe` int NOT NULL AUTO_INCREMENT,
  `id_Brands` int NOT NULL,
  `material` varchar(45) NOT NULL,
  `season` varchar(45) DEFAULT NULL,
  `type` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL,
  `shoes_condition` varchar(45) NOT NULL,
  PRIMARY KEY (`id_Shoe`),
  KEY `shoes_ibfk_1` (`id_Brands`),
  KEY `cond` (`shoes_condition`),
  CONSTRAINT `shoes_ibfk_1` FOREIGN KEY (`id_Brands`) REFERENCES `brandInfo` (`id_Brand`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoes`
--

LOCK TABLES `shoes` WRITE;
/*!40000 ALTER TABLE `shoes` DISABLE KEYS */;
INSERT INTO `shoes` VALUES (1,10,'Кожа','Лето','Босоножки','Женский','Новые'),(2,9,'Кожзам','Зима','Ботинки','Мужской','Немного бу'),(3,8,'Текстиль','Весна','Кроссовки','Мужской','Практически изношены'),(4,7,'Нубук','Осень','Кроссовки','Мужской','Новые'),(5,6,'Замша','Весна','Босоножки','Женский','Сильно ношенные'),(6,1,'Кожа','Осень','Ботинки','Женский','Новые'),(7,2,'Замша','Лето','Кроссовки','Мужской','Изношены'),(8,3,'Нубук','Зима','Ботинки','Женский','Новые'),(9,4,'Кожзам','Осень','Кеды','Женский','Новые'),(10,5,'Нубук','Деми','Кроссовки','Женский','Немного бу');
/*!40000 ALTER TABLE `shoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `login` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'h','$2a$07$9J1VS9O.KRDBUPWZ.cr6iOOY6FLH0sLVPEwG.Vdjdjd/sqbFvwbDi','user'),(2,'anton','$2a$07$Wc/UQKboeR1ZcTYNbnRb8OVdwQ0rQLl.nEp5Z1LokEHTIdRlUYSMC','admin'),(19,'han','$2a$07$zar2u70ibRBUnj.zwmyuwOQDW50kkZhITkc1He0sAdBLURmozzSo.','user'),(20,'vsev4ik','$2a$07$q9o/H26JVQ5WAbSIZZP1x.Pv2imQ4uJrl8NSVXRYf8VGHYn2hVqTa',NULL),(21,'maksim','$2a$07$LwgZc/6BMYPiaI0iJ74tgu5zWiM8ZlDtIa4mx9UK61C4Rt.Lyvede','admin'),(22,'hanna','$2a$07$JEamPotsygi8sC9Rlst3ku422nUr4RE0FY9DPLsRggR.WEwE1t4e.','user'),(23,'uy','$2a$07$T99bXZX1em04IYs2Nzuzq.3svMjznEDoHTGXW9hj0zxFJE2Kzzz9y','admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workers`
--

DROP TABLE IF EXISTS `workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workers` (
  `id_Worker` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(35) NOT NULL,
  `phoneNumber` varchar(19) NOT NULL,
  `address` varchar(60) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `date_start` datetime NOT NULL,
  `children` int DEFAULT NULL,
  PRIMARY KEY (`id_Worker`),
  KEY `number` (`phoneNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workers`
--

LOCK TABLES `workers` WRITE;
/*!40000 ALTER TABLE `workers` DISABLE KEYS */;
INSERT INTO `workers` VALUES (1,'Лебедева Л.А.','+375291234567','Новополоцкая 54, кв.82','johnsmith1234@gmail.com','2014-01-01 00:00:00',10),(2,'Николаев Н.И.','+375292345678','Макаенка 12, кв.87','alexbrown4321@gmail.com','2015-02-02 00:00:00',5),(3,'Морозов М.Г.','+375293456789','Карла Маркса 88, кв.8','emilyjones9876@outlook.com','2016-03-03 00:00:00',6),(4,'Ковалева К.П.','+375294567890','Кузьмы Черного 77, кв.10',' davidthoon2345@yahoo.com','2015-04-04 00:00:00',2),(5,'Смирнова С.И.','+375295678901','Независимости 21, кв.2','lisasmith8765@gmail.com','2017-04-04 00:00:00',7),(6,'Козлов К.М.','+375296789012','Победителей 6, кв.7','michaeljohnson5432@outlook.com','2018-05-05 00:00:00',2),(7,'Зайцева З.Н.','+375297890123','Одинцова 43, кв.21','sophiamiller2109@yahoo.com','2020-06-06 00:00:00',4),(8,'Сидоров С.Д.','+375298901234','Макаенка 77, кв.99','williamtaylor6789@gmail.com','2010-04-05 00:00:00',0),(9,'Петров П.А.','+375299012345','Лобонка 6, кв.88','oliviawilson4567@yahoo.com','2019-09-09 00:00:00',1),(10,'Иванов И.В.','+375290123456','Петровская 77','johnsmith1234@gmail.com','2021-10-10 00:00:00',1);
/*!40000 ALTER TABLE `workers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workersChildren`
--

DROP TABLE IF EXISTS `workersChildren`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workersChildren` (
  `id_WorkersChildren` int NOT NULL AUTO_INCREMENT COMMENT 'При добавлении работника добавлять ребенка с такой же фамилией ',
  `fullname` varchar(45) DEFAULT NULL,
  `school` varchar(45) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `id_Worker` int NOT NULL,
  PRIMARY KEY (`id_WorkersChildren`),
  KEY `workerschildren_ibfk_1` (`id_Worker`),
  CONSTRAINT `workerschildren_ibfk_1` FOREIGN KEY (`id_Worker`) REFERENCES `workers` (`id_Worker`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workersChildren`
--

LOCK TABLES `workersChildren` WRITE;
/*!40000 ALTER TABLE `workersChildren` DISABLE KEYS */;
INSERT INTO `workersChildren` VALUES (1,'Мудрец Ю.В.','Среднаяя школа 11','2008-01-01',1),(2,'Карен Г.В.','Гимназия 2','2008-02-02',1),(3,'Бутька Ш.Ш.','Средняя школа 181','2008-03-03',2),(4,'Нук Е.В.','Гимназия 7','2008-04-04',3),(5,'Олег Н.В.','Среднаяя школа 29','2008-05-05',4),(6,'Маска Г.О.','Средняя школа 98','2008-06-06',1),(7,'Спичка Г.В.','Гимназия 1','2008-07-07',5),(8,'Медаль О.Г.','Гимназия 1','2008-08-08',3),(9,'Мак Ш.Л.','Средняя школа 92','2008-09-09',4),(10,'Олень З.З.','Гимназия 99','2008-10-10',7),(18,'Вилка И.Р.','Средняя школа 2','2023-05-12',3),(19,'Вилка В.В.','Средняя школа 10','2023-06-03',2),(20,'Дед Е.Д.','Средняя школа 9','2023-06-10',1);
/*!40000 ALTER TABLE `workersChildren` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_children` AFTER INSERT ON `workerschildren` FOR EACH ROW BEGIN
    UPDATE workers
    SET children = children + 1
    WHERE id_Worker = NEW.id_Worker;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'workshop'
--

--
-- Dumping routines for database 'workshop'
--

--
-- Final view structure for view `experienceworker`
--

/*!50001 DROP VIEW IF EXISTS `experienceworker`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `experienceworker` AS select `workers`.`fullname` AS `ФИО работника`,`workers`.`date_start` AS `Дата начала работы` from `workers` where (`workers`.`date_start` < '2015-01-01') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `gender_count`
--

/*!50001 DROP VIEW IF EXISTS `gender_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `gender_count` AS select `shoes`.`gender` AS `Пол`,count(0) AS `Количество` from `shoes` group by `shoes`.`gender` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `highclientsrate`
--

/*!50001 DROP VIEW IF EXISTS `highclientsrate`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `highclientsrate` AS select `clients`.`fullname` AS `ФИО клиента`,`clientsrating`.`rating` AS `Рейтинг` from (`clients` join `clientsrating` on((`clients`.`id_Rating` = `clientsrating`.`id_ClientsRating`))) where (`clientsrating`.`rating` > 6) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `material_count`
--

/*!50001 DROP VIEW IF EXISTS `material_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `material_count` AS select `shoes`.`material` AS `Материал`,count(0) AS `Количество` from `shoes` group by `shoes`.`material` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ordersinfo`
--

/*!50001 DROP VIEW IF EXISTS `ordersinfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ordersinfo` AS select `workers`.`fullname` AS `ФИО работника`,`clients`.`fullname` AS `ФИО клиента`,`orders`.`date_Order` AS `Дата заказа` from ((`orders` join `workers` on((`orders`.`id_Workers` = `workers`.`id_Worker`))) join `clients` on((`orders`.`id_Clients` = `clients`.`id_Client`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-07 23:36:32
