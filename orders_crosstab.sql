USE CableTV;

SELECT Category,
       SUM(CASE WHEN MONTH(OrderDate)=1 THEN 1 ELSE 0 END) AS JanOrders,
       SUM(CASE WHEN MONTH(OrderDate)=2 THEN 1 ELSE 0 END) AS FebOrders,
       SUM(CASE WHEN MONTH(OrderDate)=3 THEN 1 ELSE 0 END) AS MarOrders
FROM Orders
JOIN Movies ON Orders.ServiceID = Movies.ServiceID AND Orders.ServiceType = 'Movie'
GROUP BY Category;