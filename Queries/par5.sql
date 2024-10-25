# Δημιουργία procedure Divide by zero για έλεγχο ύπαρξης διαίρεσης με το 0
DELIMITER $$
DROP PROCEDURE IF EXISTS Divide_by_zero;
CREATE PROCEDURE Divide_by_zero (IN numerator INT, IN denominator INT, OUT results INT)
BEGIN
DECLARE div_by_zero CONDITION FOR SQLSTATE '22012';
DECLARE CONTINUE HANDLER FOR div_by_zero RESIGNAL SET MESSAGE_TEXT = 'Division by zero';
IF denominator = 0 THEN
	SIGNAL div_by_zero;
ELSE 
	SET results := numerator/denominator;
END IF;
END ;
$$
DELIMITER ;

# Δοκιμή
CALL Divide_by_zero(100, 50, @results);
SELECT @results;
# 100/50 = 2
CALL Divide_by_zero(100, 0, @results);
#ERROR 1644(22012): Division by zero
