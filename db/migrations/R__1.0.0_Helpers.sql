CREATE OR REPLACE FUNCTION create_fake_data() RETURNS void as $$
  <<vars>>
  BEGIN
    -- Gibson
    INSERT INTO guitar_manufacturer (id, name) VALUES ('b3f46688-f59e-4aa7-bbab-d26a7bb061bc', 'Gibson');
    INSERT INTO guitar_model (id, model, manufacturer_id) VALUES ('1fffc423-cada-4331-9245-e97d5bf401de', 'SG Standard \`61', 'b3f46688-f59e-4aa7-bbab-d26a7bb061bc');
    INSERT INTO guitar_model (id, model, manufacturer_id) VALUES ('dda9ecfe-2d8d-4604-a285-b09284c15180', 'Les Paul Classic', 'b3f46688-f59e-4aa7-bbab-d26a7bb061bc');
    INSERT INTO guitar_model (id, model, manufacturer_id) VALUES ('cccfc94b-5242-4279-9a89-a2e3ea3e7032', '70s Flying V', 'b3f46688-f59e-4aa7-bbab-d26a7bb061bc');
    INSERT INTO guitar (id, model_id, manufacturer_id, year) VALUES ('ed0770fe-e89f-4eb2-ad32-d2190094da1b', '1fffc423-cada-4331-9245-e97d5bf401de', 'b3f46688-f59e-4aa7-bbab-d26a7bb061bc', 1961);
    INSERT INTO guitar (id, model_id, manufacturer_id, year) VALUES ('a459bf96-12b0-48dc-9659-3ac4e2279374', 'dda9ecfe-2d8d-4604-a285-b09284c15180', 'b3f46688-f59e-4aa7-bbab-d26a7bb061bc', 1960);
    INSERT INTO guitar (id, model_id, manufacturer_id, year) VALUES ('d4772509-60b0-40e3-bd3d-c30a286fe5f8', 'cccfc94b-5242-4279-9a89-a2e3ea3e7032', 'b3f46688-f59e-4aa7-bbab-d26a7bb061bc', 1970);
    -- Yamaha
    INSERT INTO guitar_manufacturer (id, name) VALUES ('33a7eb43-72e5-47e5-b9b7-cf0103cdaa68', 'Yamaha');
    INSERT INTO guitar_model (id, model, manufacturer_id) VALUES ('51a8dc29-a2a7-4c7c-8ecc-bd9516630519', 'FS-TA', '33a7eb43-72e5-47e5-b9b7-cf0103cdaa68');
    INSERT INTO guitar_model (id, model, manufacturer_id) VALUES ('71a256ab-aabe-4270-9b1e-65731d5b2fb0', 'APX', '33a7eb43-72e5-47e5-b9b7-cf0103cdaa68');
    INSERT INTO guitar (id, model_id, manufacturer_id, year) VALUES ('ffbe8fbd-a1eb-4132-8114-9bd15ede4dad', '51a8dc29-a2a7-4c7c-8ecc-bd9516630519', '33a7eb43-72e5-47e5-b9b7-cf0103cdaa68', 2020);
    INSERT INTO guitar (id, model_id, manufacturer_id, year) VALUES ('daaea5a9-bd32-4d3b-9036-74c52d16419e', '71a256ab-aabe-4270-9b1e-65731d5b2fb0', '33a7eb43-72e5-47e5-b9b7-cf0103cdaa68', 2015);
    -- Fender
    INSERT INTO guitar_manufacturer (id, name) VALUES ('90a2ffe2-7456-472c-806c-2eef62b73bd1', 'Fender');
    INSERT INTO guitar_model (id, model, manufacturer_id) VALUES ('54836cb7-d620-474c-a730-19c36aa0ee10', 'Jimi Hendrix Stratocaster', '90a2ffe2-7456-472c-806c-2eef62b73bd1');
    INSERT INTO guitar_model (id, model, manufacturer_id) VALUES ('167062a4-5d72-450d-a5ba-0a482d8ac00e', 'Telecaster', '90a2ffe2-7456-472c-806c-2eef62b73bd1');
    INSERT INTO guitar (id, model_id, manufacturer_id, year) VALUES ('184149a5-9cc3-489a-b65a-bb93eb4ff23e', '54836cb7-d620-474c-a730-19c36aa0ee10', '90a2ffe2-7456-472c-806c-2eef62b73bd1', 1975);
    INSERT INTO guitar (id, model_id, manufacturer_id, year) VALUES ('31d3d26c-9852-4466-95a8-f85fb65e0708', '167062a4-5d72-450d-a5ba-0a482d8ac00e', '90a2ffe2-7456-472c-806c-2eef62b73bd1', 1963);
    -- Stores
    INSERT INTO store (id, name) VALUES ('cdfd997d-13d7-4f0b-aedd-9a6610679178', 'Thomann');
    INSERT INTO store (id, name) VALUES ('e1a22540-4679-4322-897b-824ee6dccef1', 'Guitar Center');
    -- Guitars in Thomann
    INSERT INTO product (id, guitar_id, store_id, price, quantity) VALUES (
      '56423411-d4d8-4f97-adfe-935077283308', 
      'ed0770fe-e89f-4eb2-ad32-d2190094da1b', -- SG Standard 61
      'cdfd997d-13d7-4f0b-aedd-9a6610679178',
      '$1999.00',
      24
    );
    INSERT INTO product (id, guitar_id, store_id, price, quantity) VALUES (
      'f59f8184-cdcb-4293-8436-b16bc163bd2a',
      'a459bf96-12b0-48dc-9659-3ac4e2279374', -- Les Paul Classic
      'cdfd997d-13d7-4f0b-aedd-9a6610679178',
      '$2299.00',
      16
    );
    INSERT INTO product (id, guitar_id, store_id, price, quantity) VALUES (
      'f858ce83-a87d-44d6-a7fc-39665d0108c8',
      'd4772509-60b0-40e3-bd3d-c30a286fe5f8', -- 70s Flying V
      'cdfd997d-13d7-4f0b-aedd-9a6610679178',
      '$1899.00',
      21
    );
    INSERT INTO product (id, guitar_id, store_id, price, quantity) VALUES (
      '9e9684d8-a544-40a1-9325-86d87b3b4193',
      'ffbe8fbd-a1eb-4132-8114-9bd15ede4dad', -- FS-TA
      'cdfd997d-13d7-4f0b-aedd-9a6610679178',
      '$999.00',
      3
    );
    INSERT INTO product (id, guitar_id, store_id, price, quantity) VALUES (
      '8d8a0c53-07a0-4cbc-8118-ab114b45e089',
      '184149a5-9cc3-489a-b65a-bb93eb4ff23e', -- Jimi Hendrix Stratocaster
      'cdfd997d-13d7-4f0b-aedd-9a6610679178',
      '$1299.00',
      1
    );
    INSERT INTO product (id, guitar_id, store_id, price, quantity) VALUES (
      '2a7c6916-c8aa-4be6-8d70-30d8fd6583a4',
      '31d3d26c-9852-4466-95a8-f85fb65e0708', -- Telecaster
      'cdfd997d-13d7-4f0b-aedd-9a6610679178',
      '$2699.00',
      1
    );
    -- Guitars in Guitar Center
    INSERT INTO product (id, guitar_id, store_id, price, quantity) VALUES (
      '7080e564-7a15-4fb9-a5ef-07578c19f24a', 
      'ed0770fe-e89f-4eb2-ad32-d2190094da1b', -- SG Standard 61
      'e1a22540-4679-4322-897b-824ee6dccef1',
      '$1895.20',
      7
    );
    INSERT INTO product (id, guitar_id, store_id, price, quantity) VALUES (
      '96ccb376-53d8-4486-9e38-f54bde84fb82', 
      'a459bf96-12b0-48dc-9659-3ac4e2279374', -- Les Paul Classic
      'e1a22540-4679-4322-897b-824ee6dccef1',
      '$2400.20',
      31
    );
    INSERT INTO product (id, guitar_id, store_id, price, quantity) VALUES (
      '115fcbbb-90e3-4f31-8395-64dcb82790d1', 
      'd4772509-60b0-40e3-bd3d-c30a286fe5f8', -- 70s Flying V
      'e1a22540-4679-4322-897b-824ee6dccef1',
      '$1900',
      31
    );
    INSERT INTO product (id, guitar_id, store_id, price, quantity) VALUES (
      'ee71972a-8273-4836-b201-dee65c723440',
      'ffbe8fbd-a1eb-4132-8114-9bd15ede4dad', -- FS-TA
      'e1a22540-4679-4322-897b-824ee6dccef1',
      '$955.00',
      1
    );
    INSERT INTO product (id, guitar_id, store_id, price, quantity) VALUES (
      'cd08b049-990c-42e5-87bd-d69dcef73d7a',
      'daaea5a9-bd32-4d3b-9036-74c52d16419e', -- APX
      'e1a22540-4679-4322-897b-824ee6dccef1',
      '$2100.00',
      8
    );
  END;
$$ LANGUAGE plpgsql VOLATILE STRICT SECURITY INVOKER SET search_path FROM CURRENT;
COMMENT ON FUNCTION create_fake_data() IS 'Creates fake \`data\`.';