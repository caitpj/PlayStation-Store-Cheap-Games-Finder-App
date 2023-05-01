# streamlit_app.py

import streamlit as st

# Initialize connection.
conn = st.experimental_connection('mysql', type='sql')

# Perform query.
df = conn.query('SELECT distinct product_name from clean_playstation_data limit 100;', ttl=600)

# Print results.
for row in df.itertuples():
    st.write(f"{row.product_name}")
