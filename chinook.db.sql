WITH best_selling_artist AS ( 
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