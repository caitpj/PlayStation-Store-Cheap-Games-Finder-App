# ETL Project - PlayStation Store

I extract all Playstation Store products from the UK's [PlayStation Store](https://store.playstation.com/en-gb/pages/latest) and store in a relational database. This data includes:
- Product name
- Platform (PS4 or PS5)
- Product type
- Sale name
- Original price (gbp)
- Discounted price (gbp)
- Product rank in sale
- Date seen on store

## Extract

In order to extract the data with Python I use: 
- BeautifulSoup to extract key information for API URLs
- Make a API calls to the correct product collections
- There is a limit of 1,000 products per API call, so I create logic to fetch remaining products i.e. product 1,001+ of collection
- Data extracted in JSON format

## Transform

- Transform desired data from JSON into a structured Pandas dataframe
- Few extra tweaks with Pandas, such as including date, and exploding platform list
- Created a view in mySQL using SQL for further transfomations e.g. changing prices from strings to numbers

## Load
- Export datafrem from Python into CSVs
- Load data into a mySQL table
- I used Apache NiFi to automate runing python script and loading into database

