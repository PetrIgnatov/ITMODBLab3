CREATE FUNCTION place_stamp() RETURNS trigger AS $place_stamp$
	BEGIN
		IF NEW.x IS NULL THEN
			RAISE EXCEPTION 'Place x cannot be null';
		END IF;
		IF NEW.y IS NULL THEN
                        RAISE EXCEPTION 'Place y cannot be null';
                END IF;
		IF NEW.z IS NULL THEN
                        RAISE EXCEPTION 'Place z cannot be null';
                END IF;
		IF NEW.galaxy IS NULL THEN
                        RAISE EXCEPTION 'Place galaxy cannot be null';
                END IF;
	END;
$place_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER place_stamp BEFORE INSERT OR UPDATE ON PLACE
	FOR EACH ROW EXECUTE PROCEDURE place_stamp();

