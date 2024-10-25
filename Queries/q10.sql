DROP FUNCTION IF EXISTS factorial;
DELIMITER !
CREATE FUNCTION factorial(N int)
RETURNS int
DETERMINISTIC
BEGIN
	DECLARE F int DEFAULT 1;
    WHILE N > 0 DO
		SET F = N * F;
        SET N = N - 1;
	END WHILE;
RETURN F;
END !
DELIMITER ;

# (α) Εμφάνισε το αποτέλεσμα του 4!
SELECT factorial(4);

# (β) Εμφάνισε το αποτέλεσμα του 15!
SELECT factorial(15);
# Error Code: 1264. Out of range value for column 'F' at row 1	
# Το αποτέλεσμα του παραγοντικού 15! ξεπερνάει την μέγιστη τιμή
# που μπορεί να αποθηκευτεί σε τύπου int
