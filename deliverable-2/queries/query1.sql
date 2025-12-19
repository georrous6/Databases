-- Query 1: Total count of BTC for the user with user_id = 1
USE CryptofolioDB;
SELECT uh.user_id, ws.ticker_symbol, SUM(ws.crypto_amount) AS cryptoAmount
FROM User_has_Wallet AS uh
JOIN Wallet_stores_Cryptocurrency AS ws ON uh.wallet_id = ws.wallet_id
WHERE uh.user_id = 1
  AND ws.ticker_symbol = 'BTC'
GROUP BY uh.user_id, ws.ticker_symbol;
