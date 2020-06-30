CREATE VIEW Recency AS
(
	SELECT cust_id, MAX(orderdate) AS last_purchase
	FROM dmefextractlinesv01
	GROUP BY cust_id, orderdate
	ORDER BY last_purchase DESC
)

CREATE VIEW Frequency AS
(
	SELECT cust_id, COUNT(ordernum) AS total_purchases
	FROM dmefextractlinesv01
	GROUP BY cust_id
	ORDER BY total_purchases DESC
)

CREATE VIEW Monetary AS
(
SELECT cust_id, ROUND(AVG(linedollars)) AS avg_spend
FROM dmefextractlinesv01
GROUP BY cust_id
ORDER BY avg_spend DESC
)

SELECT Recency.cust_id, last_purchase, total_purchases, avg_spend,
NTILE(5) OVER (ORDER BY last_purchase) AS R,
NTILE(5) OVER (ORDER BY total_purchases) AS F,
NTILE(5) OVER (ORDER BY avg_spend) AS M
FROM Recency
INNER JOIN Frequency
ON Recency.cust_id = Frequency.cust_id
INNER JOIN Monetary
ON Frequency.cust_id = Monetary.cust_id
ORDER BY R DESC, F DESC, M DESC