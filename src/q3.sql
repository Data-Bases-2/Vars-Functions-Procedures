# Δημιουργία της ΒΔ my_accounts και του πίνακα Accounts
DROP DATABASE IF EXISTS my_accounts;
CREATE DATABASE my_accounts;
USE my_accounts;
CREATE TABLE Accounts (acctID int not null primary key, 
					   Balance int not null);

# Δοκιμές
INSERT INTO Accounts (acctID, Balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, Balance) VALUES (202, 2000);
INSERT INTO Accounts (acctID, Balance) VALUES (303, 2500);
INSERT INTO Accounts (acctID, Balance) VALUES (404, 3000);

# (α) Λίστα πινάκων της ΒΔ
SHOW TABLES;
# (β) Περιεχόμενα των πινάκων της ΒΔ
SELECT * FROM Accounts AS B;
# (γ) Δομή του πίνακα Acoounts
DESCRIBE Accounts;
