INSERT INTO booking.Owner (email, phone, registration_date)
VALUES
  ('johndoe@example.com', '555-1234', '2022-01-01'),
  ('janedoe@example.com', '555-5678', '2022-01-02'),
  ('davidsmith@example.com', '555-9012', '2022-01-03'),
  ('laurajones@example.com', '555-3456', '2022-01-04'),
  ('samgreen@example.com', '555-7890', '2022-01-05'),
  ('marybrown@example.com', '555-2345', '2022-01-06'),
  ('jimwilson@example.com', '555-6789', '2022-01-07'),
  ('sarahparker@example.com', '555-0123', '2022-01-08'),
  ('chrislee@example.com', '555-4567', '2022-01-09'),
  ('kimnguyen@example.com', '555-8901', '2022-01-10');
  
INSERT INTO booking.Venue (name, location, description, owner_id)
VALUES
    ('Rustic Barn', POINT(42.3229, -71.2267), 'A charming barn venue for weddings and events', 1),
    ('Sky High Lounge', POINT(34.0522, -118.2437), 'A rooftop bar with stunning views of the city', 2),
    ('Beach House', POINT(33.9951, -118.4665), 'A beachfront vacation rental with ocean views', 3),
    ('Secret Garden', POINT(37.7749, -122.4194), 'A lush garden oasis in the heart of the city', 1),
    ('Urban Loft', POINT(40.7128, -74.0060), 'A modern and stylish loft venue in downtown', 4),
    ('Mountain Chalet', POINT(39.5501, -105.7821), 'A cozy chalet in the mountains for a ski trip', 5),
    ('Seaside Cottage', POINT(37.8651, -122.5026), 'A charming cottage steps away from the beach', 3),
    ('Garden Terrace', POINT(38.9072, -77.0369), 'A rooftop terrace with a beautiful garden and city views', 6),
    ('Luxury Villa', POINT(41.9028, 12.4964), 'A stunning villa in the Italian countryside', 7),
    ('Industrial Warehouse', POINT(37.3382, -121.8863), 'A spacious and unique venue in an industrial setting', 8);
    
INSERT INTO booking.User (email, phone, registration_date)
VALUES 
    ('john@example.com', '555-1234', '2022-04-01'),
    ('jane@example.com', '555-5678', '2022-04-01'),
    ('alice@example.com', '555-4321', '2022-04-02'),
    ('bob@example.com', '555-8765', '2022-04-02'),
    ('mike@example.com', '555-2345', '2022-04-03'),
    ('susan@example.com', '555-6789', '2022-04-03'),
    ('david@example.com', '555-3456', '2022-04-04'),
    ('mary@example.com', '555-7890', '2022-04-04'),
    ('jessica@example.com', '555-4567', '2022-04-05'),
    ('steve@example.com', '555-8901', '2022-04-05');
    
INSERT INTO booking.UserReview (user_id, owner_id, rating, comment)
VALUES 
    (1, 2, 4, 'Bob was a great guest and left the venue in excellent condition.'),
    (2, 1, 3, 'Alice was generally respectful of the space, but left a few small messes.'),
    (1, 3, 5, 'Excellent communication and punctuality from David, would definitely rent to him again.'),
    (2, 3, 2, 'Unfortunately, Jennifer left the space in very poor condition.'),
    (1, 4, 4, 'Very easy to work with and respectful of the space.'),
    (2, 4, 1, 'John was extremely difficult to work with and did not follow our rental agreement.'),
    (1, 5, 5, 'Jasmine was a fantastic guest who left the space cleaner than when she arrived.'),
    (2, 5, 3, 'Overall, Stephen was a good guest, but was a bit careless with some of our equipment.'),
    (1, 6, 2, 'Unfortunately, Brian caused significant damage to the space during his rental.'),
    (2, 6, 4, 'Ellen was a pleasure to work with and left the space in great condition.');
    
INSERT INTO booking.Amenity (name, description)
VALUES 
    ('Swimming pool', 'An outdoor pool to relax and cool off on hot days'),
    ('Sauna', 'A dry or wet heat room for relaxation and health benefits'),
    ('Gym', 'A well-equipped fitness center to stay active and fit'),
    ('Spa', 'A relaxing and rejuvenating space to pamper yourself'),
    ('Theater room', 'A private cinema experience with surround sound and comfortable seating'),
    ('Billiards', 'A game room with a billiards table for fun and entertainment'),
    ('Hot tub', 'A large tub with hot water and jets for relaxation and hydrotherapy'),
    ('Tennis court', 'A court for playing tennis, with rackets and balls provided'),
    ('Barbecue grill', 'An outdoor cooking appliance for grilling and barbecuing'),
    ('Bicycles', 'Bicycles for guests to explore the surrounding area on two wheels');
    

INSERT INTO booking.Venue_x_Amenity (venue_id, amenity_id)
VALUES (1, 1),
       (1, 2),
       (2, 2),
       (3, 3),
       (4, 1),
       (4, 3),
       (5, 2),
       (6, 1),
       (6, 3),
       (7, 2);
       
INSERT INTO booking.VenueReview (venue_id, user_id, rating, comment)
VALUES (1, 2, 4, 'The Party Palace was the perfect venue for our event'),
       (2, 1, 3, 'The Lakeside Lodge was cozy, but could use some updates'),
       (1, 1, 5, 'John was an amazing host and went above and beyond for us'),
       (2, 2, 4, 'Jane was great and provided everything we needed for a great weekend'),
       (1, 2, 2, 'The sound system at the Party Palace was outdated and difficult to use'),
       (2, 1, 5, 'The view of the lake from Lakeside Lodge was breathtaking'),
       (1, 1, 4, 'We had a blast at the Party Palace, would definitely book again'),
       (2, 2, 3, 'The cabin was clean and comfortable, but could use some more amenities'),
       (1, 2, 5, NULL),
       (2, 1, 4, 'The Lakeside Lodge was the perfect getaway for a weekend of relaxation');
       
