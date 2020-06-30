SELECT "SCF_Code" AS zip_code, ROUND(AVG(total_spend)) AS average_spend FROM 
(	
	SELECT "SCF_Code", dmefextractsummaryv01."Cust_ID", SUM(linedollars) AS total_spend
	FROM dmefextractlinesv01
	INNER JOIN dmefextractsummaryv01
	ON dmefextractlinesv01.cust_id = dmefextractsummaryv01."Cust_ID"
	GROUP BY  "SCF_Code", dmefextractsummaryv01."Cust_ID"
	ORDER BY total_spend DESC 
) AS total_spend_per_customer
GROUP BY "SCF_Code" 
ORDER BY average_spend DESC 
LIMIT 5
