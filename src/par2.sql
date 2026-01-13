# Δημιουργία db my_accounts με πίνακα accounts
DROP DATABASE IF EXISTS my_accounts;
CREATE DATABASE my_accounts;
USE my_accounts;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (acct_num INT, amount DECIMAL(12,2));
CREATE TABLE total_bal (total_sum INT);
INSERT INTO total_bal VALUES(0);

# Δημιουργία trigger calc_sum για έλεγχο των inserts
DROP TRIGGER IF EXISTS calc_sum;
DELIMITER #
CREATE TRIGGER calc_sum
BEFORE INSERT ON accounts
FOR EACH ROW
BEGIN
	UPDATE total_bal
    SET total_sum = total_sum + NEW.amount;
END;
#
DELIMITER ;

#Δοκιμές
INSERT INTO accounts VALUES(100, 1000.50), (101, 2000.50), (102, 1500.00);
SELECT * FROM accounts;
SELECT * FROM total_bal;
INSERT INTO accounts VALUES(103, 1000.50), (104, 2000.50), (105, 1500.00);
SELECT * FROM accounts;
SELECT * FROM total_bal;