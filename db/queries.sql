-- Get all shops, its names and locations where Gibson SG are selling, also price model and quantity
select guitar_manufacturer.name as manufacturer_name, 
	store.name as store_name,
	guitar_model.model as guitar_model_name,
	product.price as price,
	store.address as store_address,
	product.quantity as quantity 
	from product
	join store on product.store_id = store.id 
	join guitar on product.guitar_id = guitar.id
	join guitar_model on guitar_model.id = guitar.model_id
	join guitar_manufacturer on guitar.manufacturer_id = guitar_manufacturer.id
	where guitar_manufacturer.name = 'Gibson' and guitar_model.model like '%SG%'
	order by price asc; 

-- Get average prices for all existing guitars
select AVG(price::numeric) from product;

-- Get all Yamaha or Gibson guitar models
select model from guitar_model 
	where manufacturer_id in (select id from guitar_manufacturer where name = 'Yamaha' or name = 'Gibson');

-- Get all Yamaha guitar models that are being sold
select distinct on (guitar_model.id)
	product.id as product_id, guitar_model.model as guitar_model_name, guitar_manufacturer.name as manufaturer 
	from product 
	join guitar on product.guitar_id = guitar.id
	join guitar_manufacturer on guitar.manufacturer_id = guitar_manufacturer.id
	join guitar_model on guitar.model_id = guitar_model.id
	where guitar_manufacturer.name = 'Yamaha';

-- Average price among all Gibson guitars in all stores
select AVG(price::numeric) from product
	join guitar on product.guitar_id = guitar.id 
	join guitar_manufacturer on guitar.manufacturer_id = guitar_manufacturer.id
	where guitar_manufacturer.name = 'Gibson';

-- Get all guitars that are selling in the Guitar Center and their prices
select (model, price) from product
	join guitar on product.guitar_id = guitar.id
	join guitar_model on guitar.model_id = guitar_model.id
	where store_id = (select id from store where name = 'Guitar Center');

-- The cheapest Fender guitar and its model
select distinct on (guitar_manufacturer.id) price, model from product
	join guitar on product.guitar_id = guitar.id
	join guitar_manufacturer on guitar.manufacturer_id = guitar_manufacturer.id
	join guitar_model on guitar.model_id = guitar_model.id
	where guitar.manufacturer_id = (select id from guitar_manufacturer where name = 'Fender')
	order by guitar_manufacturer.id, price asc;

-- Get min price for Les Paul Classic accross all the shops and the shop name
select distinct on (model) 
	model, price, store.name as store_name 
	from product
	join guitar on product.guitar_id = guitar.id
	join guitar_model on guitar.model_id = guitar_model.id
	join store on store.id = product.store_id 
	where guitar.model_id = (select id from guitar_model where model like '%Flying V%')
	order by model, price, store_name asc;