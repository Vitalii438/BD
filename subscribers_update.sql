USE CableTV;

UPDATE Subscribers
SET Status = 'Blocked'
WHERE Debt > 3 * (SELECT AVG(MonthlyFee) FROM Tariffs);

SELECT * FROM Subscribers;