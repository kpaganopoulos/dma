CREATE VIEW contacted_and_ordered AS
(
	SELECT contacttype, dmefextractordersv01.cust_id
	FROM dmefextractcontactsv01
	INNER JOIN dmefextractordersv01
	ON dmefextractcontactsv01.cust_id = dmefextractordersv01.cust_id
)

SELECT COUNT(contacted_and_ordered.cust_id) AS total_contacted_and_ordered_catalog
FROM contacted_and_ordered 
WHERE contacted_and_ordered.contacttype = 'C'
UNION
SELECT COUNT(dmefextractcontactsv01.cust_id) AS total_contacted
FROM dmefextractcontactsv01
WHERE dmefextractcontactsv01.contacttype = 'C'
UNION
SELECT COUNT(contacted_and_ordered.cust_id) AS total_contacted_and_ordered_email
FROM contacted_and_ordered 
WHERE contacted_and_ordered.contacttype = 'E'
UNION
SELECT COUNT(dmefextractcontactsv01.cust_id) AS total_contacted
FROM dmefextractcontactsv01
WHERE dmefextractcontactsv01.contacttype = 'E'