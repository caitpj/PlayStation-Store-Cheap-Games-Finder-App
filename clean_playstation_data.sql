{\rtf1\ansi\ansicpg1252\cocoartf2639
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Menlo-Bold;\f1\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red115\green158\blue202;\red170\green170\blue170;\red158\green158\blue158;
\red193\green170\blue108;\red202\green197\blue128;\red192\green192\blue192;}
{\*\expandedcolortbl;;\csgenericrgb\c45098\c61961\c79216;\csgenericrgb\c66667\c66667\c66667;\csgenericrgb\c61961\c61961\c61961;
\csgenericrgb\c75686\c66667\c42353;\csgenericrgb\c79216\c77255\c50196;\csgenericrgb\c75294\c75294\c75294;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\b\fs24 \cf2 with
\f1\b0 \cf3  \cf4 base\cf3  
\f0\b \cf2 as
\f1\b0 \cf3  (\cf0 \

\f0\b \cf2 select
\f1\b0 \cf3  \cf0 \
\pard\pardeftab720\partightenfactor0
\cf3 	\cf4 name\cf3  
\f0\b \cf2 as
\f1\b0 \cf3  \cf4 product_name\cf3 ,\cf0 \
\cf3 	\cf4 platforms\cf3  
\f0\b \cf2 as
\f1\b0 \cf3  \cf4 platform\cf3 ,\cf0 \
\cf3 	
\f0\b \cf2 case
\f1\b0 \cf3  
\f0\b \cf2 when
\f1\b0 \cf3  
\f0\b \cf5 lower
\f1\b0 \cf3 (\cf4 original_price\cf3 ) = \cf6 'unavailable'\cf3  
\f0\b \cf2 or
\f1\b0 \cf3  \cf4 original_price\cf3  
\f0\b \cf2 is
\f1\b0 \cf3  
\f0\b \cf2 null
\f1\b0 \cf3  
\f0\b \cf2 then
\f1\b0 \cf3  
\f0\b \cf2 False
\f1\b0 \cf3  
\f0\b \cf2 else
\f1\b0 \cf3  
\f0\b \cf2 True
\f1\b0 \cf3  
\f0\b \cf2 end
\f1\b0 \cf3  
\f0\b \cf2 as
\f1\b0 \cf3  \cf4 is_available\cf3 ,\cf0 \
\cf3 	
\f0\b \cf5 cast
\f1\b0 \cf3 (
\f0\b \cf2 CASE
\f1\b0 \cf3  \cf0 \
\cf3 		
\f0\b \cf2 when
\f1\b0 \cf3  
\f0\b \cf5 lower
\f1\b0 \cf3 (\cf4 original_price\cf3 ) 
\f0\b \cf2 in
\f1\b0 \cf3  (\cf6 'free'\cf3 ) 
\f0\b \cf2 or
\f1\b0 \cf3  
\f0\b \cf5 lower
\f1\b0 \cf3 (\cf4 original_price\cf3 ) 
\f0\b \cf2 like
\f1\b0 \cf3  \cf6 '%trial%'\cf3  
\f0\b \cf2 then
\f1\b0 \cf3  \cf7 0\cf0 \
\cf3 		
\f0\b \cf2 when
\f1\b0 \cf3  
\f0\b \cf5 lower
\f1\b0 \cf3 (\cf4 original_price\cf3 ) = \cf6 'unavailable'\cf3  
\f0\b \cf2 or
\f1\b0 \cf3  \cf4 original_price\cf3  
\f0\b \cf2 is
\f1\b0 \cf3  
\f0\b \cf2 null
\f1\b0 \cf3  
\f0\b \cf2 then
\f1\b0 \cf3  
\f0\b \cf2 null
\f1\b0 \cf0 \
\cf3 		
\f0\b \cf2 when
\f1\b0 \cf3  \cf4 original_price\cf3  
\f0\b \cf2 like
\f1\b0 \cf3  \cf6 '\'a3%'\cf3  
\f0\b \cf2 then
\f1\b0 \cf3  
\f0\b \cf5 REPLACE
\f1\b0 \cf3 (\cf4 original_price\cf3 , \cf6 '\'a3'\cf3 , \cf6 ''\cf3 )\cf0 \
\cf3 		
\f0\b \cf2 else
\f1\b0 \cf3  \cf4 original_price\cf0 \
\cf3 	
\f0\b \cf2 END
\f1\b0 \cf3  
\f0\b \cf2 as
\f1\b0 \cf3  
\f0\b \cf5 DECIMAL
\f1\b0 \cf3 (\cf7 10\cf3 ,\cf7 2\cf3 )) 
\f0\b \cf2 as
\f1\b0 \cf3  \cf4 original_price_gbp\cf3 ,\cf0 \
\cf3 	
\f0\b \cf5 cast
\f1\b0 \cf3 (
\f0\b \cf2 CASE
\f1\b0 \cf3  \cf0 \
\cf3 		
\f0\b \cf2 when
\f1\b0 \cf3  
\f0\b \cf5 lower
\f1\b0 \cf3 (\cf4 discount_price\cf3 ) 
\f0\b \cf2 in
\f1\b0 \cf3  (\cf6 'free'\cf3 ) 
\f0\b \cf2 or
\f1\b0 \cf3  
\f0\b \cf5 lower
\f1\b0 \cf3 (\cf4 discount_price\cf3 ) 
\f0\b \cf2 like
\f1\b0 \cf3  \cf6 '%trial%'\cf3  
\f0\b \cf2 then
\f1\b0 \cf3  \cf7 0\cf0 \
\cf3 		
\f0\b \cf2 when
\f1\b0 \cf3  
\f0\b \cf5 lower
\f1\b0 \cf3 (\cf4 discount_price\cf3 ) = \cf6 'unavailable'\cf3  
\f0\b \cf2 or
\f1\b0 \cf3  \cf4 discount_price\cf3  
\f0\b \cf2 is
\f1\b0 \cf3  
\f0\b \cf2 null
\f1\b0 \cf3  
\f0\b \cf2 then
\f1\b0 \cf3  
\f0\b \cf2 null
\f1\b0 \cf0 \
\cf3 		
\f0\b \cf2 when
\f1\b0 \cf3  \cf4 discount_price\cf3  
\f0\b \cf2 like
\f1\b0 \cf3  \cf6 '\'a3%'\cf3  
\f0\b \cf2 then
\f1\b0 \cf3  
\f0\b \cf5 REPLACE
\f1\b0 \cf3 (\cf4 discount_price\cf3 , \cf6 '\'a3'\cf3 , \cf6 ''\cf3 )\cf0 \
\cf3 		
\f0\b \cf2 else
\f1\b0 \cf3  \cf4 discount_price\cf0 \
\cf3 	
\f0\b \cf2 END
\f1\b0 \cf3  
\f0\b \cf2 as
\f1\b0 \cf3  
\f0\b \cf5 DECIMAL
\f1\b0 \cf3 (\cf7 10\cf3 ,\cf7 2\cf3 )) 
\f0\b \cf2 as
\f1\b0 \cf3  \cf4 discounted_price_gbp\cf3 ,\cf0 \
\cf3 	\cf4 discount\cf3 ,\cf0 \
\cf3 	\cf4 product_type\cf3 ,\cf0 \
\cf3 	\cf4 sale_name\cf3 ,\cf0 \
\cf3 	\cf4 rank_in_sale\cf3 ,\cf0 \
\cf3 	\cf5 `date`\cf3  
\f0\b \cf2 as
\f1\b0 \cf3  \cf4 date_recorded\cf0 \
\pard\pardeftab720\partightenfactor0

\f0\b \cf2 FROM
\f1\b0 \cf3  \cf4 my_db\cf3 .\cf4 playstation_store_games\cf0 \
\pard\pardeftab720\partightenfactor0
\cf3 )\cf0 \
\
\pard\pardeftab720\partightenfactor0

\f0\b \cf2 select
\f1\b0 \cf0 \
\pard\pardeftab720\partightenfactor0
\cf3 	\cf4 product_name\cf3 ,\cf0 \
\cf3 	\cf4 platform\cf3 ,\cf0 \
\cf3 	\cf4 is_available\cf3 ,\cf0 \
\cf3 	\cf4 original_price_gbp\cf3 ,\cf0 \
\cf3 	
\f0\b \cf2 case
\f1\b0 \cf3  
\f0\b \cf2 when
\f1\b0 \cf3  \cf4 discounted_price_gbp\cf3  != \cf4 original_price_gbp\cf3  
\f0\b \cf2 then
\f1\b0 \cf3  
\f0\b \cf2 True
\f1\b0 \cf3  
\f0\b \cf2 else
\f1\b0 \cf3  
\f0\b \cf2 False
\f1\b0 \cf3  
\f0\b \cf2 end
\f1\b0 \cf3  
\f0\b \cf2 as
\f1\b0 \cf3  \cf4 is_discounted\cf3 ,\cf0 \
\cf3 	
\f0\b \cf2 case
\f1\b0 \cf3  
\f0\b \cf2 when
\f1\b0 \cf3  \cf4 discounted_price_gbp\cf3  != \cf4 original_price_gbp\cf3  
\f0\b \cf2 then
\f1\b0 \cf3  \cf4 discounted_price_gbp\cf3  
\f0\b \cf2 else
\f1\b0 \cf3  
\f0\b \cf2 null
\f1\b0 \cf3  
\f0\b \cf2 end
\f1\b0 \cf3  
\f0\b \cf2 as
\f1\b0 \cf3  \cf4 discounted_price_gbp\cf3 ,\cf0 \
\cf3 	\cf4 discount\cf3  
\f0\b \cf2 as
\f1\b0 \cf3  \cf4 display_discount\cf3 ,\cf0 \
\cf3 	
\f0\b \cf2 case
\f1\b0 \cf3  
\f0\b \cf2 when
\f1\b0 \cf3  \cf4 discounted_price_gbp\cf3  != \cf4 original_price_gbp\cf3  
\f0\b \cf2 then
\f1\b0 \cf0 \
\cf3 		(\cf4 discounted_price_gbp\cf3  / \cf4 original_price_gbp\cf3 ) - \cf7 1\cf0 \
\cf3 	
\f0\b \cf2 end
\f1\b0 \cf3  
\f0\b \cf2 as
\f1\b0 \cf3  \cf4 real_discount\cf3 ,\cf0 \
\cf3 	\cf4 product_type\cf3 ,\cf0 \
\cf3 	\cf4 sale_name\cf3 ,\cf0 \
\cf3 	\cf4 rank_in_sale\cf3 ,\cf0 \
\cf3 	\cf4 date_recorded\cf0 \
\pard\pardeftab720\partightenfactor0

\f0\b \cf2 from
\f1\b0 \cf3  \cf4 base\cf0 \
}