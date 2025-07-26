SELECT * FROM tflecommerce.products;
-- 2. Trigger to Prevent Deletion of a Product with Existing Order

DELIMITER //
CREATE TRIGGER before_product_delete
BEFORE DELETE ON products
FOR EACH ROW 
BEGIN
    -- Check if the product is present in any order
    IF EXISTS (
        SELECT 1
        FROM order_items oi
        WHERE oi.item_id = OLD.id 
	) THEN 
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Cannot delete product with existing order.";
    END IF ;
 END //
 
 DELIMITER ;
 
 
 INSERT INTO products (id, name, description, price, stock, category_id) VALUES
(21, 'Bluetooth Earbuds', 'True wireless Bluetooth earbuds.', 69.99, 75, 1);
 