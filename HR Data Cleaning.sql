USE project;
SELECT * FROM HR;
ALTER TABLE hr
CHANGE COLUMN ï»¿id employee_id VARCHAR(25) NULL;

DESCRIBE HR;
SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE HR
SET birthdate = CASE
	WHEN birthdate LIKE "%/%" THEN date_format(str_to_date(birthdate, "%m/%d/%Y"), "%Y-%m-%d")
    WHEN birthdate LIKE "%-%" THEN date_format(str_to_date(birthdate, "%m-%d-%Y"), "%Y-%m-%d")
    ELSE NULL
END;

ALTER TABLE HR
MODIFY COLUMN birthdate DATE;

DESCRIBE HR;


UPDATE HR
SET hire_date = CASE
	WHEN hire_date LIKE "%/%" THEN date_format(str_to_date(hire_date, "%m/%d/%Y"), "%Y-%m-%d")
    WHEN hire_date LIKE "%-%" THEN date_format(str_to_date(hire_date, "%m-%d-%Y"), "%Y-%m-%d")
    ELSE NULL
END;

SET sql_mode = '';
UPDATE HR 
SET termdate = IF(termdate IS NOT NULL AND termdate != "", 
date(str_to_date(termdate, "%Y-%m-%d %H:%i:%s UTC")), "0000-00-00")
WHERE true;

SELECT termdate FROM hr; 
SET sql_mode = "allow_invalid_dates" ;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

ALTER TABLE HR 
ADD COLUMN age INT;


UPDATE HR
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM HR;

SELECT 
	MIN(age) AS youngest,
    MAX(age) AS oldest
FROM HR;


SELECT COUNT(*) FROM HR 
WHERE age < 18;