-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

SELECT 
	pt1.payroll_year,
	pt2.payroll_year + 1 AS prev_year,
	pt1.industry_field,
	round ((pt1.salary - pt2.salary)/ pt2.salary * 100, 2) AS salary_growth
FROM t_sabina_sperlova_project_sql_primary_final_ pt1
JOIN t_sabina_sperlova_project_sql_primary_final_ pt2 
	ON pt1.industry_field = pt2.industry_field 
	AND pt1.payroll_year = pt2.payroll_year + 1
GROUP BY pt1.industry_field, pt1.payroll_year 
ORDER BY salary_growth;
	
