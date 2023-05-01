# streamlit_app.py

import streamlit as st

# Initialize connection.
conn = st.experimental_connection('mysql', type='sql')

# Perform query.
df = conn.query('SELECT * from clean_playstation_data;', ttl=600)

# Print results.
for row in df.itertuples():
    st.write(f"{row.product_name}")
