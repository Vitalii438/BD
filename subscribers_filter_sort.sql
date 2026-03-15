USE CableTV;

SELECT SubscriberID, FullName, Debt
FROM Subscribers
WHERE Debt > 1000 OR FullName LIKE '%_3'
ORDER BY Debt DESC;