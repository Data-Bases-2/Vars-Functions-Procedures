# Προσθήκη foreign key custno στον πίνακα Accounts
USE my_accounts;
ALTER TABLE Accounts DROP custno;
ALTER TABLE Accounts ADD custno int;
ALTER TABLE Accounts ADD foreign key(custno) references Customers(custno);

# Δοκιμές
UPDATE Accounts SET custno = 20 WHERE acctID = 202;
UPDATE Accounts SET custno = 10 WHERE acctID <> 202;

# (α) Περιεχόμενα του πίνακα Accounts
SELECT * FROM Accounts;
# (β) Δομή του πίνακα Accounts
DESCRIBE Accounts;
