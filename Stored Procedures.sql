CREATE PROCEDURE GetMaxQuantity() SELECT MAX(Quantity) AS "Max Quantity in Order" FROM Orders;

CALL GetMaxQuantity();

DROP PROCEDURE CancelOrder;


DELIMITER //
CREATE PROCEDURE CancelOrder(IN order_id INT, OUT Confirmation VARCHAR(255)) 
BEGIN
DECLARE rowCount INT;
SELECT COUNT(*) INTO rowCount
FROM Orders WHERE OrderID = order_id;
IF rowCount > 0 THEN
	DELETE FROM Orders WHERE OrderID = order_id;
    SET Confirmation = CONCAT('Order ', order_id, ' is cancelled.');
ELSE
	SET Confirmation = CONCAT('Order ', order_id, ' does not exist.');
END IF;
END //
DELIMITER ;

SET @confirmation = '';

CALL CancelOrder(1, @confirmation);

SELECT @confirmation AS ConfirmationMessage;



