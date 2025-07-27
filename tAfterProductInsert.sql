SELECT * FROM tflecommerce.product_audit;
-- 11.Trigger for Insert on Products 

DELIMITER //

CREATE TRIGGER after_product_insert
AFTER INSERT ON inventory 
FOR EACH ROW 
BEGIN
INSERT INTO product_audit(product_id, action_type, new_stock_quantity, action_timestamp)
VALUES (NEW.product_id, 'INSERT', NEW.stock_quantity, NOW()) ;
END //

DELIMITER ;
