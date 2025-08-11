SELECT * FROM order_items;
SELECT * FROM products;
SELECT * FROM orders;
USE tflecommerce;
-- 15. Trigger for after insert on order_items
-- Automatically set order status based on inventory levels 

DELIMITER //

CREATE TRIGGER after_order_item_insert
AFTER INSERT ON order_items
FOR EACH ROW 
BEGIN 
    DECLARE available_stock INT ;
    
    -- Check the stock for the newly inserted item 
    SELECT stock INTO available_stock 
    FROM products 
    WHERE id = NEW.item_id ;
    
    -- If stock is insufficient set order status to 'cancelled'
    IF available_stock < NEW.quantity THEN 
       UPDATE orders
       SET status = 'Cancelled'
       WHERE id = NEW.order_id;
    END IF;
END //

DELIMITER ;


-- checking whether it works
SELECT * FROM orders WHERE id = 2;
SELECT stock FROM products WHERE id = 2;

INSERT INTO order_items (order_id, item_id, quantity) VALUES (2, 2, 50);
   
       