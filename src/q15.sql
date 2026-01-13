# Δημιουργία πίνακα Accounts
USE my_accounts;
DROP TABLE IF EXISTS Accounts;
CREATE TABLE Accounts (acctID int not null primary key,
	balance int not null);
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
COMMIT;
# (α) Εμφάνισε τα περιεχόμενα του πίνακα Accounts
SELECT * FROM Accounts;

# Δημιουργία trigger Accounts_upd_trg για έλεγχο των updates
DELIMITER !
CREATE TRIGGER Accounts_upd_trg
BEFORE UPDATE ON Accounts
FOR EACH ROW
BEGIN
	IF NEW.balance < 0 THEN
		SIGNAL SQLSTATE '23513'
        SET MESSAGE_TEXT = 'Negative balance not allowed';
	END IF;
END; !
DELIMITER ;

# Δημιουργία trigger Accounts_ins_trg για έλεγχο των inserts
DELIMITER !
CREATE TRIGGER Accounts_ins_trg
BEFORE INSERT ON Accounts 
FOR EACH ROW
BEGIN
	IF NEW.balance < 0 THEN
		SIGNAL SQLSTATE '23513'
		SET MESSAGE_TEXT = 'Negative balance not allowed';
    END IF;
END; !
DELIMITER ;

# Δημιουργία procedure BankTransfer
DELIMITER !
DROP PROCEDURE IF EXISTS BankTransfer;
CREATE PROCEDURE BankTransfer (IN fromAcct INT,
							   IN toAcct INT,
                               IN amount INT,
                               OUT msg VARCHAR(100))
LANGUAGE SQL MODIFIES SQL DATA
P1: BEGIN
DECLARE acct INT;
DECLARE balance_v INT;
DECLARE EXIT HANDLER FOR NOT FOUND
	BEGIN ROLLBACK;
    SET msg = concat('missing account ', cast(acct AS char));
    END;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN ROLLBACK;
    SET msg = concat('negative balance (?) in ', fromAcct);
    END;
SET acct = fromAcct;
SELECT acctID INTO acct FROM Accounts WHERE acctID = fromAcct;
UPDATE Accounts SET balance = balance - amount
WHERE acctID = fromAcct;
SET acct = toAcct;
SELECT acctID INTO acct FROM Accounts WHERE acctID = toAcct;
UPDATE Accounts SET balance = balance + amount
WHERE acctID = toAcct;
	SELECT balance INTO balance_v
    FROM Accounts
    WHERE acctID = fromAcct;
    IF balance_v < 0 THEN
		ROLLBACK;
        SET msg = concat('negative balance in ', fromAcct);
	ELSE
		COMMIT;
        SET msg = 'commited';
	END IF;
END P1 !
DELIMITER ;

# (β) Δοκιμή μεταφοράς 100 από acctID = 101 σε acctID = 201 (ανύπαρκτος) 
CALL BankTransfer (101, 201, 100, @msg);
SELECT @msg;
# (γ) Δοκιμή μεταφοράς 100 από acctID = 100 (ανύπαρκτος) σε acctID = 202 
CALL BankTransfer (100, 202, 100, @msg);
SELECT @msg;
# (δ) Δοκιμή μεταφοράς 100 από acctID = 101 σε acctID = 202 
CALL BankTransfer (101, 202, 100, @msg);
SELECT @msg;
# (ε) Δοκιμή μεταφοράς 2000 από acctID = 101 (ανεπαρκές) σε acctID = 202 
CALL BankTransfer (101, 202, 2000, @msg);
SELECT @msg;