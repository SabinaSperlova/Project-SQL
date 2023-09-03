-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

SELECT 
	pt1.payroll_year,
	pt2.payroll_year + 1 AS prev_year,
	round ((avg(pt1.price_value) - avg(pt2.price_value)) / avg(pt2.price_value) * 100, 2) AS price_growth_percent,
	round ((avg(pt1.salary) - avg(pt2.salary)) / avg(pt2.salary) * 100, 2) AS salary_growth_percent,
	round ((avg(pt1.price_value) - avg(pt2.price_value)) / avg(pt2.price_value) * 100, 2) - round ((avg(pt1.salary) - avg(pt2.salary)) / avg(pt2.salary) * 100, 2) AS difference,
	CASE
		WHEN round ((avg(pt1.price_value) - avg(pt2.price_value)) / avg(pt2.price_value) * 100, 2) - round ((pt1.salary - pt2.salary) / pt2.salary * 100, 2) > 10 
		THEN 'is significantly bigger'
		ELSE 'is not significantly bigger'
	END AS comment_on_difference
FROM t_sabina_sperlova_project_sql_primary_final_ pt1
JOIN t_sabina_sperlova_project_sql_primary_final_ pt2
	ON pt1.payroll_year = pt2.payroll_year + 1
	AND pt1.payroll_year >= 2007
	AND pt1.payroll_year <= 2018
GROUP BY pt1.payroll_year;