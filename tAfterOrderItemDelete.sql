SELECT * FROM order_items;
SELECT * FROM inventory;
-- 14. Trigger for delete on order_items

DELIMITER //

CREATE TRIGGER after_order_item_delete  
AFTER DELETE ON order_items
FOR EACH ROW 
BEGIN 
    UPDATE inventory
    SET stock_quantity = stock_quantity + OLD.quantity 
    WHERE product_id = OLD.item_id ;
END //

DELIMITER ;


-- example 
DELETE FROM order_items WHERE order_id = 1 AND item_id = 1;
SELECT * FROM inventory WHERE product_id = 1;    