import mysql.connector as msql
from mysql.connector import Error
import pandas as pd
import os

# For security ask user for password rather than hard code
password = input("Enter password:")

# Attempt to connect to MySQL database: my_db
try:
    conn = msql.connect(host='localhost', 
                        database='my_db', 
                        user='root', 
                        password=password)
    if conn.is_connected():
        cursor = conn.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)

        # Create data frame from files in 'Output'
        directory = '/Users/caiparry-jones/Documents/Technical_Development/Projects/Python/PlayStation_SEO/Output/'

        for file in os.listdir(directory):         
            filename = os.fsdecode(file)         
            if filename.endswith('.csv'):             
                # print(os.path.join(directory, filename))
                csv_file = os.path.join(directory, filename)  
                empdata = pd.read_csv(csv_file, index_col=False, delimiter = ',')
                empdata.head()

                # Loop through and insert each row into the MySQL database
                for i,row in empdata.iterrows():
                    sql = 'INSERT INTO playstation_store_games(name, platforms, original_price, discount_price, discount, product_type, rank_in_sale, sale_name, date )' 'VALUES("%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s")'
                    cursor.execute(sql, tuple(row))
                    print("Record inserted")
                    # the connection is not auto committed by default, so we must commit to save our changes
                    conn.commit()         
                
                # Move csv file that has been successfully loaded from 'Output' folder into 'Output_loaded' folder
                import shutil
                original = csv_file
                target = r'/Users/caiparry-jones/Documents/Technical_Development/Projects/Python/PlayStation_SEO/Output_loaded/' + filename
                shutil.move(original, target)
                
                continue         
            else:             
                continue



# 'Error' is part of mysql.connector package, very handy for debugging database issues
except Error as e:
            print("Error while connecting to MySQL", e)

