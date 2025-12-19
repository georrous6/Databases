-- ============================================================
-- Database Users and Privileges for CryptofolioDB
-- ============================================================
-- This script defines two database users:
--
-- 1. db_admin
--    - System Administrator
--    - Full privileges on the database
--    - Used for maintenance, backups, recovery, and security
--
-- 2. app_user
--    - Application database user
--    - Used exclusively by the backend application
--    - Table-level privileges
-- ============================================================


-- ------------------------------------------------------------
-- System Administrator
-- ------------------------------------------------------------

CREATE USER IF NOT EXISTS 'db_admin'@'localhost'
IDENTIFIED BY 'JJ2YqpLU5+gXcfTK';

GRANT ALL PRIVILEGES
ON CryptofolioDB.*
TO 'db_admin'@'localhost';


-- ------------------------------------------------------------
-- Application User
-- ------------------------------------------------------------

CREATE USER IF NOT EXISTS 'app_user'@'localhost'
IDENTIFIED BY '2kSRg3qKoIAtHiCv';


-- ------------------------------------------------------------
-- User
-- ------------------------------------------------------------
-- Registration, authentication, profile updates
-- Hard deletion of users allowed (just for demonstration)

GRANT SELECT, INSERT, UPDATE, DELETE
ON CryptofolioDB.User
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- Wallet
-- ------------------------------------------------------------
-- Wallet creation and updates
-- Only the wallet owner can delete a wallet

GRANT SELECT, INSERT, UPDATE, DELETE
ON CryptofolioDB.Wallet
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- User_has_Wallet
-- ------------------------------------------------------------
-- Wallet ownership and membership management

GRANT SELECT, INSERT, UPDATE, DELETE
ON CryptofolioDB.User_has_Wallet
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- BankAccount
-- ------------------------------------------------------------
-- User-managed bank accounts

GRANT SELECT, INSERT, UPDATE, DELETE
ON CryptofolioDB.BankAccount
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- BankAccount_transfers_to_Wallet
-- ------------------------------------------------------------
-- Financial transfer ledger (append-only for integrity)

GRANT SELECT, INSERT
ON CryptofolioDB.BankAccount_transfers_to_Wallet
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- Invitation
-- ------------------------------------------------------------
-- Wallet invitations lifecycle

GRANT SELECT, INSERT, UPDATE, DELETE
ON CryptofolioDB.Invitation
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- Cryptocurrency
-- ------------------------------------------------------------
-- Reference/master data (read-only for app)

GRANT SELECT
ON CryptofolioDB.Cryptocurrency
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- Candlestick
-- ------------------------------------------------------------
-- Market data (read-only, externally populated)

GRANT SELECT
ON CryptofolioDB.Candlestick
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- CryptoHistory
-- ------------------------------------------------------------
-- Historical price data (read-only)

GRANT SELECT
ON CryptofolioDB.CryptoHistory
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- User_gets_alert_for_Cryptocurrency
-- ------------------------------------------------------------
-- User-defined price alerts

GRANT SELECT, INSERT, UPDATE, DELETE
ON CryptofolioDB.User_gets_alert_for_Cryptocurrency
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- Wallet_stores_Cryptocurrency
-- ------------------------------------------------------------
-- Wallet asset balances
-- UPDATE for balance adjustments after transactions

GRANT SELECT, INSERT, UPDATE, DELETE
ON CryptofolioDB.Wallet_stores_Cryptocurrency
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- Transaction
-- ------------------------------------------------------------
-- Financial transaction ledger (append-only for audit trail)

GRANT SELECT, INSERT
ON CryptofolioDB.Transaction
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- Views
-- ------------------------------------------------------------

-- UserCryptoBalances View
-- Shows user's cryptocurrency holdings across wallets
GRANT SELECT
ON CryptofolioDB.UserCryptoBalances
TO 'app_user'@'localhost';

-- UserBankTransactions View
-- Shows user's bank transfer history
GRANT SELECT
ON CryptofolioDB.UserBankTransactions
TO 'app_user'@'localhost';

-- CryptoCandlestick View
-- Shows cryptocurrency candlestick chart data
GRANT SELECT
ON CryptofolioDB.CryptoCandlestick
TO 'app_user'@'localhost';


-- ------------------------------------------------------------
-- Apply privilege changes
-- ------------------------------------------------------------

FLUSH PRIVILEGES;
