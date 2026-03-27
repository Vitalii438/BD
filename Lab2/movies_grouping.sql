USE CableTV;

SELECT Category, COUNT(*) AS MovieCount, SUM(Price) AS TotalRevenue
FROM Movies
GROUP BY Category
ORDER BY TotalRevenue DESC;