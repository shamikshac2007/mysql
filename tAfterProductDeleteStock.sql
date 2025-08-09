SELECT * FROM inventory;
SELECT * FROM product_audit;
-- 13.Trigger to delete on products 

DROP TRIGGER after_product_delete_stock;
DELIMITER //

CREATE TRIGGER after_product_delete_stock
AFTER DELETE ON inventory
FOR EACH ROW
BEGIN
    INSERT INTO product_audit(inventory_id, action_type, old_stock_quantity)
    VALUES (OLD.inventory_id, 'DELETE', OLD.stock_quantity);
END //

DELIMITER ;   
DELIMITER //

CREATE TRIGGER after_product_delete_stock
AFTER DELETE ON inventory
FOR EACH ROW
BEGIN
    INSERT INTO product_audit(inventory_id, action_type, old_stock_quantity)
    VALUES (OLD.inventory_id, 'DELETE', OLD.stock_quantity);
END //

DELIMITER ;   


-- delete something from inventory 
DELETE FROM inventory WHERE product_id = 3;



 

