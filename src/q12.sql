# // Δοκιμές χρήσης της συνάρτησης MOD
SET @p_no = 3;
# (α) Εμφάνισε το αποτέλεσμα της πράξης 3 mod 2
SELECT MOD(@p_no, 2);
SET @p_no = 8;
# (β) Εμφάνισε το αποτέλεσμα της πράξης 8 mod 2
SELECT MOD(@p_no, 2);

# Δημιουργία βάσης και πίνακα
DROP DATABASE IF EXISTS trace;
CREATE DATABASE trace;
USE trace;
DROP TABLE IF EXISTS myTrace;
CREATE TABLE myTrace (t_no INT,
t_user CHAR(20),
t_date DATE,
t_time TIME,
t_proc VARCHAR(16),
t_what VARCHAR(30));

# Δημιουργία αποθηκευμένης διαδικασίας myProc
DROP PROCEDURE IF EXISTS myProc;
DELIMITER !
CREATE PROCEDURE myProc (IN p_no int, IN p_in VARCHAR(30),
		OUT p_out VARCHAR(30))
LANGUAGE SQL
BEGIN
	SET p_out = p_in;
    INSERT INTO myTrace (t_no, t_user, t_date, t_time, t_proc, t_what)
		VALUES (p_no, current_user, current_date, current_time, 'myProc', p_in);
	IF (MOD(p_no, 2) = 0) THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
END !
DELIMITER ;

# Κλήση της διαδικασίας
SET AUTOCOMMIT = 0;
CALL myProc(1, 'hello1', @out);
CALL myProc(2, 'hello2', @out);
CALL myProc(3, 'hello3', @out);
CALL myProc(4, 'hello4', @out);
CALL myProc(5, 'hello5', @out);
CALL myProc(6, 'hello6', @out);
CALL myProc(7, 'hello7', @out);

# (γ) Εμφάνισε τα περιεχόμενα του πίνακα myTrace
SELECT * FROM myTrace;