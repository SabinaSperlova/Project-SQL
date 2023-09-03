-- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

SELECT 
	pt.price_year,
	pt.name,
	round(avg(pt.price_value), 2) AS avg_price_value,
	round (avg(pt.salary), 2) AS avg_salary,
	round (avg(pt.salary) / avg(pt.price_value), 2) AS quantity_of_goods
FROM t_sabina_sperlova_project_sql_primary_final_ pt
WHERE pt.category_code IN ('111301', '114201') AND pt.price_year IN ('2006', '2018')
GROUP BY 
	pt.name,
	pt.price_year
ORDER BY pt.price_year;
