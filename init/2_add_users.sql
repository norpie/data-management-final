DELIMITER $$

CREATE PROCEDURE generate_random_users(IN num_users INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_username VARCHAR(255);
    DECLARE random_password VARCHAR(255);
    DECLARE name_list JSON;
    DECLARE adjective_list JSON;

    -- List of random names and adjectives
    SET name_list = JSON_ARRAY('Alpha', 'Bravo', 'Charlie', 'Delta', 'Echo', 'Foxtrot', 'Golf', 'Hotel', 'India', 'Juliet',
                               'Kilo', 'Lima', 'Mike', 'November', 'Oscar', 'Papa', 'Quebec', 'Romeo', 'Sierra', 'Tango');
    SET adjective_list = JSON_ARRAY('Fast', 'Brave', 'Smart', 'Loyal', 'Happy', 'Strong', 'Clever', 'Calm', 'Kind', 'Bold');

    WHILE i <= num_users DO
        -- Generate a random username from a combination of adjectives and names
        SET random_username = CONCAT(
            JSON_UNQUOTE(JSON_EXTRACT(adjective_list, CONCAT('$[', FLOOR(RAND() * 10), ']'))),
            JSON_UNQUOTE(JSON_EXTRACT(name_list, CONCAT('$[', FLOOR(RAND() * 20), ']'))),
            FLOOR(RAND() * 1000)
        );

        -- Generate a random password (8-12 characters long, alphanumeric)
        SET random_password = CONCAT(
            LEFT(MD5(RAND()), FLOOR(RAND() * 5) + 8)
        );

        -- Call the add_user procedure
        CALL add_user(random_username, random_password);

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- Example: Generate 50 random users
CALL generate_random_users(100);
