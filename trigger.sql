CREATE FUNCTION planet_check() RETURNS trigger AS $planet_check$
	BEGIN
        IF (SELECT COUNT(*) FROM PLACE WHERE PLACE.id = NEW.placeid) = 0 THEN
                INSERT INTO PLACE (id, x,y,z,galaxy) VALUES
                        (NEW.placeid, 0, 0, 0,'Sample galaxy');
        END IF;
        RETURN NULL;
END;
$planet_check$ LANGUAGE plpgsql;

CREATE TRIGGER planet_check BEFORE INSERT OR UPDATE ON PLANET
        FOR EACH ROW EXECUTE PROCEDURE planet_check();
