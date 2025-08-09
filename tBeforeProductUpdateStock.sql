SELECT * FROM products;
SELECT * FROM inventory;
SELECT * FROM product_audit;
-- 12. Trigger for update on products 


DROP TRIGGER before_product_update_stock;


DELIMITER //

CREATE TRIGGER before_product_update_stock
BEFORE UPDATE ON inventory 
FOR EACH ROW 
BEGIN 
    INSERT INTO product_audit(inventory_id, action_type, old_stock_quantity, new_stock_quantity )
    VALUES (OLD.inventory_id, 'UPDATE', OLD.stock_quantity, NEW.stock_quantity);
END//

DELIMITER ;


-- updating on inventory to check whether it updates or not 
UPDATE inventory 
SET stock_quantity = 600
WHERE product_id = 1 ;

    