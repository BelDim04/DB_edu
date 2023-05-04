CREATE INDEX ON booking.Venue_x_Amenity using HASH (amenity_id);
CREATE INDEX ON booking.Venue using HASH (owner_id);
CREATE INDEX ON booking.Owner using HASH (email);
CREATE INDEX ON booking.Offer (rate_id, price);
CREATE INDEX ON booking.Offer using HASH (venue_id);
CREATE INDEX ON booking.VenueReview using HASH (venue_id);
CREATE INDEX ON booking.UserReview using HASH (user_id);
CREATE INDEX ON booking.Booking using HASH (user_id);
CREATE INDEX ON booking.Booking (offer_id, finish_date);

