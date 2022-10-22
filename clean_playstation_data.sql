with base as (
select 
	name as product_name,
	platforms as platform,
	case when lower(original_price) = 'unavailable' or original_price is null then False else True end as is_available,
	cast(CASE 
		when lower(original_price) in ('free') or lower(original_price) like '%trial%' then 0
		when lower(original_price) = 'unavailable' or original_price is null then null
		when original_price like '£%' then REPLACE(original_price, '£', '')
		else original_price
	END as DECIMAL(10,2)) as original_price_gbp,
	cast(CASE 
		when lower(discount_price) in ('free') or lower(discount_price) like '%trial%' then 0
		when lower(discount_price) = 'unavailable' or discount_price is null then null
		when discount_price like '£%' then REPLACE(discount_price, '£', '')
		else discount_price
	END as DECIMAL(10,2)) as discounted_price_gbp,
	discount,
	product_type,
	sale_name,
	rank_in_sale,
	`date` as date_recorded
FROM my_db.playstation_store_games
)

select
	product_name,
	platform,
	is_available,
	original_price_gbp,
	case when discounted_price_gbp != original_price_gbp then True else False end as is_discounted,
	case when discounted_price_gbp != original_price_gbp then discounted_price_gbp else null end as discounted_price_gbp,
	discount as display_discount,
	case when discounted_price_gbp != original_price_gbp then
		(discounted_price_gbp / original_price_gbp) - 1
	end as real_discount,
	product_type,
	sale_name,
	rank_in_sale,
	date_recorded
from base
