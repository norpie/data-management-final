-- # Films en Entertainment
--
-- ## Algemene Beschrijving
--
-- De database zal dienen als de backend voor een online filmcatalogus.  Deze catalogus bevat data over films, acteurs, regisseurs, genres en ratings van gebruikers.
--
-- Het doel is om een uitgebreide database te bouwen waarmee gebruikers informatie kunnen opzoeken over films, cast- en crewleden kunnen verbinden met films en gebruikers beoordelingen en recensies kunnen
-- toevoegen.
--
-- ## Vragen & Antwoorden
--
-- 1. Voor wat gaat de database worden gebruikt?
--     - Voor een online platform dat filmfans toegang biedt tot een uitgebreide filmcatalogus, met informatie zoals:
--         - Titels, samenvattingen, genres, releasedata, duur, …
--         - Cast en crew, inclusief acteurs en regisseurs.
--         - Gebruikersbeoordelingen en recensies.
--     - Gebruik wordt gemaakt van de database voor het genereren van overzichten, zoals:
--         - Topfilms per genre.
--         - Films met de hoogste gebruikersscores.
-- 2. Wie zal toegang hebben tot de database?
--     - Applicaties: De web- en mobiele applicaties maken directe queries om gegevens op te halen.
--     - Beheerders: Kunnen data invoeren en bijwerken, zoals het toevoegen van nieuwe films of acteurs.
--     - Externe API's: Voor het importeren van filminformatie van derde partijen, zoals IMDb.
--
-- ## Structuur van de database
--
-- - **Movies**: Bevat details zoals titel, releasedatum, duur, samenvatting.
-- - **Genres**: Een film kan meerdere genres hebben.
-- - **Crew**: Met informatie zoals naam, geboortedatum, biografie.
-- - **Roles**: Verbindt crew met hun specifieke rollen (zowel voor acteurs als voor crew, denk aan componist, regisseur, custume design, …) in films.
-- - **UserReviews**: Beoordelingen en recensies van gebruikers.
--
-- ## Features
-- 1. Sequences
--     - ID-generatoren: Sequences voor unieke ID's van films, gebruikers, en recensies. Een ID bestaat minstens uit 6  getallen, dus de eerst mogelijke ID is 100000
-- 2. Triggers
--     - Validatie: Een trigger controleert of een beoordelingsscore binnen een geldig bereik (1-10) valt.
--     - Auditlog: Een trigger slaat wijzigingen in filminformatie op in een auditlogtabel.
-- 3. Procedures
--     - Toevoegen van een nieuwe film: Een procedure voor het invoeren van een film, inclusief validaties voor genres en betrokkenen. Indien een film een genre meekrijgt dat nog niet bestaat zal dit genre moeten aangemaakt worden.
-- 4. Views
--     - Topfilms per genre.
--     - Films met de hoogste gebruikersscores.
--
-- ## Veiligheid
-- 1. Toegangsniveaus
--     - Admin-gebruikers: Volledige toegang tot alle tabellen.
--     - Contributors: Toegang om informatie toe te voegen of up te daten in de films, crew, …
--     - Externe API's: Alleen-lezen toegang tot specifieke tabellen zoals films en genres.
-- 2. Gegevenstoegang
--     - Rollen en rechten: Toegang wordt gecontroleerd met specifieke rollen (API_ACCESS, CONTRIBUTOR, ADMIN).
-- 3. Encryptie
--     - Gevoelige gegevens zoals gebruikerswachtwoorden worden gehashed opgeslagen.

-- Create the database
CREATE DATABASE IF NOT EXISTS film_catalog;
USE film_catalog;

-- Drop the tables if they exist
DROP TABLE IF EXISTS user_reviews;
DROP TABLE IF EXISTS audit_log;
DROP TABLE IF EXISTS movie_crew_roles;
DROP TABLE IF EXISTS crew;
DROP TABLE IF EXISTS role_types;
DROP TABLE IF EXISTS movie_genres;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS users;

-- Drop the triggers if they exist
DROP TRIGGER IF EXISTS validate_rating;
DROP TRIGGER IF EXISTS audit_log_after_insert;
DROP TRIGGER IF EXISTS audit_log_after_update;
DROP TRIGGER IF EXISTS audit_log_after_delete;

-- Drop the procedures if they exist
DROP PROCEDURE IF EXISTS add_movie;
DROP PROCEDURE IF EXISTS validate_password;
DROP PROCEDURE IF EXISTS hash_password;
DROP PROCEDURE IF EXISTS add_user;

-- Drop the views if they exist
DROP VIEW IF EXISTS top_movies_per_genre;
DROP VIEW IF EXISTS top_rated_movies;

-- Drop the default users
DROP USER IF EXISTS 'admin'@'%';
DROP USER IF EXISTS 'contributor'@'%';
DROP USER IF EXISTS 'api_access'@'%';

