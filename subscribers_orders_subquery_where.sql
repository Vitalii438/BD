USE CableTV;
--
SELECT Subscribers.FullName, Movies.Title, Movies.Price
FROM Subscribers
JOIN Orders ON Subscribers.SubscriberID = Orders.SubscriberID
JOIN Movies ON Orders.ServiceID = Movies.ServiceID
WHERE Movies.Price > (
    SELECT AVG(Price) 
    FROM Movies
);