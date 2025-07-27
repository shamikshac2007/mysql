SELECT * FROM tflecommerce.closed_dates;
SELECT * FROM tflecommerce.orders;

-- 9. Trigger to Prevent Orders from Being Placed on Closed Dates

DROP TRIGGER IF EXISTS tflecommerce.before_order_insert_prevent_orders;

DELIMITER //

CREATE TRIGGER before_order_insert_prevent_orders
BEFORE INSERT ON orders 
FOR EACH ROW 
BEGIN 
    -- Assuming store closed dates are stored in a 'closed_dates' tables
    IF EXISTS (
	   SELECT 1 
       FROM closed_dates 
       WHERE closed_dates = NEW.order_date
    ) THEN 
	   SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Cannot place orders on closed dates' ;
    END IF ;
END //

DELIMITER ;

-- example to check if the trigger works 

-- first inserting a demo date into closed_dates tables 
INSERT INTO closed_dates (closed_dates, events)
VALUES ('2025-01-26 00:00:00', 'Republic Day');

-- now inserting the same demo date in orders table 
INSERT INTO orders (customer_id, order_date, shipping_address, total_amount, shipping_date, status)
VALUES (1, '2025-01-26', '11 paud road', 100.00, NULL, 'Pending');
 
    