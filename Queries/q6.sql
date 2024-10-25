# Δημιουργία του πίνακα Customers στη ΒΔ my_accounts
USE my_accounts;
CREATE TABLE Customers (custno int not null, cust_name varchar(30), primary key(custno));

# Δοκιμές
INSERT INTO Customers (custno, cust_name) VALUES (10, '101');
INSERT INTO Customers (custno, cust_name) VALUES (20, '202');

# (α) Λίστα πινάκων της ΒΔ
SHOW tables;
# (β) Περιεχόμενα του πίνακα Customers
SELECT * FROM Customers;
# (γ) Δομή του πίνακα Customers
DESCRIBE Customers;