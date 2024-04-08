CREATE OR REPLACE FUNCTION routeDistance (routeid INTEGER) RETURNS FLOAT as $dist$
        DECLARE
                dist FLOAT := 0;
                startid INTEGER;
                finishid INTEGER;
                startX INTEGER;
                finishX INTEGER;
                startY INTEGER;
                finishY INTEGER;
                startZ INTEGER;
                finishZ INTEGER;
                startGal TEXT;
                finishGal TEXT;
                dx INTEGER;
                dy INTEGER;
                dz INTEGER;
        BEGIN
                SELECT ROUTE.startid INTO startid FROM ROUTE WHERE routeid = ROUTE.id;
                SELECT ROUTE.finishid INTO finishid FROM ROUTE WHERE routeid = ROUTE.id;
                IF NOT FOUND THEN
                        RAISE EXCEPTION 'Route % not found!', routeid;
                END IF;
                IF startid IS NULL OR finishid IS NULL THEN
                        RAISE EXCEPTION 'No start or finish found';
                END IF;
                SELECT PLACE.x, PLACE.y, PLACE.z, PLACE.galaxy INTO startX, startY, startZ, startGal FROM PLACE WHERE PLACE.id = startid;
                SELECT PLACE.x, PLACE.y, PLACE.z, PLACE.galaxy INTO finishX, finishY, finishZ, finishGal FROM PLACE WHERE PLACE.id = finishid;
                IF startGal != finishGal THEN
                        RAISE EXCEPTION 'Start and finish have different galaxies, cant find the distance';
                END IF;
                dist := sqrt((startX-finishX)*(startX-finishX)+(startY-finishY)*(startY-finishY)+(startZ-finishZ)*(startZ-finishZ));
                RETURN dist;
END;
$dist$ LANGUAGE plpgsql;

