SELECT * FROM tflecommerce.users;
-- 8. Trigger to Validate User Email Format

DELIMITER //

CREATE TRIGGER before_user_insert 
BEFORE INSERT ON users 
FOR EACH ROW 
BEGIN 
    -- check if email contains "@" and "." 
    IF NEW.email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'THEN 
	   SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = "Invalid email format" ;
    END IF;
END//

DELIMITER ;

-- correct email format 
INSERT INTO users (username, password, email, address) 
VALUES ('john_doe', 'secret123', 'john@example.com', '123 Main St');
-- wrong email format given for checking the error message 
INSERT INTO users (username, password, email, address) 
VALUES ('john_doe', 'secret123', 'johnexamplecom', '123 Main St');
    
    
DELIMITER //

CREATE TRIGGER before_user_update 
BEFORE UPDATE ON users
FOR EACH ROW 
BEGIN 
    -- check if email contains '@' and '.'
    IF NEW.email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$' THEN 
       SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Invalid email format';
    END IF;
END //

DELIMITER ;

INSERT INTO users (username, password, email, address)
VALUES ('megh_shah', 'pass123', 'megh@example.com', '11 Pune Satara rd');

-- correct email format 
UPDATE users
SET email = 'meghshah@example.org'
WHERE username = 'megh_shah';
-- wrong email format given for checking the error message 
UPDATE users
SET email = 'meghshahexample.org'
WHERE username = 'megh_shah';





-- DELIMITER //

-- CREATE TRIGGER before_user_insert_or_update 
-- BEFORE INSERT OR UPDATE ON users
-- FOR EACH ROW 
-- BEGIN 
    -- Check if email contains '@' and '.'
   -- IF NEW.email NOT REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$' THEN 
     --  SIGNAL SQLSTATE '45000'
       -- SET MESSAGE_TEXT = "Invalid email format" ;
    -- END IF ;
-- END //

-- DELIMITER ;
    
    