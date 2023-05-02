create or replace view cheap_today as
with cheapest as (
           SELECT product_name, min(current_price) as cheapest_price
           FROM clean_playstation_data 
           where product_type = 'FULL_GAME'
           group by product_name
           )
           select distinct cl.product_name, cl.current_price, cl.display_discount as discount
           from clean_playstation_data cl
           	inner join cheapest ch on cl.product_name = ch.product_name and cl.current_price = ch.cheapest_price
           where date_recorded = CURDATE()
           and product_type = 'FULL_GAME'
           and current_price > 2
           and is_discounted = True
           order by discount desc, cl.current_price, cl.product_name
           limit 100;