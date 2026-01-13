# Δημιουργία db my_first_triggers_db με πίνακα new_dept
DROP DATABASE IF EXISTS my_first_triggers_db;
CREATE DATABASE my_first_triggers_db;
USE my_first_triggers_db;
DROP TABLE IF EXISTS new_dept;
CREATE TABLE new_dept(deptno int not null, dname char(30), primary key(deptno));

# Δημιουργία trigger trg_signals_raising_error για έλεγχο των εισαγωγών εγγραφών στον
# πίνακα new_dept με αρνητικό κωδικό τμήματοςalter
DROP TRIGGER IF EXISTS trg_signals_raising_error;
DELIMITER //
CREATE TRIGGER trg_signals_raising_error
BEFORE INSERT ON new_dept
FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
    IF NEW.deptno < 0 THEN
		SET msg = concat('Trying to insert a negative value in deptno: ', cast(NEW.deptno as char));
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
	END IF;
END
//
DELIMITER ;

# Δοκιμές
INSERT INTO new_dept VALUES (1, 'SALES');
SELECT * FROM new_dept;

INSERT INTO new_dept VALUES (1, 'SALES'), (-1, 'ACCOUNTING'), (2, 'RESEARCH');
# Μήνυμα λάθους και καθολική απόρριψη εισαγωγής

INSERT INTO new_dept VALUES (-1, 'ACCOUNTING');
# Μήνυμα λάθους και απόρριψη εισαγωγής