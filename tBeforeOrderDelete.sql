SELECT * FROM tflecommerce.orders;
SELECT * FROM tflecommerce.archieved_orders;
-- 7. Trigger to Archive Orders Before Deletion 

DELIMITER //

CREATE TRIGGER before_order_delete 
BEFORE DELETE ON orders 
FOR EACH ROW 
BEGIN 
    -- insert the order into the archieved_orders table 
    INSERT INTO archieved_orders (id, order_date, customer_id, total_amount, STATUS)
    VALUES (OLD.id, OLD.order_date, OLD.customer_id, OLD.total_amount, OLD.STATUS);
END//

DELIMITER ;
    