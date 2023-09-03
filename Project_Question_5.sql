-- Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

SELECT 
	a.`year`,
	a.`year` + 1,
	a.GDP_growth_percent,
	b.price_growth_percent,
	b.salary_growth_percent
FROM (
	SELECT 
		st1.`year`,
		st2.`year` + 1,
		st1.country,
		round ((st1.GDP - st2.GDP) / st2.GDP * 100, 2) AS GDP_growth_percent
	FROM t_sabina_sperlova_project_sql_secondary_final_ st1
	JOIN t_sabina_sperlova_project_sql_secondary_final_ st2
		ON st1.country = st2.country 
		AND st1.`year` = st2.`year` + 1
		AND st1.country = 'Czech Republic'
		AND round ((st1.GDP - st2.GDP) / st2.GDP * 100, 2) IS NOT NULL 
	ORDER BY st2.`year`) a
JOIN (
	SELECT 
		pt1.payroll_year,
		round (avg(pt1.price_value), 2) AS avg_price_value, 
		round (avg(pt1.salary), 2) AS avg_salary,
		round ((avg(pt1.price_value) - avg(pt2.price_value)) / avg(pt2.price_value) * 100, 2) AS price_growth_percent,
		round ((avg(pt1.salary) - avg(pt2.salary)) / avg(pt2.salary) * 100, 2) AS salary_growth_percent
	FROM t_sabina_sperlova_project_sql_primary_final_ pt1 
	JOIN t_sabina_sperlova_project_sql_primary_final_ pt2
		ON pt1.payroll_year  = pt2.payroll_year + 1
		AND pt1.payroll_year >= 2007
		AND pt1.payroll_year  <= 2018
	GROUP BY pt1.payroll_year ) b
	ON a.`year` = b.payroll_year
ORDER BY YEAR;
