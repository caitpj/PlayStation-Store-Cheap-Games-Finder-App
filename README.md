# PlayStation Store Cheap Games Finder App

## Overview

script extracts game data from PlayStation store, loads into a database, and presents a Streamlit app of a list of games at cheapests price recorded in the database. This helps buyers figure out if the games are a good deal or not.

<img width="1440" alt="App Screenshot" src="https://user-images.githubusercontent.com/97813242/235610959-553f7ee9-e6a5-4ce2-bd43-f9deaf1aa304.png">

Link to video tour: https://youtu.be/HsXHuOQ5wmA

## ET_script.py

This file extracts data from the PlayStation Store. It uses BeautifulSoup package to extract key information for API URLs. Then makes API calls to the correct product collections. There is a limit of 1,000 products per API call, so there is logic to fetch remaining products i.e. product 1,001+ of collection. Data extracted in JSON format. It then does some simple transformations to clean the data and saves into the 'Output' folder as csv files.

## L_script.py

This file loads the data from the csv files in the 'Output' folder into localhost MySQL database. Once loaded into the database it moves the csv files into a folder called 'Output_loaded', this is so I don't lose any data if the database fails.

## clean_playstation_data.sql

This file creates a view that does further transformations of the data in MySQL database. Mostly cleaning the data, for example, trimming the start and end quotes from each field.

## cheap_today.sql

This file creates another view, that presents today's cheap PlayStation games. This is the view that will be presented in the Streamlit app.

## streamlit_app.py

Simple file that creates a Streamlit app, which presents the data in cheap_today.sql.

## Further Improvements

Orchestrate ET_script.py and L_script.py to run after eachother every day. 


