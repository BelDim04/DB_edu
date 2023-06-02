CREATE OR REPLACE FUNCTION is_empty(v_id integer, start timestamp, finish timestamp)
RETURNS bool AS $$
SELECT 
  CASE WHEN COUNT(*) = 0 THEN True
  ELSE False
  END as res
FROM booking.Booking b
JOIN booking.Offer o on o.offer_id = b.offer_id
JOIN booking.Venue v on v.venue_id = o.venue_id
WHERE v.venue_id = v_id AND (b.start_date IN (start, finish)
						  OR b.start_date < start AND b.finish_date > start)
LIMIT 1;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION description(u_id integer) RETURNS text AS $$
DECLARE
res text;
c text;
BEGIN
res := '';
FOR c IN SELECT comment FROM booking.UserReview WHERE user_id = u_id
LOOP
    res := res || ' ' || c;
END LOOP;
RETURN res;
END $$ LANGUAGE plpgsql;

SELECT description(1);

