-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: wileyProject
-- ------------------------------------------------------
-- Server version	8.0.25-0ubuntu0.20.04.1

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
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `quantity` float NOT NULL DEFAULT '0',
  `wallet_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_wallet_id_idx` (`wallet_id`),
  KEY `inventory_item_id_idx` (`item_id`),
  CONSTRAINT `inventory_item_id` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `inventory_wallet_id` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,5,677799,24),(2,7,10248600,42),(3,8,20037700,37),(4,4,40980500,13),(5,3,945097,48),(6,1,6415690,5),(7,8,23975800,44);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `added_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'bitcoin','b001',1,'2021-08-06 08:58:11'),(2,'Litecoin','L001',1,'2021-08-06 08:58:12'),(3,'XRP','x001',1,'2021-08-06 08:58:12'),(4,'Cardano','c001',1,'2021-08-06 08:58:12'),(5,'bitcoin cash','b002',1,'2021-08-06 08:58:12'),(6,'Tether','t001',1,'2021-08-06 08:58:12'),(7,'Dogecoin','d001',1,'2021-08-06 08:58:12'),(8,'PutinCoin','p001',1,'2021-08-06 08:58:12'),(9,'Polkadot','p002',0,'2021-08-06 08:58:13'),(10,'Whoppercoin','w001',0,'2021-08-06 08:58:13');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `wallet_id` int DEFAULT NULL,
  `status` enum('pending','complete','cancelled') NOT NULL,
  `item_id` int DEFAULT NULL,
  `type` enum('buy','sell') DEFAULT NULL,
  `order_price` float DEFAULT NULL,
  `order_quantity` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `executed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `orders_wallet_id` (`wallet_id`),
  KEY `fk_trade_transaction_item` (`item_id`),
  CONSTRAINT `fk_trade_transaction_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `orders_wallet_id` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,25,'cancelled',7,'buy',36647,570.33,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(2,32,'pending',8,'sell',34000,64.06,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(3,31,'cancelled',3,'buy',43136,209.27,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(4,14,'pending',8,'buy',14319,652.45,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(5,10,'pending',2,'sell',29155,843.57,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(6,25,'complete',8,'sell',12235,237.71,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(7,24,'complete',5,'buy',41029,16.52,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(8,42,'complete',7,'buy',43432,235.97,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(9,37,'complete',8,'buy',26748,749.13,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(10,33,'cancelled',8,'buy',10301,148.95,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(11,13,'complete',4,'buy',49240,832.26,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(12,2,'complete',9,'sell',16058,384.21,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(13,45,'cancelled',8,'buy',6408,724.82,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(14,24,'pending',8,'buy',45520,531.91,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(15,20,'cancelled',9,'buy',20998,441.02,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(16,48,'complete',3,'buy',3599,262.6,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(17,30,'pending',7,'buy',48574,977.22,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(18,46,'cancelled',6,'buy',19601,104.68,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(19,35,'complete',3,'sell',49743,906.35,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(20,35,'pending',4,'buy',11445,914.09,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(21,5,'complete',1,'buy',7644,839.31,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(22,50,'cancelled',4,'buy',187,436.1,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(23,13,'cancelled',6,'sell',33076,494.95,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(24,44,'complete',8,'buy',48276,496.64,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(25,3,'cancelled',1,'sell',33820,672.14,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(26,45,'cancelled',5,'buy',36681,322.33,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(27,11,'pending',3,'buy',61,285.19,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(28,29,'cancelled',6,'sell',7250,330.76,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(29,5,'cancelled',4,'buy',12072,80.12,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(30,29,'complete',7,'sell',19751,155.84,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(31,39,'pending',8,'sell',13225,452.55,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(32,30,'cancelled',9,'buy',35354,689.23,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(33,25,'cancelled',7,'sell',20326,20.98,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(34,11,'complete',4,'sell',27865,343.95,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(35,1,'cancelled',9,'buy',4951,817.86,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(36,8,'complete',1,'sell',40310,402.76,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(37,11,'cancelled',7,'buy',47749,999.6,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(38,43,'complete',9,'sell',39222,741.62,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(39,6,'pending',3,'buy',14648,110.8,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(40,28,'cancelled',1,'sell',38558,455.42,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(41,33,'pending',9,'sell',28577,921.41,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(42,22,'cancelled',1,'buy',3687,346.26,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(43,34,'complete',4,'sell',12963,459.87,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(44,23,'pending',3,'sell',16433,174.69,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(45,32,'cancelled',1,'sell',28198,644.25,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(46,2,'complete',1,'sell',44776,478.15,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(47,19,'pending',5,'buy',48145,335.71,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(48,24,'pending',3,'buy',38403,343.58,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(49,32,'cancelled',6,'sell',25894,377.43,'2021-08-06 10:32:34','2021-08-06 10:32:34'),(50,3,'cancelled',3,'sell',36346,907.99,'2021-08-06 10:32:34','2021-08-06 10:32:34');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`devansh`@`localhost`*/ /*!50003 TRIGGER `populateInventory` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
	if(new.status='complete')then
		if exists (select * from inventory where item_id=new.item_id and wallet_id=new.wallet_id)then 
			if(new.type='sell')then
				update inventory 
				set quantity=quantity-new.order_quantity*new.order_price
				where item_id=new.item_id and wallet_id=new.wallet_id;
			else
				update inventory 
				set quantity=quantity+new.order_quantity*new.order_price
				where item_id=new.item_id and wallet_id=new.wallet_id;
			end if;
		else
			if(new.type='buy')then
				insert into inventory(wallet_id,item_id,quantity)
				values(new.wallet_id,new.item_id,new.order_quantity*new.order_price);
			end if;
		end if;
    end if;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`devansh`@`localhost`*/ /*!50003 TRIGGER `updateInventory` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
if(new.status='complete')then
		if exists (select * from inventory where item_id=new.item_id and wallet_id=new.wallet_id)then 
			if(new.type='sell')then
				update inventory 
				set quantity=quantity-new.order_quantity*new.order_price
				where item_id=new.item_id and wallet_id=new.wallet_id;
			else
				update inventory 
				set quantity=quantity+new.order_quantity*new.order_price
				where item_id=new.item_id and wallet_id=new.wallet_id;
			end if;
		else
			if(new.type='buy')then
				insert into inventory(wallet_id,item_id,quantity)
				values(new.wallet_id,new.item_id,new.order_quantity*new.order_price);
			end if;
		end if;
    end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(256) DEFAULT NULL,
  `account_no` varchar(45) DEFAULT NULL,
  `pan_number` varchar(45) DEFAULT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `account_no_UNIQUE` (`account_no`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`),
  UNIQUE KEY `pan_number_UNIQUE` (`pan_number`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='This table is for storing user account details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Eilene  ','Eilene  12@gmail.com','654fa8f35246aae143e037252ae6acec','16439128558','wum89kt1cb','71013047009','2021-08-06 08:57:56'),(2,'Allen  ','Allen  12@gmail.com','0bc4d73bc90629170bb21dc59ad48ef0','97652643536','4zdby5hwjv','19140480480','2021-08-06 08:57:56'),(3,'Miguelina  ','Miguelina  12@gmail.com','f05ef4e92b58a78129cc35c73eea1343','63992392186','8e739yt9kz','61510668244','2021-08-06 08:57:56'),(4,'Giovanni  ','Giovanni  12@gmail.com','0360484e0b0550aee79e6433427f3063','40747646280','4ch56utvfq','11833673913','2021-08-06 08:57:56'),(5,'Nadia  ','Nadia  12@gmail.com','5f66f36b1ccd122956ad0cf259af2145','36997369318','mk448w1t6o','24500323920','2021-08-06 08:57:56'),(6,'Zola  ','Zola  12@gmail.com','c66bd45c86644b7b5297b11672efc1e2','68259899008','y8dzbw3kwo','18346586186','2021-08-06 08:57:56'),(7,'Jeannie  ','Jeannie  12@gmail.com','721b43005299d7991d0f0368e8ddeb94','45867315967','6fjuvfjty1','10554771219','2021-08-06 08:57:56'),(8,'Jordon  ','Jordon  12@gmail.com','8ee658d54128d9e770e67ae729a2da42','10304191894','uzzmo26hsh','57272355176','2021-08-06 08:57:56'),(9,'Lezlie  ','Lezlie  12@gmail.com','21c4232eb0c2494803d42f0c1084825c','43647796961','s09w09295r','52817593159','2021-08-06 08:57:56'),(10,'Patience  ','Patience  12@gmail.com','c20d105f03869f6b99d578be3c457fdc','87748158693','06lv51w30o','89987834018','2021-08-06 08:57:56'),(11,'Raelene  ','Raelene  12@gmail.com','787dc7cadf45940a2e253c03bb2aceba','23832226059','72q5ubp1kj','66998569384','2021-08-06 08:57:56'),(12,'Leticia  ','Leticia  12@gmail.com','fe641e4e40ca18a6e3ecb5c6e979f6ef','58293894341','4pbik9b30l','13152008673','2021-08-06 08:57:56'),(13,'Agatha  ','Agatha  12@gmail.com','0a38700aaa2b6259e5217659bdd5704b','54713995511','b45iai5lyu','24520215823','2021-08-06 08:57:56'),(14,'Hershel  ','Hershel  12@gmail.com','fe284d4da88460ff6e56b7ed0e8ef171','53557073852','4gth5gqdud','96325890890','2021-08-06 08:57:56'),(15,'Elidia  ','Elidia  12@gmail.com','74d674408428a79418f092ea89601e50','88858187309','ii9p1aoz2p','71379294017','2021-08-06 08:57:56'),(16,'Leigh  ','Leigh  12@gmail.com','f0a8da44844bce8cfbf1f4ba949323ca','66645481259','uy1ez36w0g','20141385765','2021-08-06 08:57:56'),(17,'Caren  ','Caren  12@gmail.com','87cdf3d89f4cad8297209d6651f4b53b','24695881322','j1lklww6lj','49301793921','2021-08-06 08:57:56'),(18,'Lashawnda  ','Lashawnda  12@gmail.com','17bdca130ae63b3bf46b72559e168029','64862002049','58sordh5ky','44562516889','2021-08-06 08:57:56'),(19,'Tillie  ','Tillie  12@gmail.com','451602d4890b8a6f0999c699ad567a73','98184684791','xmqeb609yu','84699088634','2021-08-06 08:57:56'),(20,'Alvina  ','Alvina  12@gmail.com','5ca9b21cfa94a88ff4be13bc537340a5','66730823752','5um65odeg1','86706442441','2021-08-06 08:57:56'),(21,'Isabel  ','Isabel  12@gmail.com','2d5778ecf87a45d66503308d4a068622','44483275876','p4nlti75s3','21943644864','2021-08-06 08:57:56'),(22,'Kelli  ','Kelli  12@gmail.com','a808a980d87589cf3ebfc6cd07645fa0','54631799251','gd16elfgy1','81644698324','2021-08-06 08:57:56'),(23,'Krystin  ','Krystin  12@gmail.com','6c94678330cabe048be07113e30ee2da','19404504269','6gbkapp75d','41771786789','2021-08-06 08:57:56'),(24,'Marx  ','Marx  12@gmail.com','f8a6b8286668d73fa154c47ea3598b28','52818635559','zpx0aa9ifm','63585475443','2021-08-06 08:57:56'),(25,'Angelia  ','Angelia  12@gmail.com','4046ed9691b14b965299dfd4e2b7760b','29309688758','5n8ivfh9un','78327985052','2021-08-06 08:57:56'),(26,'Olivia  ','Olivia  12@gmail.com','4e27abc8f0ecd60c792f0ea9448354e5','52393703960','r60imxlnqj','41484485937','2021-08-06 08:57:56'),(27,'Reta  ','Reta  12@gmail.com','495183db6c1eb2c840ae11f678230cd2','44880086155','jc09pa7snt','89316938128','2021-08-06 08:57:56'),(28,'Chastity  ','Chastity  12@gmail.com','5b2af91956a4e57cdd255dadceb6323a','31124576260','w1x1pasxm1','45362428464','2021-08-06 08:57:56'),(29,'Leonila  ','Leonila  12@gmail.com','153e0b60d25a803241cabb824efd012d','48840979382','gyvtifefga','79456496567','2021-08-06 08:57:56'),(30,'Terri  ','Terri  12@gmail.com','b50b2b3e3fbf05cc7d1ecce474e9c968','77513174570','4rbq7m8j8o','69070024763','2021-08-06 08:57:56'),(31,'Willis  ','Willis  12@gmail.com','bb9491ab8a572cf4d8f3a3e7b9b7c3a4','24199455332','cvk8fnj17s','62189328333','2021-08-06 08:57:56'),(32,'Tanna  ','Tanna  12@gmail.com','b18d8f307596079864af127e0eb11240','40345194463','mnumc198bg','32270242489','2021-08-06 08:57:56'),(33,'Debi  ','Debi  12@gmail.com','01cb104ccf30f7d3267282f091b1febd','20756766164','lr6go2xn9r','88295406092','2021-08-06 08:57:56'),(34,'Lanell  ','Lanell  12@gmail.com','aa56ce7549d4d39fc8b4ea050a15772c','80527641163','1i968fi2wt','83432787472','2021-08-06 08:57:56'),(35,'Obdulia  ','Obdulia  12@gmail.com','29bf5c4ef22a3ecc0f2fd7a33538a8e6','84473035218','682a2ohozi','41042970039','2021-08-06 08:57:56'),(36,'Mandi  ','Mandi  12@gmail.com','fc590ff53ca08add209e4205db0f3f00','47334803035','det9ycgpaq','80306259991','2021-08-06 08:57:56'),(37,'Raquel  ','Raquel  12@gmail.com','83bfccdc7a760e97442cf18aba65fd44','76340216662','ajzenffgrh','70560481419','2021-08-06 08:57:56'),(38,'Adolfo  ','Adolfo  12@gmail.com','63b13009f56e51f35d3eb832b808c317','51200178659','aq5p2phbb5','45798485543','2021-08-06 08:57:56'),(39,'Jason  ','Jason  12@gmail.com','3b969cd0d95a176c67608e99eea364f4','56973922559','kn3ba66ya9','25146092231','2021-08-06 08:57:56'),(40,'Vanda  ','Vanda  12@gmail.com','68af12cbcc71a2650a9ce74cd4e109bf','56118169738','ywv14kqkqw','40630028830','2021-08-06 08:57:56'),(41,'Daine  ','Daine  12@gmail.com','d2df688c161d148079cdfba619fbbcab','27564420204','uryo0y5njs','54814114927','2021-08-06 08:57:56'),(42,'Myles  ','Myles  12@gmail.com','83ad84e2e432460e5aa8077b1ab66956','29735033671','nr15we4bui','90413533157','2021-08-06 08:57:56'),(43,'Jesse  ','Jesse  12@gmail.com','2c31b2379206c6edeff579606b6003da','32247593989','vufb9wirtc','27457002879','2021-08-06 08:57:56'),(44,'Hester  ','Hester  12@gmail.com','65a5aca76789bdd1f97ea10fa8892122','46086318328','1d004457vm','79847393827','2021-08-06 08:57:56'),(45,'Sid  ','Sid  12@gmail.com','9892ad4d6e4c3e121abbf55776015c54','61047534286','4xvgciezqq','20845360327','2021-08-06 08:57:56'),(46,'Gabrielle  ','Gabrielle  12@gmail.com','90006a0c7a40e65d3b5f70461b17acbc','74465202406','32opxxyycs','81300757830','2021-08-06 08:57:56'),(47,'Mendy  ','Mendy  12@gmail.com','92a0555383ccbeedb60d31172595f212','29941559040','uk7xzayq8n','97867394211','2021-08-06 08:57:56'),(48,'Concepcion  ','Concepcion  12@gmail.com','143a4ec63f163eb8fe9afd53a3108236','49134742692','3qixpy72nw','63632215775','2021-08-06 08:57:56'),(49,'Nathan  ','Nathan  12@gmail.com','98fca7786be787f2c907f5839a1d819a','92630767045','xwqwo4svef','50800380111','2021-08-06 08:57:56'),(50,'Jacqualine  ','Jacqualine  12@gmail.com','83a730361437694922bf61bbdc1e9829','35650123904','wezyc3qb2x','82885766155','2021-08-06 08:57:56');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_transactions`
--

DROP TABLE IF EXISTS `wallet_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('debit','credit') NOT NULL,
  `wallet_id` int NOT NULL,
  `amount` float NOT NULL,
  `status` enum('pending','complete','failed') NOT NULL,
  `mode` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `wallets_transaction_wallet_id_idx` (`wallet_id`),
  CONSTRAINT `wallets_transaction_wallet_id` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_transactions`
--

LOCK TABLES `wallet_transactions` WRITE;
/*!40000 ALTER TABLE `wallet_transactions` DISABLE KEYS */;
INSERT INTO `wallet_transactions` VALUES (1,'credit',1,1000,'failed','UPI','2021-08-06 08:58:13'),(2,'debit',2,2000,'complete','UPI','2021-08-06 08:58:13'),(3,'credit',3,3000,'failed','UPI','2021-08-06 08:58:13'),(4,'debit',4,4000,'complete','UPI','2021-08-06 08:58:13'),(5,'credit',5,5000,'failed','UPI','2021-08-06 08:58:14'),(6,'debit',6,6000,'complete','UPI','2021-08-06 08:58:14'),(7,'credit',7,7000,'failed','UPI','2021-08-06 08:58:14'),(8,'debit',8,8000,'complete','UPI','2021-08-06 08:58:14'),(9,'credit',9,9000,'failed','UPI','2021-08-06 08:58:14'),(10,'debit',10,10000,'complete','UPI','2021-08-06 08:58:14'),(11,'credit',11,11000,'failed','UPI','2021-08-06 08:58:15'),(12,'debit',12,12000,'complete','UPI','2021-08-06 08:58:15'),(13,'credit',13,13000,'failed','UPI','2021-08-06 08:58:15'),(14,'debit',14,14000,'complete','UPI','2021-08-06 08:58:15'),(15,'credit',15,15000,'failed','UPI','2021-08-06 08:58:15'),(16,'debit',16,16000,'complete','UPI','2021-08-06 08:58:15'),(17,'credit',17,17000,'failed','UPI','2021-08-06 08:58:16'),(18,'debit',18,18000,'complete','UPI','2021-08-06 08:58:16'),(19,'credit',19,19000,'failed','UPI','2021-08-06 08:58:16'),(20,'debit',20,20000,'complete','UPI','2021-08-06 08:58:16'),(21,'credit',21,21000,'failed','UPI','2021-08-06 08:58:16'),(22,'debit',22,22000,'complete','UPI','2021-08-06 08:58:16'),(23,'credit',23,23000,'failed','UPI','2021-08-06 08:58:17'),(24,'debit',24,24000,'complete','UPI','2021-08-06 08:58:17'),(25,'credit',25,25000,'failed','UPI','2021-08-06 08:58:17'),(26,'debit',26,26000,'complete','UPI','2021-08-06 08:58:17'),(27,'credit',27,27000,'failed','UPI','2021-08-06 08:58:18'),(28,'debit',28,28000,'complete','UPI','2021-08-06 08:58:18'),(29,'credit',29,29000,'failed','UPI','2021-08-06 08:58:18'),(30,'debit',30,30000,'complete','UPI','2021-08-06 08:58:18'),(31,'credit',31,31000,'failed','UPI','2021-08-06 08:58:19'),(32,'debit',32,32000,'complete','UPI','2021-08-06 08:58:19'),(33,'credit',33,33000,'failed','UPI','2021-08-06 08:58:19'),(34,'debit',34,34000,'complete','UPI','2021-08-06 08:58:19'),(35,'credit',35,35000,'failed','UPI','2021-08-06 08:58:19'),(36,'debit',36,36000,'complete','UPI','2021-08-06 08:58:20'),(37,'credit',37,37000,'failed','UPI','2021-08-06 08:58:20'),(38,'debit',38,38000,'complete','UPI','2021-08-06 08:58:20'),(39,'credit',39,39000,'failed','UPI','2021-08-06 08:58:20'),(40,'debit',40,40000,'complete','UPI','2021-08-06 08:58:20'),(41,'credit',41,41000,'failed','UPI','2021-08-06 08:58:21'),(42,'debit',42,42000,'complete','UPI','2021-08-06 08:58:21'),(43,'credit',43,43000,'failed','UPI','2021-08-06 08:58:21'),(44,'debit',44,44000,'complete','UPI','2021-08-06 08:58:21'),(45,'credit',45,45000,'failed','UPI','2021-08-06 08:58:21'),(46,'debit',46,46000,'complete','UPI','2021-08-06 08:58:21'),(47,'credit',47,47000,'failed','UPI','2021-08-06 08:58:22'),(48,'debit',48,48000,'complete','UPI','2021-08-06 08:58:22'),(49,'credit',49,49000,'failed','UPI','2021-08-06 08:58:22'),(50,'debit',50,50000,'complete','UPI','2021-08-06 08:58:22');
/*!40000 ALTER TABLE `wallet_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `currency_type` enum('INR','USD') NOT NULL,
  `amount` float NOT NULL DEFAULT '0',
  `status` enum('blocked','active','pending') DEFAULT 'pending',
  PRIMARY KEY (`id`),
  KEY `wallets_account_id_idx` (`account_id`),
  CONSTRAINT `wallets_account_id` FOREIGN KEY (`account_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='This contains data for user wallets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallets`
--

LOCK TABLES `wallets` WRITE;
/*!40000 ALTER TABLE `wallets` DISABLE KEYS */;
INSERT INTO `wallets` VALUES (1,1,'INR',2000,'active'),(2,2,'INR',3000,'active'),(3,3,'INR',4000,'active'),(4,4,'INR',5000,'active'),(5,5,'INR',6000,'active'),(6,6,'INR',7000,'active'),(7,7,'INR',8000,'active'),(8,8,'INR',9000,'active'),(9,9,'INR',10000,'active'),(10,10,'INR',11000,'active'),(11,11,'INR',12000,'active'),(12,12,'INR',13000,'active'),(13,13,'INR',14000,'active'),(14,14,'INR',15000,'active'),(15,15,'INR',16000,'active'),(16,16,'INR',17000,'active'),(17,17,'INR',18000,'active'),(18,18,'INR',19000,'active'),(19,19,'INR',20000,'active'),(20,20,'INR',1000,'active'),(21,21,'INR',2000,'active'),(22,22,'INR',3000,'active'),(23,23,'INR',4000,'active'),(24,24,'INR',5000,'active'),(25,25,'INR',6000,'active'),(26,26,'INR',7000,'active'),(27,27,'INR',8000,'active'),(28,28,'INR',9000,'active'),(29,29,'INR',10000,'active'),(30,30,'INR',11000,'active'),(31,31,'INR',12000,'active'),(32,32,'INR',13000,'active'),(33,33,'INR',14000,'active'),(34,34,'INR',15000,'active'),(35,35,'INR',16000,'active'),(36,36,'INR',17000,'active'),(37,37,'INR',18000,'active'),(38,38,'INR',19000,'active'),(39,39,'INR',20000,'active'),(40,40,'INR',1000,'active'),(41,41,'INR',2000,'active'),(42,42,'INR',3000,'active'),(43,43,'INR',4000,'active'),(44,44,'INR',5000,'active'),(45,45,'INR',6000,'active'),(46,46,'INR',7000,'active'),(47,47,'INR',8000,'active'),(48,48,'INR',9000,'active'),(49,49,'INR',10000,'active'),(50,50,'INR',11000,'active');
/*!40000 ALTER TABLE `wallets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'wileyProject'
--

--
-- Dumping routines for database 'wileyProject'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-06 16:17:41
