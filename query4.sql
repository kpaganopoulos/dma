SELECT ordermethod, COUNT(*) AS total_payments_per_channel FROM
(
	SELECT ordermethod, paymenttype
	FROM dmefextractordersv01 
	WHERE paymenttype = 'BC' OR paymenttype = 'CA' OR paymenttype = 'CK'
) AS orders_payments
WHERE ordermethod != 'ST'
GROUP BY ordermethod