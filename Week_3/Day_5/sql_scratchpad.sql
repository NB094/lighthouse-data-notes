/* -- SQLite

"""
 - Connect to the hr.db (stored in supporting-files directory) with sqlite3 
 - Write a query to find the names (first_name, last_name) of the employees who have a 
 manager who works for a department based in the United States. 
 

Expected columns:
    - first_name	
    - last_name	
    - manager_od

Notes:
    - Use tables employees, departments and locations
    - You shouldn’t use JOINs here. 
    - You can connect to DB from Jupyter Lab/Notebook, explore the table and try different queries
    - In the variable 'SQL' store only the final query ready for validation 
""" */


SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM countries;

SELECT DISTINCT employees.first_name, employees.last_name, employees.manager_id FROM employees
  WHERE employees.manager_id IN (SELECT employees.employee_id FROM employees
  WHERE employees.department_id IN (SELECT departments.department_id FROM departments
  WHERE (departments.location_id = 1400 OR departments.location_id = 1500 OR departments.location_id = 1700)));


/* """
 - Connect to the hr.db (stored in supporting-files directory) with sqlite3 
 - Write a query to get the difference (salary_span) between min and max salary for 
 each job ID excluding programmer (job_id = 9) and sort it, starting with the highest salary_span.



Expected columns:
    - job_id	
    - salary_span

Notes:
    - Use employees table
    - You can connect to DB from Jupyter Lab/Notebook, explore the table and try different queries
    - In the variable 'SQL' store only the final query ready for validation 
""" */


SELECT * FROM employees;

SELECT employees.job_id, (MAX(employees.salary) - MIN(employees.salary)) as salary_span FROM employees
    WHERE employees.job_id != 9
    GROUP BY employees.job_id
    ORDER BY salary_span DESC;