select * from Album;

select * from Employee;

#find person having highest position
SELECT DISTINCT title FROM Employee;
SELECT FirstName, LastName from Employee
WHERE title = "General Manager";

#country with most invoices
SELECT * from Invoice;

SELECT count(*) as total,
billingcountry from Invoice
GROUP BY billingcountry
ORDER BY total DESC;

#top3 value of Invoice
SELECT total FROM Invoice
ORDER BY total DESC
LIMIT 3;

SELECT SUM(total) as Invoice_total, billingcity
FROM Invoice 
group BY billingcity
ORDER BY Invoice_total DESC;

select * FROM Customer;

SELECT Customer.customerid, Customer.FirstName, Customer.LastName, SUM(Invoice.total) as total
from Customer
join Invoice ON Customer.customerid = Invoice.customerid
GROUP BY Customer.customerid
ORDER BY total DESC
LIMIT 1;


--MODERATE

SELECT DISTINCT email, firstname, lastname FROM Customer
JOIN Invoice ON Customer.customerid = Invoice.customerid
JOIN InvoiceLine on Invoice.invoiceid = InvoiceLine.invoiceid
WHERE trackid IN(
	SELECT trackid FROM Track
	join Genre on Track.genreid = Genre.genreid
	WHERE Genre.Name LIKE 'Rock'
)
ORDER BY email;

SELECT Artist.artistid, Artist.name, COUNT(Artist.artistid) AS total_songs
FROM Track
JOIN Album on Album.albumid = Track.albumid
JOIN Artist on Artist.artistid = Album.albumid
JOIN Genre on Genre.genreid = Track.genreid
WHERE Genre.name LIKE 'Rock'
GROUP BY Artist.artistid
ORDER BY total_songs DESC
LIMIT 10;

SELECT name, milliseconds
FROM Track
WHERE milliseconds > (
  	SELECT AVG(milliseconds) AS avg_track_len
    FROM Track)
ORDER by milliseconds DESC;


WITH best_selling_artist AS( 
    SELECT Artist.artistid As artist_id, Artist.name AS artist_name, SUM( InvoiceLine.unitprice*InvoiceLine.Quantity ) AS total_cost
	from InvoiceLine
	JOIN Track on Track.trackid =InvoiceLine.trackid
	JOIN Album on Album.albumid = Track.albumid
	JOIN Artist on Artist.artistid = Album.artistid
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1
)
SELECT c.customerid, c.firstname, c.lastname, bsa.artist_name
SUM (il.unitprice*il.quantity) AS amount_spent
FROM Invoice i
JOIN Customer c on c.CustomerId = i.customerid
JOIN InvoiceLine il on il.InvoiceId = i.InvoiceId
JOIN Track t on t.trackid = il.TrackId
JOIN Album alb on alb.AlbumId = t.AlbumId
JOIN best_selling_artist bsa ON bsa.artistid = alb.ArtistId
GROUP BY 1,2,3,4
ORDER by 5 DESC;

