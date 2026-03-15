USE CableTV;

INSERT INTO Orders (OrderID, SubscriberID, ServiceType, ServiceID, OrderDate)
SELECT (SELECT ISNULL(MAX(OrderID),0) FROM Orders) + ROW_NUMBER() OVER (ORDER BY Subscribers.SubscriberID) AS OrderID,
       Subscribers.SubscriberID, 'Movie', Movies.MovieID, GETDATE()
FROM Subscribers
CROSS JOIN Movies
WHERE Subscribers.Status = 'Active';

SELECT * FROM Orders;
