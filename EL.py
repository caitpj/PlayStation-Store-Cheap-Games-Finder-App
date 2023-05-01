#!/usr/bin/env python
# coding: utf-8


import requests
import json
import pandas as pd
import bs4
import os
import numpy as np

os.makedirs('/Users/caiparry-jones/Documents/Technical_Development/Python/PlayStation_SEO', exist_ok=True)

df = pd.DataFrame(columns=['name',
                           'platforms',
                           'original_price',
                           'discount_price',
                           'discount',
                          'product_type',
                          'rank_in_sale',
                          'sale_name',
                          'date'])

# list of urls to check for sale_ids
request_urls = ['https://store.playstation.com/en-gb/pages/deals',
               'https://store.playstation.com/en-gb/pages/latest',
               'https://store.playstation.com/en-gb/pages/collections',
               'https://store.playstation.com/en-gb/pages/ps5']

# check all request_urls for sale_ids
for request_url in request_urls:
    response = requests.get(request_url)
    html_text = response.text
    soup = bs4.BeautifulSoup(html_text, 'lxml')
    sales = soup.find_all('li', class_ = 'psw-l-w-1/2@mobile-s psw-l-w-1/2@mobile-l psw-l-w-1/3@tablet-s psw-l-w-1/3@tablet-l psw-l-w-1/4@laptop psw-l-w-1/4@desktop psw-l-w-1/4@max')
    sale_ids = []

    for sale in sales:
        sale_url = sale.find('a', class_ = 'psw-link psw-content-link')['href']
        sale_id = sale_url.split('/')[3]
        sale_ids.append(sale_id)

# remove duplicates from sale_ids
sale_ids = list(dict.fromkeys(sale_ids))

# for each sale_id fetch the json api
for sale_id in sale_ids:
    response = requests.get('https://web.np.playstation.com/api/graphql/v1//op?operationName=categoryGridRetrieve&variables=%7B%22id%22%3A%22'
                        + sale_id
                        + '%22%2C%22pageArgs%22%3A%7B%22size%22%3A1000%2C%22offset%22%3A0%7D%2C%22sortBy%22%3Anull%2C%22filterBy%22%3A%5B%5D%2C%22facetOptions%22%3A%5B%5D%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%224ce7d410a4db2c8b635a48c1dcec375906ff63b19dadd87e073f8fd0c0481d35%22%7D%7D')

    psdata = response.json()

# some json apis will come back with an error, this filters them out
    if 'errors' in psdata:
        continue

    else:
        products = psdata['data']['categoryGridRetrieve']['products']

        for i in range (0, len(products)):
            currentItem = products[i]
            df.loc[i] = [currentItem['name'],
                         currentItem['platforms'],
                         currentItem['price']['basePrice'],
                         currentItem['price']['discountedPrice'],
                         currentItem['price']['discountText'],
                         currentItem['storeDisplayClassification'],
                         i+1,
                         psdata['data']['categoryGridRetrieve']['reportingName'],
                         pd.to_datetime('today',utc=True).normalize()
                         ]

# Create a row for each value in the ;platforms' list
        df = df.explode('platforms')

# turn datetime to date
        df['date'] = pd.to_datetime(df['date']).dt.date

# create csv
        if os.path.exists('Output/first_PSSEO_'+ sale_id + '_' + str(pd.to_datetime('today', utc=True)).split(' ')[0] + '.csv'):
            os.remove('Output/first_PSSEO_'+ sale_id + '_' + str(pd.to_datetime('today', utc=True)).split(' ')[0] + '.csv')
            df.to_csv('Output/first_PSSEO_'+ sale_id + '_' + str(pd.to_datetime('today', utc=True)).split(' ')[0] + '.csv', index=False)
        else:
            df.to_csv('Output/first_PSSEO_'+ sale_id + '_' + str(pd.to_datetime('today', utc=True)).split(' ')[0] + '.csv', index=False)
        df = df[0:0]

# there is a 1000 product limit on json api, this checks if all products were consumed in first 1000 batch
        while True:
            if psdata['data']['categoryGridRetrieve']['pageInfo']['size'] + psdata['data']['categoryGridRetrieve']['pageInfo']['offset'] > psdata['data']['categoryGridRetrieve']['pageInfo']['totalCount']:
                break
                continue
            else:
                response = requests.get('https://web.np.playstation.com/api/graphql/v1//op?operationName=categoryGridRetrieve&variables=%7B%22id%22%3A%22'
                            + sale_id
                            + '%22%2C%22pageArgs%22%3A%7B%22size%22%3A1000%2C%22offset%22%3A'
                            + str(psdata['data']['categoryGridRetrieve']['pageInfo']['size'] + psdata['data']['categoryGridRetrieve']['pageInfo']['offset'])
                            + '%7D%2C%22sortBy%22%3Anull%2C%22filterBy%22%3A%5B%5D%2C%22facetOptions%22%3A%5B%5D%7D&extensions=%7B%22persistedQuery%22%3A%7B%22version%22%3A1%2C%22sha256Hash%22%3A%224ce7d410a4db2c8b635a48c1dcec375906ff63b19dadd87e073f8fd0c0481d35%22%7D%7D')

                psdata = response.json()

                products = psdata['data']['categoryGridRetrieve']['products']

                for i in range (0, len(products)):
                    currentItem = products[i]
                    df.loc[i] = [currentItem['name'],
                                 currentItem['platforms'],
                                 currentItem['price']['basePrice'],
                                 currentItem['price']['discountedPrice'],
                                 currentItem['price']['discountText'],
                                 currentItem['storeDisplayClassification'],
                                 psdata['data']['categoryGridRetrieve']['pageInfo']['offset'] + i+1,
                                 psdata['data']['categoryGridRetrieve']['reportingName'],
                                 pd.to_datetime('today',utc=True).normalize()
                                 ]

# Create a row for each value in the ;platforms' list
                df = df.explode('platforms')

# turn datetime to date
                df['date'] = df['date'].dt.date

# create csv
                if os.path.exists('Output/first_PSSEO_'+ sale_id + '_' + str(pd.to_datetime('today', utc=True)).split(' ')[0] + '_' + str(psdata['data']['categoryGridRetrieve']['pageInfo']['offset']) + '.csv'):
                    os.remove('Output/first_PSSEO_'+ sale_id + '_' + str(pd.to_datetime('today', utc=True)).split(' ')[0] + '_' + str(psdata['data']['categoryGridRetrieve']['pageInfo']['offset']) + '.csv')
                    df.to_csv('Output/first_PSSEO_'+ sale_id + '_' + str(pd.to_datetime('today', utc=True)).split(' ')[0] + '_' + str(psdata['data']['categoryGridRetrieve']['pageInfo']['offset']) + '.csv', index=False)
                else:
                    df.to_csv('Output/first_PSSEO_'+ sale_id + '_' + str(pd.to_datetime('today', utc=True)).split(' ')[0] + '_' + str(psdata['data']['categoryGridRetrieve']['pageInfo']['offset']) + '.csv', index=False)
                df = df[0:0]
