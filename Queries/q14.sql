# Δημιουργία procedure BankTrasfer
USE my_accounts;
DELIMITER // 
DROP PROCEDURE IF EXISTS BankTransfer //
CREATE PROCEDURE BankTransfer (IN fromAcct INT,
							   IN toAcct   INT,
							   IN amount   INT,
                               OUT msg     VARCHAR(100)
                               )
P1: BEGIN
	DECLARE row_s INT;
    DECLARE newbalance INT;
    SELECT count(*) INTO row_s FROM Accounts WHERE acctID = fromAcct;
    UPDATE Accounts SET balance = balance - amount WHERE acctID = fromAcct;
    SELECT balance INTO newbalance FROM Accounts WHERE acctID = fromAcct;
    IF row_s = 0 THEN
		ROLLBACK;
        SET msg = concat('rolled back because of missing account ', fromAcct);
	ELSEIF newbalance < 0 THEN
		ROLLBACK;
        SET msg = concat('rolled back because of negative balance of account ', fromAcct);
	ELSE 
		SELECT count(*) INTO row_s FROM Accounts WHERE acctID = toAcct;
        UPDATE Accounts SET balance = balance + amount WHERE acctID = toAcct;
        IF row_s = 0 THEN
			ROLLBACK;
            SET msg = concat('rolled back because of missing account ', toAcct);
		ELSE
			COMMIT;
            SET msg = 'commited';
		END IF;
	END IF;
END P1 //
DELIMITER ;

# (α) Δοκιμή μεταφοράς 100 από acctID = 101 σε acctID = 202
SET AUTOCOMMIT = 0;
SET @out = ' ';
CALL BankTransfer (101, 202, 100, @out);
SELECT @out;
SELECT * FROM Accounts;
COMMIT;

# (β) Δοκιμή μεταφοράς 100 από acctID = 101 σε acctID = 201 (ανύπαρκτος)
SET AUTOCOMMIT = 0;
SET @out = ' ';
CALL BankTransfer (101, 201, 100, @out);
SELECT @out;
SELECT * FROM Accounts;
COMMIT;

# (γ) Δοκιμή μεταφοράς 100 από acctID = 100 (ανύπαρκτος) σε acctID = 201 
SET AUTOCOMMIT = 0;
SET @out = ' ';
CALL BankTransfer (100, 201, 100, @out);
SELECT @out;
SELECT * FROM Accounts;
COMMIT;

# (δ) Δοκιμή μεταφοράς 1500 από acctID = 101 (ανεπαρκής) σε acctID = 201 
SET AUTOCOMMIT = 0;
SET @out = ' ';
CALL BankTransfer (101, 201, 1500, @out);
SELECT @out;
SELECT * FROM Accounts;
COMMIT;