IF OBJECT_ID('Subscribers', 'U') IS NULL
CREATE TABLE Subscribers (
    SubscriberID INT PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(200), 
    Phone NVARCHAR(20),
    Debt DECIMAL(10,2) DEFAULT 0
); 

IF OBJECT_ID('Orders', 'U') IS NULL
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    SubscriberID INT,
    ServiceType NVARCHAR(50),
    ServiceID INT,
    OrderDate DATE,
    FOREIGN KEY (SubscriberID) REFERENCES Subscribers(SubscriberID)
);

IF OBJECT_ID('Movies', 'U') IS NULL
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    ServiceID INT,
    Title NVARCHAR(200) NOT NULL,
    Category NVARCHAR(50),
    ReleaseDate DATE,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ServiceID) REFERENCES Orders(OrderID)
);

IF OBJECT_ID('Tariffs', 'U') IS NULL
CREATE TABLE Tariffs (
    TariffID INT PRIMARY KEY,
    ServiceID INT,
    TariffName NVARCHAR(100) NOT NULL,
    MonthlyFee DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ServiceID) REFERENCES Orders(OrderID)
);

IF OBJECT_ID('Channels', 'U') IS NULL
CREATE TABLE Channels (
    ChannelID INT PRIMARY KEY,
    ChannelName NVARCHAR(100) NOT NULL,
    TariffID INT,
    FOREIGN KEY (TariffID) REFERENCES Tariffs(TariffID)
);

IF OBJECT_ID('Payments', 'U') IS NULL
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    SubscriberID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    FOREIGN KEY (SubscriberID) REFERENCES Subscribers(SubscriberID)
);

IF NOT EXISTS (SELECT 1 FROM Subscribers WHERE SubscriberID = 1)
    INSERT INTO Subscribers VALUES (1, 'Іван Петренко', 'Львів, вул. Шевченка 10', '380971234567', 100000);

IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = 1)
    INSERT INTO Orders VALUES (1, 1, 'Movie', 1, GETDATE());
IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = 2)
    INSERT INTO Orders VALUES (2, 1, 'Tariff', 1, GETDATE());

IF NOT EXISTS (SELECT 1 FROM Movies WHERE MovieID = 1)
    INSERT INTO Movies VALUES (1, 1, 'Avatar 3', 'Фантастика', '2026-02-10', 50);

IF NOT EXISTS (SELECT 1 FROM Tariffs WHERE TariffID = 1)
    INSERT INTO Tariffs VALUES (1, 1, 'Базовий пакет', 200);

IF NOT EXISTS (SELECT 1 FROM Channels WHERE ChannelID = 1)
    INSERT INTO Channels VALUES (1, 'Discovery', 1);

SELECT Movies.Title, Movies.Category, COUNT(Orders.OrderID) AS OrdersCount, SUM(Movies.Price) AS TotalRevenue
FROM Movies
JOIN Orders ON Movies.MovieID = Orders.ServiceID AND Orders.ServiceType = 'Movie'
GROUP BY Movies.Title, Movies.Category;

SELECT Subscribers.FullName, Subscribers.Phone, Subscribers.Debt
FROM Subscribers
WHERE Subscribers.Debt > 0;

--SELECT * FROM Subscribers;
--SELECT * FROM Payments;
--SELECT * FROM Orders;
--SELECT * FROM Tariffs;
--SELECT * FROM Movies;
--SELECT * FROM Channels;

--DROP TABLE Payments, Orders,Tariffs, Channels, Movies, Subscribers ;
--TRUNCATE TABLE Payments;
--TRUNCATE TABLE Channels;
--TRUNCATE TABLE Tariffs;
--TRUNCATE TABLE Movies;
--TRUNCATE TABLE Orders;
--TRUNCATE TABLE Subscribers;

--SELECT * FROM Subscribers;
--SELECT * FROM Orders;

--IF NOT EXISTS (SELECT 1 FROM Payments WHERE PaymentID = 1)
--    INSERT INTO Payments VALUES (1, 1, 250, GETDATE());
