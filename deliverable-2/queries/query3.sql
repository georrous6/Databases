-- Query 3: All invitations where user_id = 1 is neither sender or receiver
USE CryptofolioDB;
SELECT *
FROM Invitation
WHERE inviter_id != 1
  AND invitee_id != 1;
