USE CableTV;

SELECT Subscribers.FullName, Orders.ServiceType, Tariffs.TariffName
FROM Subscribers
JOIN Orders ON Subscribers.SubscriberID = Orders.SubscriberID
JOIN Tariffs ON Orders.ServiceID = Tariffs.ServiceID
WHERE Tariffs.MonthlyFee > 200 AND Orders.ServiceType = 'Extended';