SELECT a.name, COUNT(*) 
FROM booking.Amenity a 
JOIN booking.Venue_x_Amenity va ON a.amenity_id = va.amenity_id 
GROUP BY a.name;

SELECT o.email, COUNT(*) as num_venues
FROM booking.Venue v
JOIN booking.Owner o on v.owner_id = o.owner_id 
GROUP BY o.owner_id
HAVING COUNT(*) >= 2;

SELECT v.name, AVG(vr.rating) as avg_rating
FROM booking.Venue v
LEFT JOIN booking.VenueReview vr ON v.venue_id = vr.venue_id
GROUP BY v.venue_id
ORDER BY avg_rating DESC;

SELECT v.name, r.name, price::numeric, AVG(price::numeric) OVER (PARTITION BY o.rate_id),
RANK() OVER (ORDER BY price::numeric)
FROM booking.Venue v
JOIN booking.Offer o on v.venue_id = o.venue_id
JOIN booking.Rate r on o.rate_id = r.rate_id;

SELECT price, LAG(price::numeric, 1, 0) OVER (PARTITION BY offer_id ORDER BY valid_to)
FROM (select * from booking.OfferHistory
UNION ALL (SELECT offer_id, NOW(), price as valid_to from booking.Offer)) as tmp;

SELECT v.name, a.name, ROW_NUMBER() OVER (PARTITION BY v.venue_id) as amenity_num
FROM booking.Venue v
JOIN booking.Venue_x_Amenity va on v.venue_id = va.venue_id
JOIN booking.Amenity a on va.amenity_id = a.amenity_id
ORDER BY amenity_num;

SELECT v.name, a.name, vr.rating, COUNT(vr.rating) OVER (PARTITION BY a.amenity_id), AVG(vr.rating) OVER (PARTITION BY a.amenity_id)
FROM booking.Venue v
JOIN booking.Venue_x_Amenity va on v.venue_id = va.venue_id
JOIN booking.Amenity a on va.amenity_id = a.amenity_id
JOIN booking.VenueReview vr on v.venue_id = vr.venue_id;
