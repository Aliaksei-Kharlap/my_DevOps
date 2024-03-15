INSERT INTO customers (first_name)
VALUES ('ADAM');

INSERT INTO customers (first_name)
VALUES ('JOSEPH') RETURNING *;

INSERT INTO customers (first_name)
VALUES ('JOSEPH1') RETURNING customer_id;

SELECT * FROM customers;


INSERT INTO customers (first_name)
VALUES ('ADAM');

INSERT INTO customers (first_name)
VALUES ('JOSEPH') RETURNING *;

INSERT INTO customers (first_name)
VALUES ('JOSEPH1') RETURNING customer_id;

SELECT * FROM customers;





-- create sample table

CREATE TABLE t_tags(
	id serial PRIMARY KEY,
	tag text UNIQUE,
	update_date TIMESTAMP DEFAULT NOW()
);

-- insert some sample data

INSERT INTO t_tags (tag) values
('Pen'),
('Pencil');

-- Lets view the data

SELECT * FROM t_tags;

-- 2020-12-29 19:13:19.392095

-- Lets insert a record, on conflict do noting

INSERT INTO t_tags (tag)
VALUES ('Pen')
ON CONFLICT (tag)
DO
	NOTHING;


SELECT * FROM t_tags;



-- Lets insert a record, on conflict set new values

INSERT INTO t_tags (tag)
VALUES ('Pen')
ON CONFLICT (tag)
DO
	UPDATE SET
		tag = EXCLUDED.tag || '1',
		update_date = NOW();



SELECT * FROM t_tags;

select * from actors;

SELECT column1, column2  FROM t_tags;

SELECT column1 AS col  FROM t_tags;

SELECT column1 AS "col number ONE"  FROM t_tags;


SELECT column1 || column2  FROM t_tags;    will combine them


SELECT * FROM movies ORDER BY column1 ASC;


SELECT * FROM movies ORDER BY column1 ASC, column2 DESC;

SELECT column2, column1 AS col  FROM t_tags ORDER BY col DESC;


SELECT col1, LENGTH(col2) as len FROM actors ORDER BY len DESC;

SELECT column2, column1 AS col  FROM t_tags ORDER BY col DESC NULL FIRST | NULL LAST;


SELECT DISTINCT col, col2 FROM movies;   give you a unique combination

SELECT DISTINCT * FROM movies;


SELECT col1 FROM movies WHERE col2 = 'someText';

SELECT col1 FROM movies WHERE col2 = 'someText' AND col3 = "18";

SELECT col1 FROM movies WHERE col2 = 'someText' OR col3 = "18";

SELECT col1 FROM movies WHERE (col2 = 'someText' OR col3 = "18") AND col3="199";

SELECT * FROM movies WHERE movie_length <> '116';

SELECT * FROM movies WHERE movie_length <> '116' LIMIT 50;

SELECT * FROM movies WHERE movie_length <> '116' LIMIT 50 OFFSET 5;   begin from 6 to 55

















