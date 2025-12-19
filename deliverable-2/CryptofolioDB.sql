-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema CryptofolioDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CryptofolioDB` ;

-- -----------------------------------------------------
-- Schema CryptofolioDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CryptofolioDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `CryptofolioDB` ;

-- -----------------------------------------------------
-- Table `CryptofolioDB`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`User` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`User` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(64) NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `password_hash` VARCHAR(256) NOT NULL,
  `phone` VARCHAR(64) NULL DEFAULT NULL,
  `registered_at` DATETIME(3) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`BankAccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`BankAccount` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`BankAccount` (
  `iban` VARCHAR(256) NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `holder_name` VARCHAR(64) NOT NULL,
  `bank_name` VARCHAR(64) NOT NULL,
  `provider_token` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`iban`),
  INDEX `fk_BankAccount_User1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_BankAccount_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Cryptocurrency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Cryptocurrency` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Cryptocurrency` (
  `ticker_symbol` VARCHAR(64) NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `logo_image` VARCHAR(512) NULL DEFAULT NULL,
  PRIMARY KEY (`ticker_symbol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Candlestick`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Candlestick` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Candlestick` (
  `ticker_symbol` VARCHAR(64) NOT NULL,
  `candle_id` INT UNSIGNED NOT NULL,
  `high_price` DECIMAL(20,8) UNSIGNED NOT NULL,
  `low_price` DECIMAL(20,8) UNSIGNED NOT NULL,
  `open_price` DECIMAL(20,8) UNSIGNED NOT NULL,
  `close_price` DECIMAL(20,8) UNSIGNED NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `volume` DECIMAL(20,8) UNSIGNED NOT NULL,
  PRIMARY KEY (`ticker_symbol`, `candle_id`),
  INDEX `fk_Candlestick_Cryptocurrency1_idx` (`ticker_symbol` ASC) VISIBLE,
  CONSTRAINT `fk_Candlestick_Cryptocurrency1`
    FOREIGN KEY (`ticker_symbol`)
    REFERENCES `CryptofolioDB`.`Cryptocurrency` (`ticker_symbol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`CryptoHistory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`CryptoHistory` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`CryptoHistory` (
  `ticker_symbol` VARCHAR(64) NOT NULL,
  `history_id` INT UNSIGNED NOT NULL,
  `current_price` DECIMAL(20,8) NOT NULL,
  `circulating_supply` DECIMAL(20,8) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`ticker_symbol`, `history_id`),
  INDEX `fk_CryptoHistory_Cryptocurrency1_idx` (`ticker_symbol` ASC) VISIBLE,
  CONSTRAINT `fk_CryptoHistory_Cryptocurrency1`
    FOREIGN KEY (`ticker_symbol`)
    REFERENCES `CryptofolioDB`.`Cryptocurrency` (`ticker_symbol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Wallet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Wallet` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Wallet` (
  `wallet_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `cash_balance` DECIMAL(20,8) UNSIGNED NOT NULL,
  PRIMARY KEY (`wallet_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Invitation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Invitation` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Invitation` (
  `invitation_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME(3) NOT NULL,
  `expires_at` DATETIME(3) NOT NULL,
  `status` ENUM('pending', 'accepted', 'rejected') NOT NULL,
  `inviter_id` INT UNSIGNED NOT NULL,
  `invitee_id` INT UNSIGNED NOT NULL,
  `wallet_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`invitation_id`),
  INDEX `fk_Invitation_User1_idx` (`inviter_id` ASC) VISIBLE,
  INDEX `fk_Invitation_User2_idx` (`invitee_id` ASC) VISIBLE,
  INDEX `fk_Invitation_Wallet1_idx` (`wallet_id` ASC) VISIBLE,
  CONSTRAINT `fk_Invitation_User1`
    FOREIGN KEY (`inviter_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`),
  CONSTRAINT `fk_Invitation_User2`
    FOREIGN KEY (`invitee_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`),
  CONSTRAINT `fk_Invitation_Wallet1`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `CryptofolioDB`.`Wallet` (`wallet_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Transaction` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Transaction` (
  `transaction_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `amount` DECIMAL(20,8) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `price_at_timestamp` DECIMAL(20,8) NOT NULL,
  `transaction_type` ENUM('buy', 'sell') NOT NULL,
  `ticker_symbol` VARCHAR(64) NOT NULL,
  `wallet_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `fk_User_has_CryptoBalance_User1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_Transaction_Cryptocurrency1_idx` (`ticker_symbol` ASC) VISIBLE,
  INDEX `fk_Transaction_Wallet1_idx` (`wallet_id` ASC) VISIBLE,
  CONSTRAINT `fk_Transaction_Cryptocurrency1`
    FOREIGN KEY (`ticker_symbol`)
    REFERENCES `CryptofolioDB`.`Cryptocurrency` (`ticker_symbol`),
  CONSTRAINT `fk_Transaction_Wallet1`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `CryptofolioDB`.`Wallet` (`wallet_id`),
  CONSTRAINT `fk_User_updates_CryptoBalance_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`User_gets_alert_for_Cryptocurrency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`User_gets_alert_for_Cryptocurrency` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`User_gets_alert_for_Cryptocurrency` (
  `alert_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `ticker_symbol` VARCHAR(64) NOT NULL,
  `threshold_price` DECIMAL(20,8) UNSIGNED NOT NULL,
  `threshold_direction` ENUM('above', 'below') NOT NULL,
  `triggered_at` DATETIME(3) NULL DEFAULT NULL,
  PRIMARY KEY (`alert_id`),
  INDEX `fk_User_has_Cryptocurrency_Cryptocurrency1_idx` (`ticker_symbol` ASC) VISIBLE,
  INDEX `fk_User_has_Cryptocurrency_User1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_gets_alert_for_Cryptocurrency_Cryptocurrency1`
    FOREIGN KEY (`ticker_symbol`)
    REFERENCES `CryptofolioDB`.`Cryptocurrency` (`ticker_symbol`),
  CONSTRAINT `fk_User_gets_alert_for_Cryptocurrency_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`User_has_Wallet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`User_has_Wallet` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`User_has_Wallet` (
  `user_id` INT UNSIGNED NOT NULL,
  `wallet_id` INT UNSIGNED NOT NULL,
  `role` ENUM('owner', 'member') NOT NULL,
  PRIMARY KEY (`user_id`, `wallet_id`),
  INDEX `fk_User_has_Wallet_Wallet1_idx` (`wallet_id` ASC) VISIBLE,
  INDEX `fk_User_has_Wallet_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Wallet_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`),
  CONSTRAINT `fk_User_has_Wallet_Wallet1`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `CryptofolioDB`.`Wallet` (`wallet_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Wallet_stores_Cryptocurrency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Wallet_stores_Cryptocurrency` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Wallet_stores_Cryptocurrency` (
  `wallet_id` INT UNSIGNED NOT NULL,
  `ticker_symbol` VARCHAR(64) NOT NULL,
  `crypto_amount` DECIMAL(20,8) UNSIGNED NOT NULL,
  PRIMARY KEY (`wallet_id`, `ticker_symbol`),
  INDEX `fk_Wallet_has_Cryptocurrency_Cryptocurrency1_idx` (`ticker_symbol` ASC) VISIBLE,
  INDEX `fk_Wallet_has_Cryptocurrency_Wallet1_idx` (`wallet_id` ASC) VISIBLE,
  CONSTRAINT `fk_Wallet_has_Cryptocurrency_Cryptocurrency1`
    FOREIGN KEY (`ticker_symbol`)
    REFERENCES `CryptofolioDB`.`Cryptocurrency` (`ticker_symbol`),
  CONSTRAINT `fk_Wallet_has_Cryptocurrency_Wallet1`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `CryptofolioDB`.`Wallet` (`wallet_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`BankAccount_transfers_to_Wallet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`BankAccount_transfers_to_Wallet` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`BankAccount_transfers_to_Wallet` (
  `transfer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(20,8) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `iban` VARCHAR(256) NOT NULL,
  `wallet_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`transfer_id`),
  INDEX `fk_BankAccount_transfers_to_Wallet_BankAccount1_idx` (`iban` ASC) VISIBLE,
  INDEX `fk_BankAccount_transfers_to_Wallet_Wallet1_idx` (`wallet_id` ASC) VISIBLE,
  CONSTRAINT `fk_BankAccount_transfers_to_Wallet_BankAccount1`
    FOREIGN KEY (`iban`)
    REFERENCES `CryptofolioDB`.`BankAccount` (`iban`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BankAccount_transfers_to_Wallet_Wallet1`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `CryptofolioDB`.`Wallet` (`wallet_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `CryptofolioDB` ;

-- -----------------------------------------------------
-- Placeholder table for view `CryptofolioDB`.`UserCryptoBalances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`UserCryptoBalances` (`user_id` INT, `wallet_id` INT, `ticker_symbol` INT, `crypto_amount` INT);

-- -----------------------------------------------------
-- Placeholder table for view `CryptofolioDB`.`UserBankTransactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`UserBankTransactions` (`user_id` INT, `iban` INT, `wallet_id` INT, `timestamp` INT, `amount` INT);

-- -----------------------------------------------------
-- Placeholder table for view `CryptofolioDB`.`CryptoCandlestick`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`CryptoCandlestick` (`ticker_symbol` INT, `name` INT, `candle_id` INT, `timestamp` INT, `open_price` INT, `high_price` INT, `low_price` INT, `close_price` INT, `volume` INT);

-- -----------------------------------------------------
-- View `CryptofolioDB`.`UserCryptoBalances`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`UserCryptoBalances`;
DROP VIEW IF EXISTS `CryptofolioDB`.`UserCryptoBalances` ;
USE `CryptofolioDB`;
CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `CryptofolioDB`.`UserCryptoBalances` AS 
SELECT `user_id`, `wallet_id`, `ticker_symbol`, `crypto_amount`
FROM `CryptofolioDB`.`User_has_Wallet`
NATURAL JOIN `CryptofolioDB`.`Wallet_stores_Cryptocurrency`;

-- -----------------------------------------------------
-- View `CryptofolioDB`.`UserBankTransactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`UserBankTransactions`;
DROP VIEW IF EXISTS `CryptofolioDB`.`UserBankTransactions` ;
USE `CryptofolioDB`;
CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `CryptofolioDB`.`UserBankTransactions` AS 
SELECT `user_id`, `iban`, `wallet_id`, `timestamp`, `amount`
FROM `CryptofolioDB`.`User`
NATURAL JOIN `CryptofolioDB`.`BankAccount`
NATURAL JOIN `CryptofolioDB`.`BankAccount_transfers_to_Wallet`;

-- -----------------------------------------------------
-- View `CryptofolioDB`.`CryptoCandlestick`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`CryptoCandlestick`;
DROP VIEW IF EXISTS `CryptofolioDB`.`CryptoCandlestick` ;
USE `CryptofolioDB`;
CREATE OR REPLACE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `CryptofolioDB`.`CryptoCandlestick` AS 
SELECT `ticker_symbol`, `name`, `candle_id`, `timestamp`, `open_price`, `high_price`, `low_price`, `close_price`, `volume`
FROM `CryptofolioDB`.`Cryptocurrency`
NATURAL JOIN `CryptofolioDB`.`Candlestick`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Insert sample data
-- -----------------------------------------------------

-- Insert User data
INSERT INTO `CryptofolioDB`.`User` (user_id, name, email, registered_at, phone, password_hash) VALUES
(1, 'Nikos Ioan', 'nikos.ioan@example.com', '2022-10-25 09:30:00', '+306991000001', '$2b$12$X9pTq3vR6sZ8uWf2GhJkLmNoPqRsTuVwXyZ0a1B2C3D4E5F6G7H8'),
(2, 'Dimitris Pap', 'dimitris.pap@example.com', '2023-11-25 09:35:00', '+306992000002', '$2b$12$A1bC3dE5fG7hI9jK2lM4nO6pQ8rS0tU2vW4xY6zZ8aB0cD2eF4'),
(3, 'Kostas Alex', 'kostas.alex@example.com', '2024-06-10 08:30:00', '+306993000003', '$2b$12$M7nP4qR1sT6uV9wX2yZ5aB8cD0eF3gH6iJ9kL2mN5oP8qR1sT4'),
(4, 'Maria K', 'maria.k@example.com', '2025-01-14 12:10:00', '+306994000004', '$2b$12$Z3yX6wV9uT2sR5qP8oN1mL4kJ7iH0gF3eD6cB9aY2xW5vU8tS1'),
(5, 'Nikos P', 'nikos.p@example.com', '2025-09-01 18:45:00', '+306995000005', '$2b$12$C5dE8fG1hI4jK7lM0nO3pQ6rS9tU2vW5xY8zA1bC4dE7fG0hI3');

-- Insert Wallet data
INSERT INTO `CryptofolioDB`.`Wallet` (wallet_id, cash_balance, name) VALUES
(1, 2500.00, 'Aris Main Wallet'),
(2, 1200.50, 'Aris Trading Wallet'),
(3, 5400.75, 'Shared Investment Wallet'),
(4, 800.00, 'Maria Savings Wallet'),
(5, 150.25, 'Nikos Starter Wallet');

-- Insert User_has_Wallet data
INSERT INTO `CryptofolioDB`.`User_has_Wallet` (user_id, wallet_id, role) VALUES
(1, 1, 'owner'),
(1, 2, 'owner'),
(2, 3, 'owner'),
(1, 3, 'member'),
(4, 4, 'owner'),
(5, 5, 'owner');

-- Insert BankAccount data
INSERT INTO `CryptofolioDB`.`BankAccount` (user_id, iban, holder_name, bank_name, provider_token) VALUES
(1, 'GR47123904586712039845678', 'Nikos Ioannidis', 'Alpha Bank', 'tok_1'),
(2, 'GR22048765091234756019234', 'Dimitris Papadopoulos', 'Eurobank', 'tok_2'),
(2, 'GR39105723846019284057612', 'Dimitris Papadopoulos', 'Eurobank', 'tok_3'),
(4, 'GR56091827364509182736450', 'Maria Kotsou', 'National Bank', 'tok_4'),
(5, 'GR10928374650192837465019', 'Nikos Papas', 'Piraeus Bank', 'tok_5');

-- Insert BankAccount_transfers_to_Wallet data
INSERT INTO `CryptofolioDB`.`BankAccount_transfers_to_Wallet` (transfer_id, timestamp, amount, wallet_id, iban) VALUES
(1, '2025-11-20 09:30:00', 1500.00, 1, 'GR47123904586712039845678'),
(2, '2025-11-22 14:15:00', 2000.00, 3, 'GR22048765091234756019234'),
(3, '2025-11-25 11:45:00', -500.00, 3, 'GR39105723846019284057612'),
(4, '2025-12-01 16:20:00', 800.00, 4, 'GR56091827364509182736450'),
(5, '2025-12-05 10:10:00', 150.25, 5, 'GR10928374650192837465019');

-- Insert Invitation data
INSERT INTO `CryptofolioDB`.`Invitation` (invitation_id, invitee_id, inviter_id, wallet_id, status, expires_at, created_at) VALUES
(1, 1, 2, 3, 'accepted', '2025-11-30 23:59:00', '2025-11-20 10:30:00'),
(2, 4, 1, 2, 'pending', '2025-12-21 23:59:00', '2025-12-01 14:15:00'),
(3, 5, 4, 4, 'rejected', '2025-12-08 23:59:00', '2025-11-28 09:00:00'),
(4, 3, 2, 3, 'rejected', '2025-11-28 23:59:00', '2025-11-18 18:40:00'),
(5, 2, 1, 1, 'pending', '2025-12-25 23:59:00', '2025-12-05 12:00:00');

-- Insert Cryptocurrency data
INSERT INTO `CryptofolioDB`.`Cryptocurrency` (ticker_symbol, name, logo_image) VALUES
('BTC', 'Bitcoin', 'public/logos/BTC.svg'),
('ETH', 'Ethereum', 'public/logos/ETH.svg'),
('USDT', 'Tether', 'public/logos/USDT.svg'),
('DOGE', 'Dogecoin', 'public/logos/DOGE.svg'),
('SOL', 'Solana', 'public/logos/SOL.svg');

-- Insert Candlestick data
INSERT INTO `CryptofolioDB`.`Candlestick` (candle_id, ticker_symbol, open_price, close_price, high_price, low_price, volume, timestamp) VALUES
(1, 'BTC', 48500, 48950, 49200, 48050, 1320.5, '2025-12-05 09:00:00'),
(2, 'BTC', 48950, 49320, 49500, 48700, 1410.2, '2025-12-05 10:00:00'),
(1, 'ETH', 2550, 2590, 2620, 2525, 8420.0, '2025-12-05 09:00:00'),
(2, 'ETH', 2590, 2635, 2650, 2580, 8010.3, '2025-12-05 10:00:00'),
(1, 'SOL', 98.5, 100.4, 102.0, 97.8, 15200.8, '2025-12-05 09:00:00');

-- Insert CryptoHistory data
INSERT INTO `CryptofolioDB`.`CryptoHistory` (ticker_symbol, current_price, circulating_supply, timestamp, history_id) VALUES
('BTC', 49320, 19500000, '2025-12-05 09:00:00', 1),
('BTC', 49510, 19500000, '2025-12-05 10:00:00', 2),
('ETH', 2635, 120500000, '2025-12-05 10:30:00', 1),
('ETH', 2650, 120500000, '2025-12-05 11:30:00', 2),
('SOL', 100.4, 585000000, '2025-12-05 12:00:00', 1);

-- Insert User_gets_alert_for_Cryptocurrency data
INSERT INTO `CryptofolioDB`.`User_gets_alert_for_Cryptocurrency` (alert_id, user_id, ticker_symbol, threshold_price, threshold_direction, triggered_at) VALUES
(1, 1, 'BTC', 52000, 'above', NULL),
(2, 3, 'ETH', 2500, 'below', '2025-11-30 18:20:00'),
(3, 1, 'BTC', 95, 'below', NULL),
(4, 4, 'BTC', 48000, 'below', '2025-11-28 09:10:00'),
(5, 5, 'DOGE', 0.12, 'above', NULL);

-- Insert Wallet_stores_Cryptocurrency data
INSERT INTO `CryptofolioDB`.`Wallet_stores_Cryptocurrency` (wallet_id, ticker_symbol, crypto_amount) VALUES
(1, 'BTC', 0.120000),
(1, 'ETH', 1.500000),
(2, 'ETH', 0.750000),
(3, 'BTC', 0.420000),
(4, 'SOL', 12.000000),
(5, 'USDT', 150.250000);

-- Insert Transaction data
INSERT INTO `CryptofolioDB`.`Transaction` (transaction_id, user_id, wallet_id, ticker_symbol, amount, price_at_timestamp, timestamp, transaction_type) VALUES
(1, 1, 1, 'BTC', 0.10, 48000, '2025-11-28 10:30:00', 'buy'),
(2, 1, 3, 'ETH', 0.75, 2500, '2025-11-29 12:10:00', 'sell'),
(3, 2, 3, 'BTC', 0.42, 48500, '2025-12-01 09:45:00', 'buy'),
(4, 4, 4, 'SOL', 12.0, 98.0, '2025-12-02 16:00:00', 'buy'),
(5, 5, 5, 'USDT', 150.25, 1.00, '2025-12-05 10:10:00', 'buy');
