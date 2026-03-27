USE CableTV;

SELECT Category, AVG(Price) AS AvgPrice
FROM (
    SELECT Category, Price
    FROM Movies
    WHERE ReleaseDate > '2025-01-01'
) AS RecentMovies
GROUP BY Category;