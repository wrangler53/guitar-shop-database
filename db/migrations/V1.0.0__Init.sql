SET client_min_messages = error;
SET search_path TO ${flyway:defaultSchema},${flyway:defaultSchema}_jobs,public;

-- Guitar Manufacturer table
CREATE TABLE guitar_manufacturer (
  id UUID NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  -- Type POINT can be used with Postgres version 9.5+ 
  location_point GEOGRAPHY (POINT), 
  address TEXT,
  -- There should be no identical manufacturers with the same name in the same location
  CONSTRAINT guitar_manufacturer_unique_name_location UNIQUE (name, location_point), 
  PRIMARY KEY (id)
);
CREATE INDEX guitar_manufacturer_name_idx ON guitar_manufacturer (name);
CREATE INDEX guitar_manufacturer_id_idx ON guitar_manufacturer (id);

-- Guitar Model table 
CREATE TABLE guitar_model (
  id UUID NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  model TEXT NOT NULL,
  manufacturer_id UUID NOT NULL,
  -- There should be no more than one guitar model from the same manufacturer
  CONSTRAINT guitar_model_unique_manufacturer_name UNIQUE (model, manufacturer_id),
  CONSTRAINT manufacturer_id_fk FOREIGN KEY (manufacturer_id) REFERENCES guitar_manufacturer (id) ON UPDATE CASCADE,
  PRIMARY KEY (id)
);
CREATE INDEX guitar_model_name_idx ON guitar_model (model);
CREATE INDEX guitar_model_id_idx ON guitar_model (id);

-- Guitar table
CREATE TABLE guitar (
  id UUID NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  model_id UUID NOT NULL,
  manufacturer_id UUID NOT NULL,
  year INT NOT NULL,
   -- There should be no more than one guitar model from the same manufacturer
  CONSTRAINT guitar_unique_manufacturer_model UNIQUE (manufacturer_id, model_id),
  CONSTRAINT guitar_model_id_fk FOREIGN KEY (model_id) REFERENCES guitar_model (id) ON UPDATE CASCADE,
  CONSTRAINT guitar_manufacturer_id_fk FOREIGN KEY (manufacturer_id) REFERENCES guitar_manufacturer (id) ON UPDATE CASCADE,
  PRIMARY KEY (id)
);
CREATE INDEX guitar_id_idx ON guitar (id);

-- Store table
CREATE TABLE store (
  id UUID NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  -- Type POINT can be used with Postgres version 9.5+ 
  location_point GEOGRAPHY (POINT),
  address TEXT,
  -- There should be no identical stores with the same name in the same location
  CONSTRAINT store_unique_name_location UNIQUE (name, location_point),
  PRIMARY KEY (id)
);
CREATE INDEX store_id_idx ON store (id);

-- Product table (consists the data about all the guitars avaliable in a store and their prices and quantites)
CREATE TABLE product (
  id UUID NOT NULL UNIQUE DEFAULT gen_random_uuid(),
  guitar_id UUID NOT NULL,
  store_id UUID NOT NULL,
  price MONEY NOT NULL,
  quantity INT NOT NULL DEFAULT 0,
  CONSTRAINT product_guitar_id_fk FOREIGN KEY (guitar_id) REFERENCES guitar (id) ON UPDATE CASCADE,
  CONSTRAINT product_store_id_fk FOREIGN KEY (store_id) REFERENCES store (id) ON UPDATE CASCADE,
  -- There should be only one guitar in a particular store, quantity should be use to count an amount of guitars
  CONSTRAINT product_unique_store_guitar UNIQUE (store_id, guitar_id),
  PRIMARY KEY (id)
);
CREATE INDEX product_id_idx ON product (id);