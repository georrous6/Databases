-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CryptofolioDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CryptofolioDB` ;

-- -----------------------------------------------------
-- Schema CryptofolioDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CryptofolioDB` ;
USE `CryptofolioDB` ;

-- -----------------------------------------------------
-- Table `CryptofolioDB`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`User` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`User` (
  `user_id` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `password_hash` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NULL,
  `registered_at` DATETIME(3) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Wallet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Wallet` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Wallet` (
  `wallet_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `cash_balance` DECIMAL NOT NULL,
  PRIMARY KEY (`wallet_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`User_has_Wallet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`User_has_Wallet` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`User_has_Wallet` (
  `user_id` INT NOT NULL,
  `wallet_id` INT NOT NULL,
  `role` ENUM('owner', 'member') NULL,
  PRIMARY KEY (`user_id`, `wallet_id`),
  INDEX `fk_User_has_Wallet_Wallet1_idx` (`wallet_id` ASC) VISIBLE,
  INDEX `fk_User_has_Wallet_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Wallet_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Wallet_Wallet1`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `CryptofolioDB`.`Wallet` (`wallet_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Invitation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Invitation` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Invitation` (
  `invitation_id` INT NOT NULL,
  `created_at` DATETIME(3) NOT NULL,
  `expires_at` DATETIME(3) NOT NULL,
  `status` ENUM('pending', 'accepted', 'rejected') NOT NULL,
  `inviter_id` INT NOT NULL,
  `invitee_id` INT NOT NULL,
  `wallet_id` INT NOT NULL,
  PRIMARY KEY (`invitation_id`),
  INDEX `fk_Invitation_User1_idx` (`inviter_id` ASC) VISIBLE,
  INDEX `fk_Invitation_User2_idx` (`invitee_id` ASC) VISIBLE,
  INDEX `fk_Invitation_Wallet1_idx` (`wallet_id` ASC) VISIBLE,
  CONSTRAINT `fk_Invitation_User1`
    FOREIGN KEY (`inviter_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invitation_User2`
    FOREIGN KEY (`invitee_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invitation_Wallet1`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `CryptofolioDB`.`Wallet` (`wallet_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`BankAccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`BankAccount` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`BankAccount` (
  `account_id` INT NOT NULL,
  `encrypted_iban` VARCHAR(45) NOT NULL,
  `holder_name` VARCHAR(45) NOT NULL,
  `bank_name` VARCHAR(45) NOT NULL,
  `provider_token` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`account_id`),
  INDEX `fk_BankAccount_User1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_BankAccount_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`BankAccount_transfers_to_Wallet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`BankAccount_transfers_to_Wallet` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`BankAccount_transfers_to_Wallet` (
  `account_id` INT NOT NULL,
  `wallet_id` INT NOT NULL,
  `amount` DECIMAL NOT NULL,
  `direction` BIT(1) NOT NULL,
  `timestamp` TIMESTAMP(3) NOT NULL,
  `transfer_id` INT NOT NULL,
  INDEX `fk_BankAccount_has_Wallet_Wallet1_idx` (`wallet_id` ASC) VISIBLE,
  INDEX `fk_BankAccount_has_Wallet_BankAccount1_idx` (`account_id` ASC) VISIBLE,
  PRIMARY KEY (`transfer_id`),
  CONSTRAINT `fk_BankAccount_transfers_to_Wallet_BankAccount1`
    FOREIGN KEY (`account_id`)
    REFERENCES `CryptofolioDB`.`BankAccount` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BankAccount_transfers_to_Wallet_Wallet1`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `CryptofolioDB`.`Wallet` (`wallet_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Cryptocurrency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Cryptocurrency` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Cryptocurrency` (
  `ticker_symbol` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `logo_image` VARCHAR(45) NULL,
  PRIMARY KEY (`ticker_symbol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Transaction` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Transaction` (
  `transaction_id` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  `amount` DECIMAL(3) NOT NULL,
  `timestamp` TIMESTAMP(3) NOT NULL,
  `price_at_timestamp` DECIMAL(3) NOT NULL,
  `transaction_type` ENUM('buy', 'sell') NOT NULL,
  `ticker_symbol` INT NOT NULL,
  `wallet_id` INT NOT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `fk_User_has_CryptoBalance_User1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_Transaction_Cryptocurrency1_idx` (`ticker_symbol` ASC) VISIBLE,
  INDEX `fk_Transaction_Wallet1_idx` (`wallet_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_updates_CryptoBalance_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaction_Cryptocurrency1`
    FOREIGN KEY (`ticker_symbol`)
    REFERENCES `CryptofolioDB`.`Cryptocurrency` (`ticker_symbol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaction_Wallet1`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `CryptofolioDB`.`Wallet` (`wallet_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`CryptoHistory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`CryptoHistory` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`CryptoHistory` (
  `history_id` INT NOT NULL,
  `current_price` DECIMAL(3) NOT NULL,
  `circulating_supply` INT NOT NULL,
  `timestamp` TIMESTAMP(3) NOT NULL,
  `ticker_symbol` INT NOT NULL,
  PRIMARY KEY (`history_id`, `ticker_symbol`),
  INDEX `fk_CryptoHistory_Cryptocurrency1_idx` (`ticker_symbol` ASC) VISIBLE,
  CONSTRAINT `fk_CryptoHistory_Cryptocurrency1`
    FOREIGN KEY (`ticker_symbol`)
    REFERENCES `CryptofolioDB`.`Cryptocurrency` (`ticker_symbol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Candlestick`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Candlestick` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Candlestick` (
  `candle_id` INT NOT NULL,
  `high_price` DECIMAL(3) NOT NULL,
  `low_price` DECIMAL(3) NOT NULL,
  `open_price` DECIMAL(3) NOT NULL,
  `close_price` DECIMAL(3) NOT NULL,
  `interval` TIMESTAMP(3) NOT NULL,
  `volume` INT NOT NULL,
  `ticker_symbol` INT NOT NULL,
  PRIMARY KEY (`candle_id`, `ticker_symbol`),
  INDEX `fk_Candlestick_Cryptocurrency1_idx` (`ticker_symbol` ASC) VISIBLE,
  CONSTRAINT `fk_Candlestick_Cryptocurrency1`
    FOREIGN KEY (`ticker_symbol`)
    REFERENCES `CryptofolioDB`.`Cryptocurrency` (`ticker_symbol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`User_gets_alert_for_Cryptocurrency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`User_gets_alert_for_Cryptocurrency` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`User_gets_alert_for_Cryptocurrency` (
  `user_id` INT NOT NULL,
  `ticker_symbol` INT NOT NULL,
  `threshold_price` DECIMAL(3) NOT NULL,
  `threshold_direction` BIT(1) NOT NULL,
  `is_active` TINYINT NOT NULL,
  `triggered_at` DATETIME(3) NULL,
  `alert_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`alert_id`),
  INDEX `fk_User_has_Cryptocurrency_Cryptocurrency1_idx` (`ticker_symbol` ASC) VISIBLE,
  INDEX `fk_User_has_Cryptocurrency_User1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_gets_alert_for_Cryptocurrency_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CryptofolioDB`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_gets_alert_for_Cryptocurrency_Cryptocurrency1`
    FOREIGN KEY (`ticker_symbol`)
    REFERENCES `CryptofolioDB`.`Cryptocurrency` (`ticker_symbol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptofolioDB`.`Wallet_stores_Cryptocurrency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`Wallet_stores_Cryptocurrency` ;

CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`Wallet_stores_Cryptocurrency` (
  `wallet_id` INT NOT NULL,
  `ticker_symbol` INT NOT NULL,
  `crypto_amount` INT NOT NULL,
  PRIMARY KEY (`wallet_id`, `ticker_symbol`),
  INDEX `fk_Wallet_has_Cryptocurrency_Cryptocurrency1_idx` (`ticker_symbol` ASC) VISIBLE,
  INDEX `fk_Wallet_has_Cryptocurrency_Wallet1_idx` (`wallet_id` ASC) VISIBLE,
  CONSTRAINT `fk_Wallet_has_Cryptocurrency_Wallet1`
    FOREIGN KEY (`wallet_id`)
    REFERENCES `CryptofolioDB`.`Wallet` (`wallet_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Wallet_has_Cryptocurrency_Cryptocurrency1`
    FOREIGN KEY (`ticker_symbol`)
    REFERENCES `CryptofolioDB`.`Cryptocurrency` (`ticker_symbol`)
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
CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`UserBankTransactions` (`user_id` INT, `account_id` INT, `encrypted_iban` INT, `wallet_id` INT, `direction` INT, `timestamp` INT, `amount` INT);

-- -----------------------------------------------------
-- Placeholder table for view `CryptofolioDB`.`CryptoCandlestick`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CryptofolioDB`.`CryptoCandlestick` (`ticker_symbol` INT, `name` INT, `candle_id` INT, `interval` INT, `open_price` INT, `high_price` INT, `low_price` INT, `close_price` INT, `volume` INT);

-- -----------------------------------------------------
-- View `CryptofolioDB`.`UserCryptoBalances`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`UserCryptoBalances`;
DROP VIEW IF EXISTS `CryptofolioDB`.`UserCryptoBalances` ;
USE `CryptofolioDB`;
CREATE OR REPLACE VIEW UserCryptoBalances AS
SELECT uh.user_id,
       ws.wallet_id,
       ws.ticker_symbol,
       ws.crypto_amount
FROM User_has_Wallet AS uh
JOIN Wallet_stores_Cryptocurrency AS ws
  ON uh.wallet_id = ws.wallet_id;

-- -----------------------------------------------------
-- View `CryptofolioDB`.`UserBankTransactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`UserBankTransactions`;
DROP VIEW IF EXISTS `CryptofolioDB`.`UserBankTransactions` ;
USE `CryptofolioDB`;
CREATE OR REPLACE VIEW UserBankTransactions AS
SELECT u.user_id,
       ba.account_id,
       ba.encrypted_iban,
       bt.wallet_id,
       bt.direction,
       bt.timestamp,
       bt.amount
FROM User AS u
JOIN BankAccount AS ba
  ON u.user_id = ba.user_id
JOIN BankAccount_transfers_to_Wallet AS bt
  ON ba.account_id = bt.account_id
;

-- -----------------------------------------------------
-- View `CryptofolioDB`.`CryptoCandlestick`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CryptofolioDB`.`CryptoCandlestick`;
DROP VIEW IF EXISTS `CryptofolioDB`.`CryptoCandlestick` ;
USE `CryptofolioDB`;
CREATE OR REPLACE VIEW CryptoCandlestick AS
SELECT c.ticker_symbol,
       c.name,
       cs.candle_id,
       cs.interval,
       cs.open_price,
       cs.high_price,
       cs.low_price,
       cs.close_price,
       cs.volume
FROM Cryptocurrency AS c
JOIN Candlestick AS cs
  ON c.ticker_symbol = cs.ticker_symbol
;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
