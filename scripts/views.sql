CREATE VIEW booking.ProtectedUserInfo AS
SELECT md5(phone),
       'xxx' || RIGHT(email, LENGTH(email) - POSITION('@' IN email) + 1) AS email,
       registration_date,
       deregistration_date
FROM booking.User;


CREATE VIEW booking.ProtectedOwnerInfo AS
SELECT md5(phone),
       'xxx' || RIGHT(email, LENGTH(email) - POSITION('@' IN email) + 1) AS email,
       registration_date,
       deregistration_date
FROM booking.Owner;

CREATE VIEW booking.OwnerStat AS
SELECT md5(phone),
       AVG(r.rating),
       COUNT(v.venue_id)
FROM booking.Owner o
JOIN booking.Venue v on o.owner_id = v.owner_id
JOIN booking.VenueReview r on v.venue_id = r.venue_id
GROUP BY o.owner_id;

CREATE VIEW booking.UserStat AS
SELECT md5(phone),
       AVG(r.rating) as rating,
       COUNT(b.booking_id),
       AVG(o.price::numeric) as spent
FROM booking.User u
JOIN booking.Booking b on u.user_id = b.user_id
JOIN booking.UserReview r on u.user_id = r.user_id
JOIN booking.Offer o on o.offer_id = b.offer_id
GROUP BY u.user_id;

CREATE VIEW booking.AmenityStat AS
SELECT a.name,
       AVG(vr.rating) as rating,
       COUNT(b.booking_id),
       AVG(o.price::numeric) as price
FROM booking.Amenity a
JOIN booking.Venue_x_Amenity va on va.amenity_id = a.amenity_id
JOIN booking.Venue v on v.venue_id = va.venue_id
JOIN booking.Offer o on o.venue_id = v.venue_id
JOIN booking.Booking b on b.offer_id = o.offer_id
JOIN booking.VenueReview vr on vr.venue_id = v.venue_id
GROUP BY a.amenity_id;

CREATE VIEW booking.RateStat AS
SELECT r.name,
       COUNT(b.booking_id),
       AVG(o.price::numeric) as price
FROM booking.Rate r
JOIN booking.Offer o on o.rate_id = r.rate_id
JOIN booking.Booking b on b.offer_id = o.offer_id
GROUP BY r.rate_id;