-- Drop the roles
DROP ROLE IF EXISTS API_ACCESS;
DROP ROLE IF EXISTS CONTRIBUTOR;
DROP ROLE IF EXISTS ADMIN;

-- Create the tables
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    duration INT, -- in minutes
    summary TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) AUTO_INCREMENT = 100000;

CREATE TABLE movie_genres (
    movie_id INT,
    genre_id BIGINT UNSIGNED,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE crew (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birth_date DATE,
    biography TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE role_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE movie_crew_roles (
    movie_id INT,
    crew_id BIGINT UNSIGNED,
    role_type_id BIGINT UNSIGNED,
    character_name VARCHAR(255), -- For actors
    PRIMARY KEY (movie_id, crew_id, role_type_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (crew_id) REFERENCES crew(id),
    FOREIGN KEY (role_type_id) REFERENCES role_types(id)
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) AUTO_INCREMENT = 100000;

CREATE TABLE user_reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 10),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
) AUTO_INCREMENT = 100000;

CREATE TABLE audit_log (
    id SERIAL PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    record_id INT NOT NULL,
    action_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    old_value JSON,
    new_value JSON,
    user_id INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create the triggers
DELIMITER //
CREATE TRIGGER validate_rating
BEFORE INSERT ON user_reviews
FOR EACH ROW
BEGIN
    IF NEW.rating < 1 OR NEW.rating > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating must be between 1 and 10';
    END IF;
END //


CREATE TRIGGER audit_log_after_insert
AFTER INSERT ON movies
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, record_id, action_type, old_value, new_value, user_id)
    VALUES (
        'movies',
        NEW.id,
        'INSERT',
        JSON_OBJECT(),
        JSON_OBJECT('title', NEW.title, 'release_date', NEW.release_date, 'duration', NEW.duration, 'summary', NEW.summary),
        @user_id
    );
END //

CREATE TRIGGER audit_log_after_update
AFTER UPDATE ON movies
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, record_id, action_type, old_value, new_value, user_id)
    VALUES (
        'movies',
        NEW.id,
        'UPDATE',
        JSON_OBJECT('title', OLD.title, 'release_date', OLD.release_date, 'duration', OLD.duration, 'summary', OLD.summary),
        JSON_OBJECT('title', NEW.title, 'release_date', NEW.release_date, 'duration', NEW.duration, 'summary', NEW.summary),
        @user_id
    );
END //

CREATE TRIGGER audit_log_after_delete
AFTER DELETE ON movies
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, record_id, action_type, old_value, new_value, user_id)
    VALUES (
        'movies',
        OLD.id,
        'DELETE',
        JSON_OBJECT('title', OLD.title, 'release_date', OLD.release_date, 'duration', OLD.duration, 'summary', OLD.summary),
        JSON_OBJECT(),
        @user_id
    );
END //

-- Create the procedures
CREATE PROCEDURE add_movie(
    IN title VARCHAR(255),
    IN release_date DATE,
    IN duration INT,
    IN summary TEXT,
    IN genre_names JSON,
    IN crew_data JSON
)
BEGIN
    DECLARE movie_id INT;

    -- Insert movie
    INSERT INTO movies (title, release_date, duration, summary)
    VALUES (title, release_date, duration, summary);
    SET movie_id = LAST_INSERT_ID();

    -- Insert genres if they do not exist
    INSERT INTO genres (name)
    SELECT DISTINCT genre_name
    FROM JSON_TABLE(genre_names, '$[*]' COLUMNS (genre_name VARCHAR(50) PATH '$')) AS genre_list
    WHERE NOT EXISTS (
        SELECT 1 FROM genres WHERE name = genre_name
    );

    -- Link movie with genres
    INSERT INTO movie_genres (movie_id, genre_id)
    SELECT movie_id, id
    FROM genres
    WHERE name IN (
        SELECT genre_name
        FROM JSON_TABLE(genre_names, '$[*]' COLUMNS (genre_name VARCHAR(50) PATH '$')) AS genre_list
    );

    -- Insert crew if they do not exist
    INSERT INTO crew (name, birth_date, biography)
    SELECT DISTINCT crew_name, birth_date, biography
    FROM JSON_TABLE(crew_data, '$[*]' COLUMNS (
        crew_name VARCHAR(255) PATH '$.crew_name',
        birth_date DATE PATH '$.birth_date',
        biography TEXT PATH '$.biography'
    )) AS crew_list
    WHERE NOT EXISTS (
        SELECT 1 FROM crew WHERE name = crew_name
    );

    -- Link movie with crew roles
    INSERT INTO movie_crew_roles (movie_id, crew_id, role_type_id, character_name)
    SELECT movie_id, crew.id, role_type, character_name
    FROM JSON_TABLE(crew_data, '$[*]' COLUMNS (
        crew_name VARCHAR(255) PATH '$.crew_name',
        role_type INT PATH '$.role_type',
        character_name VARCHAR(255) PATH '$.character_name'
    )) AS crew_roles
    JOIN crew ON crew.name = crew_name;
