  CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
  );

  INSERT INTO
    users (fname, lname)
  VALUES
    ('Elliot', 'Reed'),
    ('Joshua', 'Penman'),
    ('Eleanor', 'Roosevelt');



  CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER REFERENCES users(id)
  );

  INSERT INTO
    questions (title, body, author_id)
  VALUES
    ('What is it like to be First Lady?', 'Did you enjoy being First Lady?', 2),
    ('Which form of caffeine do you prefer?', 'Tea or coffee?', 1);

  CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    follower_id INTEGER NOT NULL REFERENCES users(id),
    question_id INTEGER NOT NULL REFERENCES questions(id)
  );

  INSERT INTO
    question_follows (follower_id, question_id)
  VALUES
    (2, 1),
    (3, 2),
    (3, 1);

  CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL REFERENCES questions(id),
    parent_id INTEGER REFERENCES replies(id),
    author_id INTEGER NOT NULL REFERENCES users(id),
    body TEXT NOT NULL
  );

  INSERT INTO replies
    (question_id, parent_id, author_id, body)
  VALUES
    (1, NULL, 3, 'I liked it!'),
    (2, NULL, 2, 'Transdermal'),
    (2, 2, 1, 'What does that mean?');

  CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    liker_id INTEGER NOT NULL REFERENCES users(id),
    question_id INTEGER NOT NULL REFERENCES questions(id)
  );

  INSERT INTO question_likes
    (liker_id, question_id)
  VALUES
    (2, 2),
    (1, 1);
