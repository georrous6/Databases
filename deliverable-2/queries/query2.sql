-- Query 2: All wallets of the user with user_id = 1 (owner or member) that have participated in bank transactions.
USE CryptofolioDB;
SELECT DISTINCT u.user_id, w.wallet_id, w.name
FROM User_has_Wallet AS u
JOIN Wallet AS w ON u.wallet_id = w.wallet_id
JOIN BankAccount_transfers_to_Wallet AS t ON w.wallet_id = t.wallet_id
WHERE u.user_id = 1;
