# Δημιουργία function myFun με commit και rollback
DROP FUNCTION IF EXISTS myFun;
DELIMITER !
CREATE FUNCTION myFun (p_no INT, p_in VARCHAR(30))
RETURNS VARCHAR(30)
LANGUAGE SQL
BEGIN
INSERT INTO myTrace (t_no, t_user, t_date, t_time, t_proc, t_what)
	VALUES (p_no, current_user, current_date, current_time, 'myProc', p_in);
IF (MOD(p_no,2) = 0) THEN
	COMMIT;
ELSE 
	ROLLBACK;
END IF;
RETURN p_in;
END !
DELIMITER ;

#Η συνάρτηση δεν δημιουργείται και επιστρέφει σφάλμα:
#ERROR 1422(HY000): Explicit or implicit commit is not allowed in stored function or trigger
