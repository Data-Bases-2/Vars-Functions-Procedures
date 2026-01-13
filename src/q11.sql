DROP PROCEDURE IF EXISTS my_procedure_Local_Variables;
DELIMITER $$
CREATE PROCEDURE my_procedure_Local_Variables(IN x int, IN y int)
BEGIN
	SET @X = x;
    SET @Y = y;
    SELECT @X, @Y, @X*@Y;
END $$
DELIMITER ;

# (α) Υπολογισμός 25*10
CALL my_procedure_Local_Variables(25, 10);
# (β) Υπολογισμός 50*10
CALL my_procedure_Local_Variables(50, 10);
# (γ) Υπολογισμός 3*5
CALL my_procedure_Local_Variables(3, 5);