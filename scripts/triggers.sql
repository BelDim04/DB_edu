CREATE OR REPLACE FUNCTION process_offer_history() RETURNS TRIGGER AS $offer_history$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO emp_audit SELECT OLD.offer_id, now(), OLD.price;
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO emp_audit SELECT OLD.offer_id, now(), OLD.price;
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$offer_history$ LANGUAGE plpgsql;

CREATE TRIGGER offer_history
AFTER UPDATE OR DELETE ON booking.Offer
    FOR EACH ROW EXECUTE PROCEDURE process_offer_history();



CREATE OR REPLACE FUNCTION no_rewrite()
 RETURNS event_trigger
 LANGUAGE plpgsql AS
$$
---
--- Реализация локальной политики перезаписи таблиц:
---   перезапись booking.Booking не допускается,
---   другие таблицы могут перезаписываться между 1 часом ночи и 6 часами утра,
---   если только их размер не превышает 100 блоков
---
DECLARE
  table_oid oid := pg_event_trigger_table_rewrite_oid();
  current_hour integer := extract('hour' from current_time);
  pages integer;
  max_pages integer := 100;
BEGIN
  IF pg_event_trigger_table_rewrite_oid() = 'booking.Booking'::regclass
  THEN
        RAISE EXCEPTION 'not allowed to rewrite the table %',
                        table_oid::regclass;
  END IF;

  SELECT INTO pages relpages FROM pg_class WHERE oid = table_oid;
  IF pages > max_pages
  THEN
        RAISE EXCEPTION 'rewrites only allowed for table with less than % pages',
                        max_pages;
  END IF;

  IF current_hour NOT BETWEEN 1 AND 6
  THEN
        RAISE EXCEPTION 'rewrites only allowed between 1am and 6am';
  END IF;
END;
$$;

CREATE EVENT TRIGGER no_rewrite_allowed
                  ON table_rewrite
   EXECUTE PROCEDURE no_rewrite();