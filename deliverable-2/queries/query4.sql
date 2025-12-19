-- Query 4: All BTC transactions of user_id = 1 that took place after 2025-12-17T16:05:42Z
SELECT *
FROM Transaction
WHERE user_id = 1
  AND ticker_symbol = 'BTC'
  AND timestamp > '2025-12-17 16:05:42';