# US Regional sales data modelling

## Contents
1. [Setup tools](#installing-dependencies)
2. [create database](#create-salesdb_data_modelling-database)
3. [EER diagram](#eerentity-entity-relation-diagram)
4. [Data source](#data-source)
5. [Installing python lib's](#installing-python-libraries)
6. [ETL process](#etl-process)
7. [Conclusion](#conclusion)


## Installing dependencies

**mysql workbench**<br>
**python > 3.10**<br>
**mysql server**<br>
<br>
*mysql server installed from docker:*<br>
```
docker pull mysql
```

## Create "salesdb_data_modelling" database
create database with the [docker-compose.yml](assets_scripts\docker-compose.yml) file:
```
docker-compose up -d
```

## EER(entity-entity-relation) diagram
ER diagram with entities:<br>
* sales_orders
* employees
* customers
* sales_channel
* product
* store
* city
* state
<br>

The relationsip between this entities are done with the foreign keys:<br>
* sales_order --> employee entity relation:
    * fk_sales_order_employee
    * fk_sales_order_product
    * fk_sales_order_customer
    * fk_sales_order_sales_channel
* employee --> store entity relation:
    * fk_employee_store
* store --> city entity relation:
    * fk_store_city
* city --> state entity relation:
    * fk_city_state
<br>


The EER diagram looks like as follows:<br>
<div style="text-align:center;">
  <img src="assets_files\erd.png" alt="Your Image Description">
</div><br>

*Forward engineering this schema creates a* **salesdb_data_modelling** *database.*

## Grant permissions
*In some-cases mysql throw error when connecting with db or modelling data, better to Grant all privileges to user in mysql*
```
GRANT ALL PRIVILEGES ON salesdb_data_modelling.* TO 'user'@'%';
FLUSH PRIVILEGES;
```

## Data source
Data for this project is [US_Regional_Sales_Data.xlsx](assets_files\US_Regional_Sales_Data.xlsx)<br>
The all sheet samples of the data are shown as:<br>

Sales Orders Sheet:
<div style="text-align:center;">
  <img src="assets_files\Sales Orders Sheet.png" alt="Sales Orders Sheet">
</div><br>
Customers Sheet:
<div style="text-align:center;">
  <img src="assets_files\Customers Sheet.png" alt="Customers Sheet">
</div><br>
Store Locations Sheet:
<div style="text-align:center;">
  <img src="assets_files\Store Locations Sheet.png" alt="Store Locations Sheet">
</div><br>
Products Sheet:
<div style="text-align:center;">
  <img src="assets_files\Products Sheet.png" alt="Products Sheet">
</div><br>
Regions Sheet:
<div style="text-align:center;">
  <img src="assets_files\Regions Sheet.png" alt="Regions Sheet">
</div><br>
Sales Team Sheet:
<div style="text-align:center;">
  <img src="assets_files\Sales Team Sheet.png" alt="Sales Team Sheet">
</div><br>

## Creating a Venv
create a virtual environment to install all libraries.
```
python -m venv env

env\Scripts\activate
```

## Installing python libraries:
```
pip install -r requirements.txt
```
[requirements.txt]() file:
* SQLAlchemy
* numpy
* pandas
* pymysql
* openpyxl
* cryptography
* mysql-connector-python
* mysqlclient

## ETL Process
1. Extracting the raw data from the all sheets of the data.
2. Transforming the all sheets of data into the dataframes and process the data as per schema.
3. Load the data into the respective tables of database by connecting with "SQLAlchemy create engine".

## Conclusion
The raw data from data source is loaded into the database after the etl process.
The sample output of result is shown as with following query:
```
show tables;
```
<div style="text-align:center;">
  <img src="assets_files\sample_output.png" alt="sample output">
</div><br>


