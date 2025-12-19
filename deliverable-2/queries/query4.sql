-- Query 4: All BTC transactions of user_id = 1 that took place after 2025-8-28 10:30:00
USE CryptofolioDB;
SELECT *
FROM Transaction
WHERE user_id = 1
  AND ticker_symbol = 'BTC'
  AND timestamp > '2025-8-17 16:05:42';