END //

CREATE PROCEDURE validate_password(
    IN password VARCHAR(255),
    IN hashed_password VARCHAR(255),
    OUT is_valid TINYINT(1) -- Use TINYINT(1) instead of BOOLEAN
)
BEGIN
    DECLARE salt CHAR(32); -- Adjusted to store HEX representation (16 bytes = 32 HEX characters)
    SET salt = SUBSTRING(hashed_password, 1, 32); -- Extract the salt (32 HEX characters)
    SET is_valid = (hashed_password = CONCAT(salt, ':', SHA2(CONCAT(salt, password), 256)));
END //

CREATE PROCEDURE hash_password(
    IN password VARCHAR(255),
    OUT hashed_password VARCHAR(255)
)
BEGIN
    DECLARE salt CHAR(32); -- Use HEX encoding for salt (16 bytes = 32 HEX characters)
    SET salt = UPPER(HEX(RANDOM_BYTES(16))); -- Generate random 16-byte salt and convert to HEX
    SET hashed_password = CONCAT(salt, ':', SHA2(CONCAT(salt, password), 256)); -- Hash with salt
END //

CREATE PROCEDURE add_user(
    IN username VARCHAR(50),
    IN password VARCHAR(255)
)
BEGIN
    DECLARE hashed_password VARCHAR(255);
    CALL hash_password(password, hashed_password);
    INSERT INTO users (username, password_hash)
    VALUES (username, hashed_password);
    SET @query = CONCAT('CREATE USER ', username, '@''%'' IDENTIFIED BY ''', password, '''');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- Create 3 default users
-- - Admin: admin / admin
-- - Contributor: contributor / contributor
-- - API Access: api_access / api_access

CALL add_user('admin', 'admin');
CALL add_user('contributor', 'contributor');
CALL add_user('api_access', 'api_access');

-- Create the views
CREATE VIEW top_movies_per_genre AS
SELECT g.name AS genre, m.title AS movie, AVG(ur.rating) AS average_rating
FROM genres g
JOIN movie_genres mg ON g.id = mg.genre_id
JOIN movies m ON mg.movie_id = m.id
LEFT JOIN user_reviews ur ON m.id = ur.movie_id
GROUP BY g.name, m.title
ORDER BY g.name, AVG(ur.rating) DESC;

CREATE VIEW top_rated_movies AS
SELECT m.title AS movie, AVG(ur.rating) AS average_rating
FROM movies m
LEFT JOIN user_reviews ur ON m.id = ur.movie_id
GROUP BY m.title
ORDER BY AVG(ur.rating) DESC;

-- Roles

CREATE ROLE API_ACCESS, CONTRIBUTOR, ADMIN;

-- Grant roles to the 3 default users
GRANT API_ACCESS TO 'api_access'@'%';
GRANT CONTRIBUTOR TO 'contributor'@'%';
GRANT ADMIN TO 'admin'@'%';

-- Set default roles
SET DEFAULT ROLE ADMIN TO 'admin'@'%';
SET DEFAULT ROLE CONTRIBUTOR TO 'contributor'@'%';
SET DEFAULT ROLE API_ACCESS TO 'api_access'@'%';

-- Admin & Contributor common permissions
GRANT SELECT, INSERT, UPDATE ON movies TO ADMIN, CONTRIBUTOR;
GRANT SELECT, INSERT, UPDATE ON genres TO ADMIN, CONTRIBUTOR;
GRANT SELECT, INSERT, UPDATE ON movie_genres TO ADMIN, CONTRIBUTOR;
GRANT SELECT, INSERT, UPDATE ON crew TO ADMIN, CONTRIBUTOR;
GRANT SELECT, INSERT, UPDATE ON role_types TO ADMIN, CONTRIBUTOR;
GRANT SELECT, INSERT, UPDATE ON movie_crew_roles TO ADMIN, CONTRIBUTOR;
GRANT SELECT, INSERT, UPDATE ON user_reviews TO ADMIN, CONTRIBUTOR;
GRANT EXECUTE ON PROCEDURE add_movie TO ADMIN, CONTRIBUTOR;

-- Admin permissions
GRANT SELECT, INSERT, UPDATE ON users TO ADMIN;
GRANT SELECT ON audit_log TO ADMIN;
GRANT EXECUTE ON PROCEDURE add_user TO ADMIN;

-- API Access permissions
GRANT SELECT ON movies TO API_ACCESS;
GRANT SELECT ON genres TO API_ACCESS;
GRANT SELECT ON movie_genres TO API_ACCESS;
GRANT SELECT ON crew TO API_ACCESS;
GRANT SELECT ON role_types TO API_ACCESS;
GRANT SELECT ON movie_crew_roles TO API_ACCESS;
GRANT SELECT ON user_reviews TO API_ACCESS;
GRANT SELECT ON top_movies_per_genre TO API_ACCESS;
GRANT SELECT ON top_rated_movies TO API_ACCESS;
