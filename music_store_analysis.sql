/*Q1 - Who is the senior most employee in the music store based on the job title? */

SELECT * FROM employee
ORDER BY levels desc
limit 1

/*Q2 - Which countries have the most invoices? */

SELECT * FROM invoice
SELECT COUNT (*) as c, billing_country
FROM invoice
group by billing_country
order by c desc

/*Q3 - Who is the best customer? Declare a person who has spent much money as the best customer. */
	/*According to the schema table we have to link the customer with the invoice table. */

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) as total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total desc
LIMIT 3


/* Q4: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

	/* From the schema table to obtain the rock genre we have to go to genre table. And to get the list of customers we have to refer the customer table. 
		Now we have to link customer table with the genre table. To do this we link Customer_id from customer table to customer_id from the invoice table. 
		Then we link invoice_id from invoice table with invoice_id from invoice_line table.
		Now we link Track_id from Invoice_line table to track and finally genre_id from track to genre. */


SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

/* Q5: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

/* Q6: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track)
ORDER BY milliseconds DESC;







