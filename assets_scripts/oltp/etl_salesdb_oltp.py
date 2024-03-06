# import libraries
import numpy as np
import pandas as pd
from sqlalchemy import create_engine

# create connection to db
conn = create_engine("mysql+pymysql://{user}:{pw}@localhost:{host}/{db}"
                       .format(user = "user",
                               pw = "password",
                               host = 42333,
                               db = "salesdb_data_modelling"))

# extract data from .xlsx
file_location = r'D:\Regional-sales-data-modelling\assets_files\US_Regional_Sales_Data.xlsx'
orders = pd.read_excel(file_location, sheet_name = 0)
stores = pd.read_excel(file_location, sheet_name = 2)
products = pd.read_excel(file_location, sheet_name = 3)
employees = pd.read_excel(file_location, sheet_name = 5)
customers = pd.read_excel(file_location, sheet_name = 1)

def customers_tbl(df):
    # transform names into first_name,last_name
    df[['customer_first_name','customer_last_name']] = df['Customer Names'].str.split(' ', expand = True)
    # rename column is
    df.rename(columns={'_CustomerID':'customer_id'}, inplace = True)
    # load into sql db
    df = df[['customer_id', 'customer_first_name', 'customer_last_name']]
    df.to_sql(name = 'customer', con = conn, if_exists = 'append', index = False)
    return df

def products_tbl(df):
    # rename column is
    df.rename(columns={'_ProductID':'product_id', 'Product Name':'product_name'}, inplace = True)
    # load into sql db
    df = df[['product_id', 'product_name']]
    df.to_sql(name = 'product', con = conn, if_exists = 'append', index = False)
    return df

def employees_tbl(df, orders_dataset):
    # get unique employee id ,store id
    orders = orders_dataset[["_SalesTeamID", "_StoreID"]].drop_duplicates(subset = "_SalesTeamID")
    # rename into first name, lastname
    df[['employee_first_name', 'employee_last_name']] = df['Sales Team'].str.split(' ', expand = True)
    # add store id to employee tbl
    df = pd.merge(df, orders, on = '_SalesTeamID')
    # rename into col
    df.rename(columns={'_SalesTeamID':'employee_id', '_StoreID': 'store_id'}, inplace = True)
    # load into sql db
    df = df[['employee_id', 'employee_first_name', 'employee_last_name', 'store_id']]
    df.to_sql(name = 'employee', con = conn, if_exists = 'append', index = False)
    return df

def sales_channel_tbl(df):
    # unique sales channel
    df = df[["Sales Channel"]].drop_duplicates(subset = "Sales Channel")
    # add sales channel id
    df['sales_channel_id'] = np.arange(0, 0 + len(df)) + 1
    # rename col
    df.rename(columns={'Sales Channel':'sales_channel_name'}, inplace = True)
    # load into sql db
    df.to_sql(name = 'sales_channel', con = conn, if_exists = 'append', index = False)
    return df

def orders_tbl(df):
    sales_channels = sales_channel_tbl(orders)
    # rename col
    df = pd.merge(df, sales_channels, left_on = 'Sales Channel', right_on = 'sales_channel_name' )    
    # rename col
    df.rename(columns={'OrderNumber':'order_num', 
                       'Order Quantity':'order_quantity',
                       'OrderDate':'order_date',
                       'CurrencyCode':'currency_code',
                       'ShipDate':'ship_date',
                       'DeliveryDate':'delivery_date',
                       'TotalCost':'total_cost',
                       'TotalPrice':'total_price',
                       'ProcuredDate':'procure_date',
                       'Discount Applied':'discount_applied', 
                       '_SalesTeamID':'employee_id',
                       '_CustomerID':'customer_id', 
                       '_ProductID':'product_id'
                       }, inplace = True)
    # load into db
    df = df[['order_num', 
             'order_date', 
             'currency_code', 
             'order_quantity', 
             'discount_applied', 
             'ship_date',
             'delivery_date', 
             'procure_date', 
             'total_cost', 
             'total_price', 
             'employee_id',
             'customer_id', 
             'sales_channel_id', 
             'product_id']]
    df.to_sql(name = 'sales_order', con = conn, if_exists = 'append', index = False)
    return df

def states_tbl(df):
    df = df[["State", "StateCode", "AreaCode"]].drop_duplicates(subset = "State")
    # rename cols
    df.rename(columns={'State':'state', 'StateCode':'state_code', 'AreaCode':'area_code'}, inplace = True)
    # generate state id
    df['state_id'] = np.arange(0, 0 + len(df)) + 1
    #save to database
    df.to_sql(name = 'state', con = conn, if_exists = 'append', index = False)
    return df

def cities_tbl(df):
    df = df[["City Name", "State", "Type"]].drop_duplicates(subset = "City Name")
    # generate city id
    df['city_id'] = np.arange(0, 0 + len(df)) + 1
    # get state id s
    states = states_tbl(stores)
    # final tbl
    df = pd.merge(df, states,  left_on='State', right_on='state')
    # rename col
    df.rename(columns={'City Name':'city_name', 'Type':'type'}, inplace = True)
    # save to db
    df = df[['city_id', 'city_name', 'type', 'state_id']]
    df.to_sql(name = 'city', con = conn, if_exists = 'append', index = False)
    return df

def stores_tbl(df):
    cities = cities_tbl(stores)
    # merge tbl s
    df = pd.merge(df, cities, left_on = 'City Name', right_on = 'city_name')
    # rename col s
    df.rename(columns={'_StoreID':'store_id', 'County':'location', 'Latitude':'latitude', 'Longitude':'longitude'}, inplace = True)
    # save to db
    df = df[['store_id', 'latitude', 'longitude', 'location', 'city_id']]
    df.to_sql(name = 'store', con = conn, if_exists = 'append', index = False)
    return df

def main():
    customers_tbl(customers)
    products_tbl(products)
    stores_tbl(stores)
    employees_tbl(employees, orders)    
    orders_tbl(orders)


main()