# Δημιουργία πίνακα Accounts με 2 εγγραφές
USE my_accounts;
DROP TABLE IF EXISTS Accounts;
CREATE TABLE Accounts (acctID int not null primary key,
	balance int not null);
   # CONSTRAINT unloanable_account CHECK (balance >= 0));

# Δοκιμές
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
COMMIT;
# (α) Εμφάνισε τα περιεχόμενα του πίνακα Accounts πριν την συναλλαγή
SELECT * FROM Accounts;

# Συναλλαγή
BEGIN;
UPDATE Accounts SET balance = balance - 100
WHERE acctID = 101;
UPDATE Accounts SET balance = balance + 100
WHERE acctID = 202;
COMMIT;

# (β) Εμφάνισε τα περιεχόμενα του πίνακα Accounts μετά την συναλλαγή
SELECT * FROM Accounts;
    