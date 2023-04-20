CREATE SCHEMA booking;

CREATE TABLE booking.Owner (
  owner_id SERIAL PRIMARY KEY,
  email VARCHAR(50) NOT NULL,
  phone VARCHAR(15) NOT NULL,
  registration_date TIMESTAMP NOT NULL,
  deregistration_date TIMESTAMP CHECK(deregistration_date >= registration_date) 
);

CREATE TABLE booking.Venue (
  venue_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  location POINT NOT NULL,
  description VARCHAR(1000),
  owner_id INTEGER NOT NULL,
  FOREIGN KEY (owner_id) REFERENCES booking.Owner(owner_id)
);

CREATE TABLE booking.User (
  user_id SERIAL PRIMARY KEY,
  email VARCHAR(50) NOT NULL,
  phone VARCHAR(15) NOT NULL,
  registration_date TIMESTAMP NOT NULL,
  deregistration_date TIMESTAMP CHECK(deregistration_date >= registration_date)
);

CREATE TABLE booking.UserReview (
  user_id INTEGER NOT NULL,
  owner_id INTEGER NOT NULL,
  rating SMALLINT CHECK (rating >= 1 AND rating <= 5),
  comment VARCHAR(500),
  FOREIGN KEY (user_id) REFERENCES booking.User(user_id),
  FOREIGN KEY (owner_id) REFERENCES booking.Owner(owner_id)
);

CREATE TABLE booking.Amenity (
  amenity_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(300) NOT NULL
);

CREATE TABLE booking.Venue_x_Amenity (
  venue_id INTEGER NOT NULL,
  amenity_id INTEGER NOT NULL,
  FOREIGN KEY (venue_id) REFERENCES booking.Venue(venue_id) ON DELETE CASCADE,
  FOREIGN KEY (amenity_id) REFERENCES booking.Amenity(amenity_id) ON DELETE RESTRICT
);

CREATE TABLE booking.VenueReview (
  venue_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  rating SMALLINT CHECK (rating >= 1 AND rating <= 5),
  comment VARCHAR(500),
  FOREIGN KEY (venue_id) REFERENCES booking.Venue(venue_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES booking.User(user_id)
);

CREATE TABLE booking.Rate (
  rate_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(300) NOT NULL
);

CREATE TABLE booking.Offer (
  offer_id SERIAL PRIMARY KEY,
  venue_id INTEGER NOT NULL,
  rate_id INTEGER NOT NULL,
  price MONEY,
  FOREIGN KEY (venue_id) REFERENCES booking.Venue(venue_id) ON DELETE CASCADE,
  FOREIGN KEY (rate_id) REFERENCES booking.Rate(rate_id) ON DELETE RESTRICT
);

CREATE TABLE booking.OfferHistory (
  offer_id INTEGER NOT NULL,
  valid_to TIMESTAMP NOT NULL,
  price MONEY,
  FOREIGN KEY (offer_id) REFERENCES booking.Offer(offer_id) ON DELETE CASCADE
);

CREATE TABLE booking.Booking (
  booking_id SERIAL PRIMARY KEY,
  offer_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  start_date TIMESTAMP NOT NULL,
  finish_date TIMESTAMP CHECK(finish_date >= start_date),
  FOREIGN KEY (offer_id) REFERENCES booking.Offer(offer_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES booking.User(user_id)
);

