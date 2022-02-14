SET client_min_messages = error;
SET search_path TO ${flyway:defaultSchema},${flyway:defaultSchema}_jobs,public;

CREATE OR REPLACE FUNCTION set_address_from_point() RETURNS TRIGGER AS $$
  <<vars>>
  BEGIN
    IF NEW.location_point IS NOT NULL THEN
      -- Get address string from point
      NEW.address := reverse_geocode(NEW.location_point);
    END IF;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER SET search_path FROM CURRENT;
COMMENT ON FUNCTION set_address_from_point() IS 'Inserts \`address\` string based on provided location point.';

-- Get Address string from point and set it for guitar_manufacturer table
CREATE TRIGGER update_address_string AFTER INSERT OR UPDATE ON 
  guitar_manufacturer FOR EACH ROW EXECUTE PROCEDURE set_address_from_point();

-- Get Address string from point and set it for store table
CREATE TRIGGER update_address_string AFTER INSERT OR UPDATE ON 
  store FOR EACH ROW EXECUTE PROCEDURE set_address_from_point();