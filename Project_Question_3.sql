-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

SELECT 
	a.name,
	a.price_value_2006,
	b.price_value_2018,
	round ((b.price_value_2018 - a.price_value_2006) / a.price_value_2006 * 100, 2) AS price_growth
FROM (
	SELECT 
		pt1.name, 
		round (pt1.price_value,2) AS price_value_2006
	FROM t_sabina_sperlova_project_sql_primary_final_ pt1
	WHERE pt1.price_year = '2006'
	) a JOIN (
	SELECT 
		pt1.name,
		round (pt1.price_value, 2) AS price_value_2018
	FROM t_sabina_sperlova_project_sql_primary_final_ pt1
	WHERE pt1.price_year = '2018'
	) b
	ON a.name = b.name
GROUP BY a.name
ORDER BY price_growth;