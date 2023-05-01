create or replace view clean_playstation_data as

with 
trim as (
	SELECT 
		TRIM(BOTH "'" FROM name) AS name,
		TRIM(BOTH "'" FROM platforms) AS platforms,
		TRIM(BOTH "'" FROM original_price) AS original_price,
		TRIM(BOTH "'" FROM discount_price) AS discount_price,
		TRIM(BOTH "'" FROM discount) AS discount,
		TRIM(BOTH "'" FROM product_type) AS product_type,
		rank_in_sale,
		TRIM(BOTH "'" FROM sale_name) AS sale_name,
		STR_TO_DATE(TRIM(BOTH "'" FROM date), "%Y-%m-%d") AS date
	FROM my_db.playstation_store_games
),

clean as (
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
	FROM trim
),

final as (
	select
		product_name,
		platform,
		is_available,
		ifnull(discounted_price_gbp, original_price_gbp) as current_price,
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
	from clean
)

select * from final
;
