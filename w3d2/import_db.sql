CREATE TABLE users (
	id INTEGER PRIMARY KEY,
	fname VARCHAR(255) NOT NULL,
	lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
	id INTEGER PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	body VARCHAR(255) NOT NULL,
	author_id INTEGER,

	FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
	id INTEGER PRIMARY KEY,
	question_id INTEGER,
	follower_id INTEGER,

	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (follower_id) REFERENCES users(id)
);

CREATE TABLE replies (
	id INTEGER PRIMARY KEY,
	subject_question_id INTEGER NOT NULL,
	parent_reply_id INTEGER,
	reply_body VARCHAR(255),
	responder_id INTEGER,

	FOREIGN KEY (subject_question_id) REFERENCES questions(id),
	FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
	FOREIGN KEY (responder_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
	id INTEGER PRIMARY KEY,
	question_id INTEGER,
	liker_id INTEGER,

	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (liker_id) REFERENCES users(id)
);

CREATE TABLE tags (
	id INTEGER PRIMARY KEY,
	tag_name VARCHAR(255)
);

CREATE TABLE question_tags (
	id INTEGER PRIMARY KEY,
	question_id INTEGER,
	tag_id INTEGER,

	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (tag_id) REFERENCES tags(id)
);

INSERT INTO users ('fname', 'lname')
	VALUES ('Albert', 'Einstein'), ('Nedward', 'Scissorhands'), ('Kurt', 'Russell');

INSERT INTO questions('title', 'body', 'author_id')
	VALUES ('Babies', 'Where do they come from?', 1),
				 ('Baseball', 'Who won the 1929 World Series?', 2),
				 ('Movies', 'Who was the star of "Escape From New York?"', 3);

INSERT INTO question_followers ('question_id', 'follower_id')
	VALUES (1, 2), (1, 3),

				 (3, 1), (3, 2);

INSERT INTO replies ('subject_question_id', 'parent_reply_id',
										 'reply_body', 'responder_id')
	VALUES (1, NULL, 'The Inventors mansion', 2),
				 (1, 1, 'Not true. The stork.', 3),
			   (2, NULL, 'Probably the Yankees.', 3),
			   (3, NULL, 'Chuck Norris', 1),
			 	 (3, 1, 'Jean Claude van Damme', 2);

INSERT INTO question_likes ('question_id', 'liker_id')
	VALUES (1, 3),
				 (2, 1),
			 	 (3, 1), (3, 2), (3, 3);

INSERT INTO tags ('tag_name')
	VALUES ('html'), ('css'), ('ruby'), ('javascript');

INSERT INTO question_tags ('question_id', 'tag_id')
	VALUES (1, 1), (1, 2), (1, 3),
				 (2, 2),
				 (3, 2), (3, 4);
