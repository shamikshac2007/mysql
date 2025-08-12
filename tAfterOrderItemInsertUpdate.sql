SELECT * FROM order_items;
SELECT * FROM orders;
use tflecommerce;
-- 16. Trigger for after insert on order_items update total order price 

DELIMITER //

CREATE TRIGGER after_order_item_insert_update
AFTER INSERT ON order_items 
FOR EACH ROW 
BEGIN 
	DECLARE total_amount DECIMAL(10, 2) ;
    
    
    -- calculate the new total price for the order using the price from products table 
    SELECT SUM(p.price * oi.quantity) INTO total_amount 
    FROM order_items oi
    JOIN products p ON oi.item_id = p.id
    WHERE oi.order_id = NEW.order_id;
    
    -- update the orders total price 
    UPDATE orders 
    SET total_amount = total_amount 
    WHERE id = NEW.order_id ;
END//

DELIMITER ;

INSERT INTO order_items (order_id, item_id, quantity) VALUES (3, 1 ,3);
    
SELECT * FROM orders WHERE id = 3 ;    
    