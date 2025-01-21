DELIMITER $$

CREATE PROCEDURE generate_reviews()
BEGIN
    DECLARE done_users INT DEFAULT 0;
    DECLARE done_movies INT DEFAULT 0;
    DECLARE current_user_id INT;
    DECLARE current_movie_id INT;

    -- Cursor for iterating over users
    DECLARE user_cursor CURSOR FOR SELECT id FROM users;
    -- Cursor for iterating over movies
    DECLARE movie_cursor CURSOR FOR SELECT id FROM movies;

    -- Handler for user cursor completion
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_users = 1;

    -- Iterate over all users
    OPEN user_cursor;
    user_loop: LOOP
        FETCH user_cursor INTO current_user_id;
        IF done_users THEN
            LEAVE user_loop;
        END IF;

        -- Reset movie loop flag and open movie cursor
        SET done_movies = 0;
        BEGIN
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_movies = 1;

            OPEN movie_cursor;
            movie_loop: LOOP
                FETCH movie_cursor INTO current_movie_id;
                IF done_movies THEN
                    LEAVE movie_loop;
                END IF;

                -- Generate a random rating and review content
                CALL add_review(
                    current_user_id,
                    current_movie_id,
                    FLOOR(RAND() * 10) + 1, -- Random rating between 1 and 10
                    CONCAT('Review for movie ', current_movie_id, ' by user ', current_user_id)
                );
            END LOOP;
            CLOSE movie_cursor;
        END;
    END LOOP;
    CLOSE user_cursor;
END$$

DELIMITER ;

-- Generate reviews for all users and movies
CALL generate_reviews();
