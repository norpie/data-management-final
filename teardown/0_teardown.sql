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
DROP PROCEDURE IF EXISTS add_review;

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
