SELECT * FROM tflecommerce.users;
-- 2. Creating a Stored Procedure for User Login
DELIMITER //

CREATE PROCEDURE LoginUser(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT id, username, email
    FROM users
    WHERE username = p_username AND password = p_password;
END //

DELIMITER ;


CALL LoginUser ("shamiksha_chaudhari", "sham2007");
