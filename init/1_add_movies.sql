-- Add random movies to the database for performance

DELIMITER $$

CREATE PROCEDURE generate_random_movies(IN num_movies INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_title VARCHAR(255);
    DECLARE random_release_date DATE;
    DECLARE random_duration INT;
    DECLARE random_description TEXT;
    DECLARE random_genres JSON;
    DECLARE random_crew JSON;
    DECLARE genre_list JSON;
    DECLARE crew_type_list JSON;
    DECLARE genre_count INT;
    DECLARE crew_count INT;

    -- List of 20 genres
    SET genre_list = JSON_ARRAY(
        'Action', 'Adventure', 'Comedy', 'Drama', 'Horror',
        'Romance', 'Sci-Fi', 'Fantasy', 'Thriller', 'Mystery',
        'Animation', 'Documentary', 'Biography', 'Crime', 'Family',
        'History', 'Musical', 'War', 'Western', 'Sport'
    );

    -- List of crew types
    SET crew_type_list = JSON_ARRAY('Actor', 'Director', 'Producer', 'Writer', 'Cinematographer', 'Editor');

    WHILE i <= num_movies DO
        -- Generate random movie details
        SET random_title = CONCAT('Movie ', i);
        SET random_release_date = DATE_ADD('2000-01-01', INTERVAL FLOOR(RAND() * 8000) DAY);
        SET random_duration = FLOOR(RAND() * 200) + 60;
        SET random_description = CONCAT('Description for movie ', i);

        -- Generate random genres (2-4)
        SET genre_count = FLOOR(RAND() * 3) + 2;
        SET random_genres = JSON_ARRAY();
        WHILE JSON_LENGTH(random_genres) < genre_count DO
            SET random_genres = JSON_ARRAY_APPEND(
                random_genres, '$',
                JSON_UNQUOTE(JSON_EXTRACT(genre_list, CONCAT('$[', FLOOR(RAND() * 20), ']')))
            );
        END WHILE;

        -- Generate random crew members (2-20)
        SET crew_count = FLOOR(RAND() * 19) + 2;
        SET random_crew = JSON_ARRAY();
        WHILE JSON_LENGTH(random_crew) < crew_count DO
            SET @role_type = JSON_UNQUOTE(JSON_EXTRACT(crew_type_list, CONCAT('$[', FLOOR(RAND() * 6), ']')));
            SET random_crew = JSON_ARRAY_APPEND(
                random_crew, '$',
                JSON_OBJECT(
                    'crew_name', CONCAT('Crew Member ', i, '-', JSON_LENGTH(random_crew) + 1),
                    'birth_date', DATE_ADD('1970-01-01', INTERVAL FLOOR(RAND() * 15000) DAY),
                    'biography', CONCAT('Bio for crew member ', i, '-', JSON_LENGTH(random_crew) + 1),
                    'role_type_name', @role_type,
                    'character_name', CASE
                        WHEN @role_type = 'Actor' THEN CONCAT('Character ', i, '-', JSON_LENGTH(random_crew) + 1)
                        ELSE NULL
                    END
                )
            );
        END WHILE;

        -- Call the procedure
        CALL add_movie(random_title, random_release_date, random_duration, random_description, random_genres, random_crew);

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- Example: Generate 100 random movies
CALL generate_random_movies(500);
