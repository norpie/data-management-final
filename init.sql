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
-- **Movies**: Bevat details zoals titel, releasedatum, duur, samenvatting.
-- **Genres**: Een film kan meerdere genres hebben.
-- **Crew**: Met informatie zoals naam, geboortedatum, biografie.
-- **Roles**: Verbindt crew met hun specifieke rollen (zowel voor acteurs als voor crew, denk aan componist, regisseur, custume design, …) in films.
-- **UserReviews**: Beoordelingen en recensies van gebruikers.
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
    genre_id INT,
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
    crew_id INT,
    role_type_id INT,
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
    role ENUM('ADMIN', 'CONTRIBUTOR', 'API_ACCESS') NOT NULL,
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
