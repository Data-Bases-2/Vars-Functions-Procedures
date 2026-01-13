# Δημιουργία db delete_orders με πίνακες orders και orderlines
DROP DATABASE IF EXISTS delete_orders;
CREATE DATABASE delete_orders;
USE delete_orders;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (orderno int auto_increment not null, custno int not null, odate datetime not null, primary key(orderno));
DROP TABLE IF EXISTS orderlines;
CREATE TABLE orderlines (orderno int not null, stockno int not null, qty int not null, primary key (orderno, stockno));
DESCRIBE orders;
DESCRIBE orderlines;

SET AUTOCOMMIT = 0;
INSERT INTO orders (custno, odate) VALUES (1, current_timestamp);
INSERT INTO orderlines (orderno, stockno, qty) VALUES (1, 10, 1), (1, 50, 2);
COMMIT;
SELECT * FROM orders;
SELECT * FROM orderlines;

# Δημιουργία trigger delete_orders για έλεγχο των deletes
DROP TRIGGER IF EXISTS delete_orders;
CREATE TRIGGER delete_orders
AFTER DELETE ON orders
FOR EACH ROW
DELETE FROM orderlines WHERE orderno = OLD.orderno;
DELETE FROM orders where orderno = 1;
SELECT * FROM orders;
SELECT * FROM orderlines;
ROLLBACK;
SELECT * FROM orders;
SELECT * FROM orderlines;

# Δημιουργία procedure delete_orders_orderlines για έλεγχο των deletes στον πίνακα orderlines
DROP PROCEDURE IF EXISTS delete_orders_orderlines;
DELIMITER $
CREATE PROCEDURE delete_order_orderlines (IN del_order int)
BEGIN
	DELETE FROM orderlines WHERE orderno = del_order;
    DELETE FROM orders WHERE orderno = del_order;
END;
$
DELIMITER ;

# Δοκιμές 
SET autocommit = 0;
SELECT * FROM orders;
SELECT * FROM orderlines;
CALL delete_order_orderlines(1);
SELECT * FROM orders;
SELECT * FROM orderlines;
ROLLBACK;
SELECT * FROM orders;
SELECT * FROM orderlines;

# Δημιουργία procedure add_order_line για έλεγχο ύπαρξης παραγγελίας
DROP PROCEDURE IF EXISTS add_order_line;
DELIMITER $
CREATE PROCEDURE add_order_line(IN o_no int, IN s_no int, IN qty int)
BEGIN
	DECLARE count_var INT;
	SELECT COUNT(orderno)
	INTO count_var
	FROM orders
	WHERE orderno = o_no;
    IF (count_var <> 1) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order number is not found in orders table';
	END IF;
END;
$
DELIMITER ;

# Δοκιμές
SELECT * FROM orders;
SELECT * FROM orderlines;
CALL add_order_line(2, 10, 1);
# ERROR 1644(45000): Order number is not found in orders table

CALL add_order_line(2, 50, 2);
# ERROR 1644(45000): Order number is not found in orders table

SELECT * FROM orders;
SELECT * FROM orderlines;