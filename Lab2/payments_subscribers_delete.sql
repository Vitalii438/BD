USE CableTV;

DELETE FROM Payments; 

DELETE FROM Subscribers
WHERE Debt > 1000;

SELECT * FROM Subscribers;