USE CableTV;

UPDATE Subscribers
SET Subscribers.Debt = Subscribers.Debt + Tariffs.MonthlyFee
FROM Subscribers
JOIN Orders ON Subscribers.SubscriberID = Orders.SubscriberID
JOIN Tariffs ON Orders.ServiceID = Tariffs.ServiceID;

SELECT * FROM Subscribers;