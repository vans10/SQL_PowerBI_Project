USE project;



# What is the gender breakdown of the company?

SELECT gender, count(*) AS count 
FROM HR
WHERE age >= 18 AND termdate = "0000-00-00"
GROUP BY gender;

# What is the race/ethnicity breakdown of the employees in the company?

SELECT race, count(*) AS count
FROM HR
WHERE age >= 18 AND termdate = "0000-00-00"
GROUP BY race
ORDER BY count(*) DESC;

# What is the age distribution of the employees in the company?

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM HR
WHERE age >= 18 AND termdate = "0000-00-00";

SELECT 
	CASE 
		WHEN age >= 18 AND age <= 24 THEN "18-24"
        WHEN age >= 25 AND age <= 34 THEN "25-34"
        WHEN age >= 35 AND age <= 44 THEN "35-44"
        WHEN age >= 45 AND age <= 54 THEN "44-54"
        WHEN age >= 55 AND age <= 64 THEN "56-64"
        ELSE "65+"
	END AS age_group,
    count(*) AS count
    FROM HR
    WHERE age >= 18 AND termdate = "0000-00-00"
    GROUP BY age_group
    ORDER BY age_group;
    
SELECT 
	CASE 
		WHEN age >= 18 AND age <= 24 THEN "18-24"
        WHEN age >= 25 AND age <= 34 THEN "25-34"
        WHEN age >= 35 AND age <= 44 THEN "35-44"
        WHEN age >= 45 AND age <= 54 THEN "44-54"
        WHEN age >= 55 AND age <= 64 THEN "56-64"
        ELSE "65+"
	END AS age_group, gender, 
    count(*) AS count
    FROM HR
    WHERE age >= 18 AND termdate = "0000-00-00"
    GROUP BY age_group, gender
    ORDER BY age_group, gender;
    
# How many employees work at headquarters versus remote locations?

SELECT location, count(*) AS count
FROM HR
WHERE age >= 18 AND termdate = "0000-00-00"
GROUP BY location;

# What is the average length of employment for employees who have been terminated?

SELECT 
	round(AVG(DATEDIFF(termdate, hire_date))/ 365,0) AS avg_length_employment
FROM hr
WHERE termdate <= curdate()AND termdate <>"0000-00-00" AND age >= 18;

# How does the gender distribution vary across departments and job titles?

SELECT department, gender ,count(*) AS count
FROM HR
WHERE age >= 18 AND termdate = "0000-00-00"
GROUP BY department, gender
ORDER BY department;

# What is the distribution of job titles across the company?

SELECT jobtitle, count(*) AS count
FROM Hr
WHERE age >= 18 AND termdate = "0000-00-00"
GROUP BY jobtitle
ORDER BY jobtitle DESC;

# Which department has the highest turnover rate?

SELECT department,
	total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
FROM (
	SELECT department, 
    count(*) AS total_count,
    SUM(CASE WHEN termdate <> "0000-00-00" AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
    FROM HR
    WHERE age >= 18
    GROUP BY department
    ) AS subquery
ORDER BY termination_rate DESC;

# What is the distribution of employees across locations by city and state?


SELECT location_state, COUNT(*) AS count
FROM HR
WHERE age >= 18 AND termdate = "0000-00-00"
GROUP BY location_state
ORDER BY count DESC;

# How has the employee count changed over time based on hiredate and termdate?
SELECT
	year,
    hires,
    terminations,
    hires-terminations AS net_change,
    round((hires-terminations)/hires*100, 2) AS net_change_percentage
FROM (
	SELECT 
		YEAR (hire_date) AS year, 
        count(*) AS hires,
        SUM(CASE WHEN termdate <>"0000-00-00" AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
        FROM HR
        WHERE age >=18
        GROUP BY YEAR (hire_date)
        ) AS subquery
        ORDER BY year ASC;
        
# What is the tenure distribution in each department?

SELECT department, round(avg(datediff(termdate, hire_date)/365),0) AS avg_tenure
FROM HR
WHERE termdate <= curdate() AND termdate <> "0000-00-00" AND age >= 18
GROUP BY Department;













