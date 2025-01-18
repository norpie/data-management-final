CALL add_movie(
    'Iron Man',
    '2008-05-02',
    126,
    'After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil.',
    JSON_ARRAY('Action', 'Adventure', 'Sci-Fi'),
    JSON_ARRAY(
        JSON_OBJECT('crew_name', 'Robert Downey Jr.', 'birth_date', '1965-04-04', 'biography', 'Plays Tony Stark', 'role_type_name', 'Actor', 'character_name', 'Tony Stark'),
        JSON_OBJECT('crew_name', 'Jon Favreau', 'birth_date', '1966-10-19', 'biography', 'Directed the movie', 'role_type_name', 'Director', 'character_name', NULL)
    )
);

CALL add_movie(
    'The Incredible Hulk',
    '2008-06-13',
    112,
    'Bruce Banner, a scientist on the run from the U.S. Government, must find a cure for the monster he becomes whenever he loses his temper.',
    JSON_ARRAY('Action', 'Adventure', 'Sci-Fi'),
    JSON_ARRAY(
        JSON_OBJECT('crew_name', 'Edward Norton', 'birth_date', '1969-08-18', 'biography', 'Plays Bruce Banner', 'role_type_name', 'Actor', 'character_name', 'Bruce Banner'),
        JSON_OBJECT('crew_name', 'Louis Leterrier', 'birth_date', '1973-06-17', 'biography', 'Directed the movie', 'role_type_name', 'Director', 'character_name', NULL)
    )
);

CALL add_movie(
    'Iron Man 2',
    '2010-05-07',
    124,
    'With the world now aware of his identity as Iron Man, Tony Stark faces pressure from all sides to share his technology.',
    JSON_ARRAY('Action', 'Adventure', 'Sci-Fi'),
    JSON_ARRAY(
        JSON_OBJECT('crew_name', 'Robert Downey Jr.', 'birth_date', '1965-04-04', 'biography', 'Plays Tony Stark', 'role_type_name', 'Actor', 'character_name', 'Tony Stark'),
        JSON_OBJECT('crew_name', 'Jon Favreau', 'birth_date', '1966-10-19', 'biography', 'Directed the movie', 'role_type_name', 'Director', 'character_name', NULL)
    )
);

CALL add_movie(
    'The Avengers',
    '2012-05-04',
    143,
    'Earth''s mightiest heroes must come together and learn to fight as a team if they are to stop the mischievous Loki and his alien army from enslaving humanity.',
    JSON_ARRAY('Action', 'Adventure', 'Sci-Fi'),
    JSON_ARRAY(
        JSON_OBJECT('crew_name', 'Robert Downey Jr.', 'birth_date', '1965-04-04', 'biography', 'Plays Tony Stark', 'role_type_name', 'Actor', 'character_name', 'Tony Stark'),
        JSON_OBJECT('crew_name', 'Chris Evans', 'birth_date', '1981-06-13', 'biography', 'Plays Steve Rogers', 'role_type_name', 'Actor', 'character_name', 'Steve Rogers'),
        JSON_OBJECT('crew_name', 'Joss Whedon', 'birth_date', '1964-06-23', 'biography', 'Directed the movie', 'role_type_name', 'Director', 'character_name', NULL)
    )
);

CALL add_movie(
    'Avengers: Endgame',
    '2019-04-26',
    181,
    'After the devastating events of Avengers: Infinity War, the Avengers assemble once more to reverse Thanos'' actions and restore balance to the universe.',
    JSON_ARRAY('Action', 'Adventure', 'Sci-Fi'),
    JSON_ARRAY(
        JSON_OBJECT('crew_name', 'Robert Downey Jr.', 'birth_date', '1965-04-04', 'biography', 'Plays Tony Stark', 'role_type_name', 'Actor', 'character_name', 'Tony Stark'),
        JSON_OBJECT('crew_name', 'Chris Evans', 'birth_date', '1981-06-13', 'biography', 'Plays Steve Rogers', 'role_type_name', 'Actor', 'character_name', 'Steve Rogers'),
        JSON_OBJECT('crew_name', 'Anthony Russo', 'birth_date', '1970-02-03', 'biography', 'Directed the movie', 'role_type_name', 'Director', 'character_name', NULL),
        JSON_OBJECT('crew_name', 'Joe Russo', 'birth_date', '1971-07-18', 'biography', 'Directed the movie', 'role_type_name', 'Director', 'character_name', NULL)
    )
);
