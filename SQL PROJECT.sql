use moviebooking_project;
SHOW TABLES;

/* SELECT & DISTINCT */

-- Select all columns from Movies table
SELECT * FROM Movies;

-- Select only Title and Genre
SELECT Title, Genre FROM Movies;

-- Select unique Genres
SELECT DISTINCT Genre FROM Movies;

/* WHERE & Operators */

-- Customers from Chennai
SELECT * FROM Customers
WHERE City = 'Chennai';

-- Bookings where seats > 3
SELECT * FROM Bookings
WHERE SeatsBooked > 3;

-- Payments where status is Pending
SELECT * FROM Payments
WHERE Status = 'Pending';

-- Movies released between two dates
SELECT * FROM Movies
WHERE ReleaseDate BETWEEN '2023-01-01' AND '2024-01-01';

-- Shows with TicketPrice between 200 and 400
SELECT * FROM Shows
WHERE TicketPrice BETWEEN 200 AND 400;

-- Customers whose name starts with C
SELECT * FROM Customers
WHERE Name LIKE 'C%';

/* ORDER BY */

-- Movies ordered by ReleaseDate ascending
SELECT * FROM Movies
ORDER BY ReleaseDate ASC;

-- Bookings ordered by BookingDate descending
SELECT * FROM Bookings
ORDER BY BookingDate DESC;

/* GROUP BY & Aggregates */

-- Total seats booked per customer
SELECT CustomerID, SUM(SeatsBooked) AS TotalSeats
FROM Bookings
GROUP BY CustomerID;

-- Total amount paid per customer
SELECT BookingID, SUM(Amount) AS TotalAmount
FROM Payments
GROUP BY BookingID;

-- Number of bookings per show
SELECT ShowID, COUNT(*) AS TotalBookings
FROM Bookings
GROUP BY ShowID;

/* HAVING */

-- Customers who booked more than 2 shows
SELECT CustomerID, COUNT(*) AS TotalShows
FROM Bookings
GROUP BY CustomerID
HAVING COUNT(*) > 2;

-- Shows where total seats booked > 10
SELECT ShowID, SUM(SeatsBooked) AS TotalSeats
FROM Bookings
GROUP BY ShowID
HAVING SUM(SeatsBooked) > 10;

/* DELETE */

-- Delete booking with ID = 5
DELETE FROM bookings
WHERE BookingID = 5;

-- Delete pending payments older than 2024-01-01
DELETE FROM Payments
WHERE Status = 'Pending'
  AND PaymentDate < '2024-01-01';

SET SQL_SAFE_UPDATES = 0;

/* LIMIT / OFFSET */

-- First 5 customers
SELECT * FROM Customers
LIMIT 5;

-- Skip first 5 customers
SELECT * FROM Customers
LIMIT 5 OFFSET 5;

/* Subqueries */

-- Customers who booked shows with TicketPrice > 400
SELECT * FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Bookings
    WHERE ShowID IN (
        SELECT ShowID FROM Shows WHERE TicketPrice > 400
    )
);

-- Movies where total bookings > 10
SELECT * FROM Movies
WHERE MovieID IN (
    SELECT MovieID
    FROM Shows
    WHERE ShowID IN (
        SELECT ShowID FROM Bookings
        GROUP BY ShowID
        HAVING COUNT(*) > 10
    )
);

/* Advanced Queries */

-- Total revenue per theater
SELECT t.Name AS TheaterName, SUM(p.Amount) AS TotalRevenue
FROM Payments p
INNER JOIN Bookings b ON p.BookingID = b.BookingID
INNER JOIN Shows s ON b.ShowID = s.ShowID
INNER JOIN theaters t ON s.TheatreID = t.TheatreID
GROUP BY t.Name;



SELECT CustomerID, BookingDate, COUNT(*) AS TotalBookings
FROM Bookings
GROUP BY CustomerID, BookingDate
HAVING COUNT(*) > 1;







  





