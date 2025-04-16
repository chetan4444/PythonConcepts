-- List last 5 employees alphabetically in data .
SELECT DISTINCT
	 #emp_no,
     concat(first_name, " ", last_name) as name,
     salary
FROM
	employees.employees,
    employees.salaries
WHERE
	employees.employees.emp_no = employees.salaries.emp_no
ORDER BY
	name DESC
LIMIT
	5;

-- List last 5 employees in data using JOIN.
SELECT DISTINCT
	e.emp_no,
	concat(first_name, " ", last_name) as Name,
    MAX(salary) as Max_Salary
FROM
	employees.employees e
JOIN
	employees.salaries s
    ON e.emp_no = s.emp_no
GROUP BY
	e.emp_no
ORDER BY
	Name DESC
LIMIT
	5;

SELECT
	e.emp_no,
    concat(e.first_name, " ", e.last_name) as Name,
    MAX(e.birth_date) as Birth_Date,
    MAX(e.gender) as Gender,
    MAX(e.hire_date) as Hire_Date,
    MAX(s.salary) as Max_Salary,
    MAX(t.title) as Current_Title,
    MAX(d.dept_name) as Department_Name 
FROM
	employees.employees e
JOIN
	employees.salaries s 
    ON e.emp_no = s.emp_no
JOIN
	employees.titles t 
    ON e.emp_no = t.emp_no
JOIN
	employees.dept_emp de 
    ON e.emp_no = de.emp_no
JOIN
	employees.departments d
    ON de.dept_no = d.dept_no
GROUP BY
	e.emp_no
-- ORDER BY
-- 	Name Asc
LIMIT 5;


-- List top 5 highest paid employees.
SELECT DISTINCT
	 e.emp_no,
     concat(e.first_name, " ", e.last_name) as Name,
     MAX(s.salary) as Salary
FROM
	employees.employees e
JOIN
	employees.salaries s
    ON e.emp_no = s.emp_no AND s.to_date = "9999-01-01"
GROUP BY
	e.emp_no
ORDER BY
	Salary DESC
LIMIT
	5;
    
    
-- Find the average salary by department.
SELECT
	 d.dept_name,
     AVG(s.salary) as Avg_Salary
FROM
	employees.departments d
JOIN
	employees.dept_emp d_e
    ON d.dept_no = d_e.dept_no
JOIN
	employees.salaries s
    ON d_e.emp_no = s.emp_no AND s.to_date = "9999-01-01"
GROUP BY
	d.dept_name
ORDER BY
	Avg_Salary DESC;
-- LIMIT
-- 	5;

-- Show all employees who have worked as 'Manager'.
SELECT
	e.emp_no as Emp_Id,
	concat(first_name, " ", last_name) as Name,
    t.title as Title
FROM
	employees.employees e
JOIN
	employees.titles t
    ON e.emp_no = t.emp_no 
    WHERE t.title = "Manager"
GROUP BY
	e.emp_no
ORDER BY
	Name;
    
-- Find employees who have changed their title at least once.
SELECT
	e.emp_no as Emp_Id,
	concat(first_name, " ", last_name) as Name,
    count(DISTINCT t.title) as Distinct_Title_count
FROM
	employees.employees e
JOIN
	employees.titles t
    ON e.emp_no = t.emp_no
GROUP BY
	Emp_Id
HAVING
	Distinct_Title_count > 1
ORDER BY
	Name ASC
LIMIT
	50;
    
-- Show the employee(s) with the longest tenure (earliest hire_date).
SELECT 
	concat(first_name, " ", last_name) as Name,
    hire_date
FROM employees.employees
ORDER BY
	hire_date ASC
LIMIT 1;

-- For each department, find the latest hired employee
WITH ranked_employees AS
	(
		SELECT
			d.dept_name as Dept_Name,
			concat(e.first_name, " ", e.last_name) as Name,
			e.hire_date as Hire_Date,
            ROW_NUMBER() OVER (PARTITION BY d.dept_name ORDER BY e.hire_date DESC) AS row_num
		FROM
			employees.employees e
		JOIN
			employees.dept_emp d_e
			ON e.emp_no = d_e.emp_no
		JOIN
			employees.departments d
			ON d.dept_no = d_e.dept_no
	)
SELECT
	row_num,
	Dept_Name,
    Name,
    Hire_Date
FROM
	ranked_employees
WHERE
	row_num = 1
ORDER BY
	Dept_Name, row_num, Name, Hire_Date DESC;
    

-- Total per department
SELECT
    d.dept_name as Dept_Name,
	count(DISTINCT d_e.emp_no) as Total_employees
FROM
	employees.departments d
JOIN
    employees.dept_emp d_e ON d.dept_no = d_e.dept_no
GROUP BY
	Dept_Name
ORDER BY
	Total_employees DESC;
    
-- 7 - List employees whose salary increased over time.
SELECT
	 e.emp_no as Emp_Id,
     concat(e.first_name, " ", e.last_name) as Name,
     Max(s.salary) - Min(s.salary) as Salary_Change
FROM
	employees.employees e
JOIN
    employees.salaries s
    ON e.emp_no = s.emp_no
GROUP BY
	Emp_Id, Name
HAVING
	Salary_Change > 0
ORDER BY
	name DESC
LIMIT
	5;

-- 8 - List top 5 employees with highest salary increase percentage.
SELECT
	 e.emp_no as Emp_Id,
     concat(e.first_name, " ", e.last_name) as Name,
     Max(s.salary) as Max_Salary,
     Min(s.salary) as Min_Salary,
     (((Max(s.salary) - Min(s.salary))/Min(s.salary)) * 100) as Percentage_Salary_Change
FROM
	employees.employees e
JOIN
    employees.salaries s
    ON e.emp_no = s.emp_no
GROUP BY
	Emp_Id, Name
-- HAVING
-- 	Percentage_Salary_Change > 0
ORDER BY
	Percentage_Salary_Change DESC
LIMIT
	5;

-- 8. Find the total number of male and female employees.
SELECT
	gender,
	COUNT(emp_no)
FROM
	employees.employees
GROUP BY
	gender;

-- 9. Get average salary per title
SELECT
	t.title as Title,
    ROUND(AVG(s.salary),2) as Avg_Salary
FROM employees.titles t
	JOIN employees.salaries s
    ON t.emp_no = s.emp_no
WHERE
	t.to_date = "9999-01-01"
    AND s.to_date = "9999-01-01"
GROUP BY
	Title
ORDER BY
	Avg_Salary DESC;
    
-- Find employees who never changed department
SELECT 
	e.emp_no as Emp_Id,
    concat(e.first_name, " ", e.last_name) as Name,
    MIN(d.dept_name) as Department,
    COUNT(DISTINCT d_e.dept_no) as no_of_dept
FROM
	employees.employees e
JOIN
    employees.dept_emp d_e ON e.emp_no = d_e.emp_no
JOIN
	employees.departments d ON d_e.dept_no = d.dept_no
GROUP BY
	Emp_Id, Name
HAVING
	no_of_dept = 1;