USE CableTV;

SELECT Title, Category, ReleaseDate
FROM Movies
WHERE Category IN ('Drama')
  AND ReleaseDate BETWEEN '2025-01-09' AND '2026-12-31'
  AND EXISTS (SELECT 1 FROM Orders WHERE Orders.ServiceID = Movies.ServiceID);