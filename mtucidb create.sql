Drop table if exists chair, stgroup, student cascade;

CREATE TABLE chair
(
	id SERIAL PRIMARY KEY, 
	chair_name varchar(128) NOT NULL UNIQUE,
	chair_deanery text NOT NULL 
);

CREATE TABLE stgroup 
(
	id SERIAL  PRIMARY KEY,
	stgroup_name varchar(128)  NOT NULL UNIQUE,
	stgroup_chair varchar REFERENCES chair(chair_name) NOT NULL 
);

CREATE TABLE student 
(
	id SERIAL PRIMARY KEY, 
	student_name varchar(128),
	student_passport varchar(128) NOT NULL,
	student_group varchar REFERENCES stgroup(stgroup_name) NOT NULL 
);
INSERT INTO chair (chair_name, chair_deanery)
VALUES
('ИТ','ИТдек'),
('РИТ','дек');

INSERT INTO stgroup(stgroup_name, stgroup_chair)
VALUES
('ВВИТ','ИТ'),
('ПИ','ИТ'),
('Рад','РИТ'),
('ИТИСС','РИТ');

INSERT INTO student(student_name,student_passport,student_group)
SELECT
  (
    CASE (RANDOM() * 2)::INT
      WHEN 0 THEN 'петя'
      WHEN 1 THEN 'вася'
      WHEN 2 THEN 'саша'
    END
  ) AS student_name,
    (
    CASE (RANDOM() * 2)::INT
      WHEN 0 THEN 'пасп1'
      WHEN 1 THEN 'пасп2'
      WHEN 2 THEN 'пасп3'
    END
  )  AS student_passport,
 	 (
    CASE (RANDOM() * 3)::INT
      WHEN 0 THEN 'ВВИТ'
      WHEN 1 THEN 'ПИ'
      WHEN 2 THEN 'Рад'
	  WHEN 3 THEN 'ИТИСС'
    END
  )  AS student_group
FROM GENERATE_SERIES(1, 20);
