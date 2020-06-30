CREATE VIEW revenue AS
(
	SELECT COUNT(*) AS total_purchases, AVG(linedollars) AS avg_purchase_price, 
	COUNT(DISTINCT(cust_id)) AS total_customers, DATE_PART('year', orderdate) AS years
	FROM dmefextractlinesv01
	GROUP BY years
	ORDER BY years
)

CREATE VIEW lines_per_year AS
(
	SELECT "Cust_ID", "RetF07Lines"+"RetS07Lines"+"IntF07Lines"+"IntS07Lines"+"CatF07Lines"+"CatS07Lines" AS lines07,
	"RetF06Lines"+"RetS06Lines"+"IntF06Lines"+"IntS06Lines"+"CatF06Lines"+"CatS06Lines" AS lines06,
	"RetF05Lines"+"RetS05Lines"+"IntF05Lines"+"IntS05Lines"+"CatF05Lines"+"CatS05Lines" AS lines05,
	"RetF04Lines"+"RetS04Lines"+"IntF04Lines"+"IntS04Lines"+"CatF04Lines"+"CatS04Lines" AS lines04
	FROM dmefextractsummaryv01
)

SELECT COUNT(*) AS new_customers_05 
FROM lines_per_year
WHERE lines05 != 0 AND lines04 = 0

CREATE TABLE retention_rates
( 	
	retention_rate real,
	years int
)

INSERT INTO retention_rates (retention_rate, years)
VALUES (0.394, 2005), (0.373, 2006), (0.327, 2007)

SELECT * FROM retention_rates

CREATE VIEW ac AS (
	SELECT AVG(total_customers_contacted) AS acquisition_cost, years FROM
	(
		SELECT COUNT(cust_id) AS total_customers_contacted, DATE_PART('year', contactdate) AS years 
		FROM dmefextractcontactsv01
		WHERE contacttype = 'C'
		GROUP BY years, cust_id
	) AS average_mailing_cost
	GROUP BY years
	ORDER BY years
)

CREATE TABLE discount_rates
( 	
	discount_rate real,
	years int
)

INSERT INTO discount_rates (discount_rate, years)
VALUES (1.1, 2005), (1.21, 2006), (1.331, 2007)

SELECT * FROM discount_rates

SELECT SUM(((retention_rate*0.4*total_purchases*avg_purchase_price/total_customers)/discount_rate)-acquisition_cost) AS CLV
FROM revenue
INNER JOIN retention_rates
ON revenue.years = retention_rates.years
INNER JOIN ac
ON retention_rates.years = ac.years
INNER JOIN discount_rates
ON ac.years = discount_rates.years