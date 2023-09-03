CREATE TABLE IF NOT EXISTS t_sabina_sperlova_project_SQL_primary_final_
	SELECT *
	FROM (
		SELECT
			cpa.payroll_year,
			avg (cpa.value) AS salary,
			cpib.name AS industry_field
		FROM czechia_payroll cpa
		JOIN czechia_payroll_industry_branch cpib 
			ON cpa.industry_branch_code = cpib.code 
		WHERE cpa.value_type_code = 5958
		GROUP BY 
			cpa.payroll_year,
			industry_field
		ORDER BY 
			cpa.payroll_year,
			cpa.industry_branch_code
	) a
	LEFT JOIN (	
		SELECT 
			YEAR (cpr.date_from) AS price_year,
			cpr.category_code,
			cpc.name,
			avg (cpr.value) AS price_value
		FROM czechia_price cpr
		JOIN czechia_price_category cpc 
			ON cpr.category_code = cpc.code 
		GROUP BY 
			category_code,
			YEAR (cpr.date_from)
	) b
		ON a.payroll_year = b.price_year;
		