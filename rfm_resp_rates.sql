CREATE VIEW contacted_and_ordered AS
(
	SELECT contacttype, dmefextractordersv01.cust_id
	FROM dmefextractcontactsv01
	INNER JOIN dmefextractordersv01
	ON dmefextractcontactsv01.cust_id = dmefextractordersv01.cust_id
)

SELECT COUNT(contacted_and_ordered.cust_id) AS total_contacted_and_ordered
FROM contacted_and_ordered 
INNER JOIN RFM
ON RFM.cust_id = contacted_and_ordered.cust_id
WHERE R = 5 AND F = 5 AND M = 5
UNION
SELECT COUNT(dmefextractcontactsv01.cust_id) AS total_contacted
FROM dmefextractcontactsv01
INNER JOIN RFM
ON RFM.cust_id = dmefextractcontactsv01.cust_id
WHERE R = 5 AND F = 5 AND M = 5