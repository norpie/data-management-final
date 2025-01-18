-- 100000   Iron Man
-- 100001   The Incredible Hulk
-- 100002   Iron Man 2
-- 100003   The Avengers
-- 100004   Avengers: Endgame

-- 100003   user1
-- 100004   user2
-- 100005   user3
-- 100006   user4
-- 100007   user5
-- 100008   user6
-- 100009   user7

-- add_review(user_id, movie_id, rating(1-10), review)

-- Reviews for Iron Man
add_review(100003, 100000, 8, 'Great start to the MCU, Robert Downey Jr. is fantastic!');
add_review(100004, 100000, 7, 'Solid action movie, but a bit predictable.');
add_review(100005, 100000, 9, 'Loved the character development and tech.');
add_review(100006, 100000, 6, 'Not bad, but it didn’t blow me away.');
add_review(100007, 100000, 10, 'A perfect superhero movie!');
add_review(100008, 100000, 7, 'Good movie, but lacks depth.');
add_review(100009, 100000, 8, 'The humor and action are well-balanced.');

-- Reviews for The Incredible Hulk
add_review(100003, 100001, 6, 'Lacks the charm of other MCU movies, but not bad.');
add_review(100004, 100001, 5, 'Weak storyline, felt too disconnected from the rest of the MCU.');
add_review(100005, 100001, 7, 'A decent movie, but could have been better.');
add_review(100006, 100001, 6, 'Interesting take on the Hulk, but the pacing is off.');
add_review(100007, 100001, 8, 'The Hulk action scenes were great!');
add_review(100008, 100001, 5, 'Not my favorite, but has some redeeming moments.');
add_review(100009, 100001, 7, 'The CGI was top-notch, but the plot fell flat.');

-- Reviews for Iron Man 2
add_review(100003, 100002, 7, 'Decent sequel, but didn’t live up to the original.');
add_review(100004, 100002, 8, 'Enjoyed it more than the first one, good character development.');
add_review(100005, 100002, 6, 'The pacing was a bit slow, but good overall.');
add_review(100006, 100002, 9, 'Loved the addition of Black Widow and War Machine!');
add_review(100007, 100002, 7, 'Good, but a little too much setup for future films.');
add_review(100008, 100002, 6, 'Had high expectations but felt underwhelming.');
add_review(100009, 100002, 8, 'The action scenes and new characters were amazing.');

-- Reviews for The Avengers
add_review(100003, 100003, 9, 'Amazing team-up movie, the chemistry between characters is perfect.');
add_review(100004, 100003, 10, 'Best superhero movie up until that point!');
add_review(100005, 100003, 8, 'A bit too much action, but still very enjoyable.');
add_review(100006, 100003, 10, 'It was awesome seeing all these heroes together!');
add_review(100007, 100003, 9, 'Great film, the villains were also compelling.');
add_review(100008, 100003, 8, 'Really good, but I felt like the plot was a bit thin.');
add_review(100009, 100003, 9, 'Epic battles and great character moments.');

-- Reviews for Avengers: Endgame
add_review(100003, 100004, 10, 'A perfect conclusion to the Infinity Saga!');
add_review(100004, 100004, 9, 'Emotional and thrilling, but felt a little long.');
add_review(100005, 100004, 10, 'The payoff for all the build-up was worth it.');
add_review(100006, 100004, 8, 'Great movie, but some of the time travel stuff was confusing.');
add_review(100007, 100004, 9, 'Amazing, but I wished for a little more character resolution.');
add_review(100008, 100004, 10, 'A stunning finish to over a decade of films!');
add_review(100009, 100004, 9, 'An incredible movie, but the pacing dragged a bit in the middle.');
