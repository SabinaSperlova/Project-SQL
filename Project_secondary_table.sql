CREATE TABLE t_sabina_sperlova_project_sql_secondary_final_ AS
SELECT 
	c.*,
	e.`year`,
	e.GDP,
	e.population AS population_in_region,
	e.gini,
	e.taxes,
	e.fertility,
	e.mortaliy_under5 
FROM countries c 
JOIN economies e 
	ON c.country = e.country;

	
