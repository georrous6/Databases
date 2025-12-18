-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: CryptofolioDB
-- ------------------------------------------------------
-- Server version	8.0.44-0ubuntu0.22.04.1

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
-- Table structure for table `BankAccount`
--

DROP TABLE IF EXISTS `BankAccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BankAccount` (
  `account_id` int NOT NULL,
  `encrypted_iban` varchar(45) NOT NULL,
  `holder_name` varchar(45) NOT NULL,
  `bank_name` varchar(45) NOT NULL,
  `provider_token` varchar(45) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`account_id`),
  KEY `fk_BankAccount_User1_idx` (`user_id`),
  CONSTRAINT `fk_BankAccount_User1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BankAccount`
--

LOCK TABLES `BankAccount` WRITE;
/*!40000 ALTER TABLE `BankAccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `BankAccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BankAccount_transfers_to_Wallet`
--

DROP TABLE IF EXISTS `BankAccount_transfers_to_Wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BankAccount_transfers_to_Wallet` (
  `account_id` int NOT NULL,
  `wallet_id` int NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `direction` bit(1) NOT NULL,
  `timestamp` timestamp(3) NOT NULL,
  PRIMARY KEY (`account_id`,`wallet_id`),
  KEY `fk_BankAccount_has_Wallet_Wallet1_idx` (`wallet_id`),
  KEY `fk_BankAccount_has_Wallet_BankAccount1_idx` (`account_id`),
  CONSTRAINT `fk_BankAccount_has_Wallet_BankAccount1` FOREIGN KEY (`account_id`) REFERENCES `BankAccount` (`account_id`),
  CONSTRAINT `fk_BankAccount_has_Wallet_Wallet1` FOREIGN KEY (`wallet_id`) REFERENCES `Wallet` (`wallet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BankAccount_transfers_to_Wallet`
--

LOCK TABLES `BankAccount_transfers_to_Wallet` WRITE;
/*!40000 ALTER TABLE `BankAccount_transfers_to_Wallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `BankAccount_transfers_to_Wallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Candlestick`
--

DROP TABLE IF EXISTS `Candlestick`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Candlestick` (
  `candle_id` int NOT NULL,
  `high_price` decimal(3,0) NOT NULL,
  `low_price` decimal(3,0) NOT NULL,
  `open_price` decimal(3,0) NOT NULL,
  `close_price` decimal(3,0) NOT NULL,
  `interval` timestamp(3) NOT NULL,
  `volume` int NOT NULL,
  `ticker_symbol` int NOT NULL,
  PRIMARY KEY (`candle_id`,`ticker_symbol`),
  KEY `fk_Candlestick_Cryptocurrency1_idx` (`ticker_symbol`),
  CONSTRAINT `fk_Candlestick_Cryptocurrency1` FOREIGN KEY (`ticker_symbol`) REFERENCES `Cryptocurrency` (`ticker_symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Candlestick`
--

LOCK TABLES `Candlestick` WRITE;
/*!40000 ALTER TABLE `Candlestick` DISABLE KEYS */;
/*!40000 ALTER TABLE `Candlestick` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CryptoBalance`
--

DROP TABLE IF EXISTS `CryptoBalance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CryptoBalance` (
  `balance_id` int NOT NULL,
  `crypto_ammount` decimal(3,0) NOT NULL,
  `crypto_balance` decimal(3,0) NOT NULL,
  `wallet_id` int NOT NULL,
  PRIMARY KEY (`balance_id`,`wallet_id`),
  KEY `fk_CryptoBalance_Wallet1_idx` (`wallet_id`),
  CONSTRAINT `fk_CryptoBalance_Wallet1` FOREIGN KEY (`wallet_id`) REFERENCES `Wallet` (`wallet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CryptoBalance`
--

LOCK TABLES `CryptoBalance` WRITE;
/*!40000 ALTER TABLE `CryptoBalance` DISABLE KEYS */;
/*!40000 ALTER TABLE `CryptoBalance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CryptoHistory`
--

DROP TABLE IF EXISTS `CryptoHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CryptoHistory` (
  `history_id` int NOT NULL,
  `current_price` decimal(3,0) NOT NULL,
  `circulating_supply` int NOT NULL,
  `timestamp` timestamp(3) NOT NULL,
  `ticker_symbol` int NOT NULL,
  PRIMARY KEY (`history_id`,`ticker_symbol`),
  KEY `fk_CryptoHistory_Cryptocurrency1_idx` (`ticker_symbol`),
  CONSTRAINT `fk_CryptoHistory_Cryptocurrency1` FOREIGN KEY (`ticker_symbol`) REFERENCES `Cryptocurrency` (`ticker_symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CryptoHistory`
--

LOCK TABLES `CryptoHistory` WRITE;
/*!40000 ALTER TABLE `CryptoHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `CryptoHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cryptocurrency`
--

DROP TABLE IF EXISTS `Cryptocurrency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cryptocurrency` (
  `ticker_symbol` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `logo_image` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ticker_symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cryptocurrency`
--

LOCK TABLES `Cryptocurrency` WRITE;
/*!40000 ALTER TABLE `Cryptocurrency` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cryptocurrency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Invitation`
--

DROP TABLE IF EXISTS `Invitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Invitation` (
  `invitation_id` int NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `expires_at` datetime(3) NOT NULL,
  `status` enum('pending','accepted','rejected') NOT NULL,
  `inviter_id` int NOT NULL,
  `invitee_id` int NOT NULL,
  `wallet_id` int NOT NULL,
  PRIMARY KEY (`invitation_id`),
  KEY `fk_Invitation_User1_idx` (`inviter_id`),
  KEY `fk_Invitation_User2_idx` (`invitee_id`),
  KEY `fk_Invitation_Wallet1_idx` (`wallet_id`),
  CONSTRAINT `fk_Invitation_User1` FOREIGN KEY (`inviter_id`) REFERENCES `User` (`user_id`),
  CONSTRAINT `fk_Invitation_User2` FOREIGN KEY (`invitee_id`) REFERENCES `User` (`user_id`),
  CONSTRAINT `fk_Invitation_Wallet1` FOREIGN KEY (`wallet_id`) REFERENCES `Wallet` (`wallet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Invitation`
--

LOCK TABLES `Invitation` WRITE;
/*!40000 ALTER TABLE `Invitation` DISABLE KEYS */;
/*!40000 ALTER TABLE `Invitation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `user_id` int NOT NULL,
  `email` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `password_hash` varchar(45) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `registered_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_gets_alert_from_Cryptocurrency`
--

DROP TABLE IF EXISTS `User_gets_alert_from_Cryptocurrency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_gets_alert_from_Cryptocurrency` (
  `user_id` int NOT NULL,
  `ticker_symbol` int NOT NULL,
  `threshold_price` decimal(3,0) NOT NULL,
  `threshold_direction` bit(1) NOT NULL,
  `is_active` tinyint NOT NULL,
  `triggered_at` datetime(3) DEFAULT NULL,
  `alert_id` varchar(45) NOT NULL,
  PRIMARY KEY (`user_id`,`ticker_symbol`,`alert_id`),
  KEY `fk_User_has_Cryptocurrency_Cryptocurrency1_idx` (`ticker_symbol`),
  KEY `fk_User_has_Cryptocurrency_User1_idx` (`user_id`),
  CONSTRAINT `fk_User_has_Cryptocurrency_Cryptocurrency1` FOREIGN KEY (`ticker_symbol`) REFERENCES `Cryptocurrency` (`ticker_symbol`),
  CONSTRAINT `fk_User_has_Cryptocurrency_User1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_gets_alert_from_Cryptocurrency`
--

LOCK TABLES `User_gets_alert_from_Cryptocurrency` WRITE;
/*!40000 ALTER TABLE `User_gets_alert_from_Cryptocurrency` DISABLE KEYS */;
/*!40000 ALTER TABLE `User_gets_alert_from_Cryptocurrency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_has_Wallet`
--

DROP TABLE IF EXISTS `User_has_Wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_has_Wallet` (
  `user_id` int NOT NULL,
  `wallet_id` int NOT NULL,
  `role` enum('owner','member') DEFAULT NULL,
  PRIMARY KEY (`user_id`,`wallet_id`),
  KEY `fk_User_has_Wallet_Wallet1_idx` (`wallet_id`),
  KEY `fk_User_has_Wallet_User_idx` (`user_id`),
  CONSTRAINT `fk_User_has_Wallet_User` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
  CONSTRAINT `fk_User_has_Wallet_Wallet1` FOREIGN KEY (`wallet_id`) REFERENCES `Wallet` (`wallet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_has_Wallet`
--

LOCK TABLES `User_has_Wallet` WRITE;
/*!40000 ALTER TABLE `User_has_Wallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `User_has_Wallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_transacts_CryptoBalance`
--

DROP TABLE IF EXISTS `User_transacts_CryptoBalance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_transacts_CryptoBalance` (
  `user_id` int NOT NULL,
  `balance_id` int NOT NULL,
  `wallet_id` int NOT NULL,
  `amount` decimal(3,0) NOT NULL,
  `timestamp` timestamp(3) NOT NULL,
  `price_at_timestamp` decimal(3,0) NOT NULL,
  `transaction_hash` varchar(45) NOT NULL,
  `transaction_type` enum('buy','sell') NOT NULL,
  PRIMARY KEY (`user_id`,`balance_id`,`wallet_id`,`transaction_hash`),
  KEY `fk_User_has_CryptoBalance_CryptoBalance1_idx` (`balance_id`,`wallet_id`),
  KEY `fk_User_has_CryptoBalance_User1_idx` (`user_id`),
  CONSTRAINT `fk_User_has_CryptoBalance_CryptoBalance1` FOREIGN KEY (`balance_id`, `wallet_id`) REFERENCES `CryptoBalance` (`balance_id`, `wallet_id`),
  CONSTRAINT `fk_User_has_CryptoBalance_User1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_transacts_CryptoBalance`
--

LOCK TABLES `User_transacts_CryptoBalance` WRITE;
/*!40000 ALTER TABLE `User_transacts_CryptoBalance` DISABLE KEYS */;
/*!40000 ALTER TABLE `User_transacts_CryptoBalance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Wallet`
--

DROP TABLE IF EXISTS `Wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Wallet` (
  `wallet_id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `cash_balance` decimal(10,0) NOT NULL,
  PRIMARY KEY (`wallet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Wallet`
--

LOCK TABLES `Wallet` WRITE;
/*!40000 ALTER TABLE `Wallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `Wallet` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-18  3:31:57
