-- 10. Trigger to Automatically Update User Points Based on Order Total 

DELIMITER //

CREATE TRIGGER update_user_points
AFTER INSERT ON orders 
FOR EACH ROW 
BEGIN 
	-- Asumming 1 point per 10 units of order total
    UPDATE users 
    SET points = points + FLOOR(NEW.total_amount / 10)
    WHERE id = NEW.customer_id ;
END //

DELIMITER ;
    