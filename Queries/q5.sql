# Τα περιεχόμενα του πίνακα Accounts με αύξουσα αρίθμηση στις εγγραφές του
SET @rownum = 0;
SELECT (@rownum := @rownum + 1) AS No, acctID, Balance FROM Accounts ORDER BY acctID;
DESCRIBE Accounts;