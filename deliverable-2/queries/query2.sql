-- Query 2: All the wallets of user_id = 1 that have taken place to bank transactions
SELECT DISTINCT u.user_id, t.wallet_id
FROM User AS u
JOIN BankAccount AS ba ON u.user_id = ba.user_id
JOIN BankAccount_transfers_to_Wallet AS t ON ba.account_id = t.account_id
WHERE u.user_id = 1;