INSERT INTO booking.Rate (name, description)
VALUES ('Per Hour', 'Rate charged per hour of rental time'),
       ('Per Day', 'Rate charged per day of rental time'),
       ('Per Person', 'Rate charged per person'),
       ('Per Mile', 'Rate charged per mile traveled'),
       ('Flat Fee', 'Flat fee charged for a service'),
       ('Commission', 'Rate charged as a percentage of sales'),
       ('Per Item', 'Rate charged per item sold'),
       ('Per Gigabyte', 'Rate charged per gigabyte of data'),
       ('Per Call', 'Rate charged per call made or received'),
       ('Per Visit', 'Rate charged per visit to a location');


INSERT INTO booking.Offer (venue_id, rate_id, price)
VALUES (1, 1, 100.00),
       (1, 2, 500.00),
       (2, 1, 75.00),
       (2, 2, 300.00),
       (3, 1, 200.00),
       (3, 2, 1000.00),
       (4, 1, 50.00),
       (4, 2, 250.00),
       (5, 1, 150.00),
       (5, 2, 750.00),
       (6, 1, 80.00),
       (6, 2, 400.00),
       (7, 1, 120.00),
       (7, 2, 600.00),
       (8, 1, 90.00);

INSERT INTO booking.Booking (offer_id, user_id, start_date, finish_date)
VALUES (1, 1, '2023-05-01', '2023-05-02'),
       (2, 2, '2023-06-01', '2023-06-03'),
       (1, 3, '2023-05-07', '2023-05-09'),
       (3, 1, '2023-07-10', '2023-07-12'),
       (4, 2, '2023-07-15', '2023-07-20'),
       (5, 3, '2023-08-01', '2023-08-05'),
       (6, 4, '2023-09-01', '2023-09-03'),
       (7, 5, '2023-10-01', '2023-10-03'),
       (8, 6, '2023-11-01', '2023-11-03'),
       (9, 7, '2023-12-01', '2023-12-03'),
       (1, 8, '2024-01-01', '2024-01-03'),
       (1, 9, '2024-02-01', '2024-02-03'),
       (2, 10, '2024-03-01', '2024-03-03'),
       (3, 10, '2024-04-01', '2024-04-03'),
       (4, 10, '2024-05-01', '2024-05-03');




UPDATE booking.Owner
SET phone = '555-5555'
WHERE email = 'johndoe@example.com';

UPDATE booking.Venue
SET description = 'An elegant event space in the heart of the city'
WHERE venue_id = 5;

UPDATE booking.User
SET registration_date = '2022-05-01'
WHERE email = 'alice@example.com';

UPDATE booking.UserReview
SET rating = 3, comment = 'The guest was late and left a mess'
WHERE user_id = 2 AND owner_id = 1;

UPDATE booking.Amenity
SET name = 'Audio System'
WHERE amenity_id = 1;

UPDATE booking.Amenity
SET description = 'State-of-the-art audio system for events'
WHERE amenity_id = 1;

UPDATE booking.Venue_x_Amenity
SET amenity_id = 4
WHERE amenity_id = 1;

UPDATE booking.Rate
SET name = 'Hourly Rate'
WHERE rate_id = 1;

INSERT INTO booking.OfferHistory
SELECT offer_id, NOW(), price from booking.Offer;

UPDATE booking.Offer
SET price = 125.00
WHERE offer_id = 1;



DELETE FROM booking.UserReview WHERE rating < 3;
DELETE FROM booking.VenueReview WHERE comment IS NULL;
DELETE FROM booking.Offer WHERE price > money(500);
DELETE FROM booking.User WHERE deregistration_date < '2023-04-19';
DELETE FROM booking.Owner WHERE phone = '555-8901';
DELETE FROM booking.Venue_x_Amenity WHERE amenity_id = 9;
DELETE FROM booking.Amenity WHERE description LIKE '%grill%';
DELETE FROM booking.Venue WHERE owner_id = 2;
DELETE FROM booking.Rate WHERE description LIKE '%Commission%' OR description LIKE '%fee%';


SELECT * FROM booking.User;

SELECT name, description FROM booking.Venue WHERE owner_id = 5;

SELECT AVG(rating) FROM booking.VenueReview;

SELECT * FROM booking.Offer ORDER BY price DESC LIMIT 5;

SELECT name FROM booking.Rate WHERE rate_id = 7;

SELECT COUNT(*) FROM booking.Booking;

SELECT v.name, a.name 
FROM booking.Venue v 
JOIN booking.Venue_x_Amenity va ON v.venue_id = va.venue_id 
JOIN booking.Amenity a ON va.amenity_id = a.amenity_id 
WHERE a.amenity_id = 3;

SELECT DISTINCT u.user_id, u.email 
FROM booking.User u 
JOIN booking.Booking b ON u.user_id = b.user_id;

SELECT v.name, o.email 
FROM booking.Venue v 
JOIN booking.Owner o ON v.owner_id = o.owner_id 
WHERE v.venue_id IN (
  SELECT venue_id 
  FROM booking.VenueReview 
  GROUP BY venue_id 
  HAVING AVG(rating) > 3
);

SELECT a.name, COUNT(*) 
FROM booking.Amenity a 
JOIN booking.Venue_x_Amenity va ON a.amenity_id = va.amenity_id 
GROUP BY a.name;

