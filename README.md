# salesdb_data_modelling

## Contents
1. [Setup tools](#Setup-tools)
2. [create Database](#create-Database)
3. [EER diagram](#EER-diagram)
4. [Data source](#Data-source)
5. [Create Venv](#Create-Venv)
6. [Installing libraries](#Installing-libraries)
7. [ETL process](#ETL-process)
8. [Conclusion](#Conclusion)

## Setup tools
**mysqlworkbench**<br>
**mysql server**<br>
**python**

*mysql server can be installed from docker:*<br>
```
docker pull mysql
```

## create Database
create the database **"salesdb-data-modelling"**, this is done with [docker-compose.yml]([assets_scripts/docker-compose.yml](https://github.com/KOMPALALOKESH/salesdb_data_modelling/blob/main/assets_scripts/docker-compose.yml)) file:<br>
```
assets_scripts\docker-compose.yml>docker-compose up -d
```

## EER diagram
The EER diagram is built with the following entities:<br>
1. Sales_order
2. customer
3. employee
4. product
5. sales_channel
6. store
7. city
8. state

<br>
The relation between these entities isattaine by foreign keys:<br>

* foreign keys of sales_order:
    * fk_sales_order_employee
    * fk_sales_order_product
    * fk_sales_order_customer
    * fk_sales_order_sales_channel
* foreign keys of employee:
    * fk_employee_store
* foreign keys of store:
    * fk_store_city
* foreign keys of city:
    * fk_city_state

The final ouput of the schema is
<div style="text-align: center;">
    <img src="assets_files\erd.png" alt="erd.png">
</div>

*forward engineering the design of schema creates tables and attributes in db*

## Data source
After the schema design, the raw is available in [US_Regional_Sales_Data.xlsx]([assets_files/US_Regional_Sales_Data.xlsx](https://github.com/KOMPALALOKESH/salesdb_data_modelling/blob/main/assets_files/US_Regional_Sales_Data.xlsx))

Sample view of all sheets in above .xlsx data:<br>
Customers Sheet
<div style="text-align: center;">
    <img src="assets_files\Customers Sheet.png" alt="erd.png">
</div>

Products Sheet
<div style="text-align: center;">
    <img src="assets_files\Products Sheet.png" alt="erd.png">
</div>

Regions Sheet
<div style="text-align: center;">
    <img src="assets_files\Regions Sheet.png" alt="erd.png">
</div>

Sales Orders Sheet
<div style="text-align: center;">
    <img src="assets_files\Sales Orders Sheet.png" alt="erd.png">
</div>

Sales Team Sheet
<div style="text-align: center;">
    <img src="assets_files\Sales Team Sheet.png" alt="erd.png">
</div>

Store Locations Sheet
<div style="text-align: center;">
    <img src="assets_files\Store Locations Sheet.png" alt="erd.png">
</div>


## Create Venv
For working with the raw data, create a virtual environment
```
py -m venv env
env/Scripts/activate
```

## Installing libraries
After creating the venv install all libraries in [requirements.txt]([requirements.txt](https://github.com/KOMPALALOKESH/salesdb_data_modelling/blob/main/requirements.txt)) file:
```
pip install -r requirements.txt
```
requirements.txt file:
* SQLAlchemy
* numpy
* pandas
* pymysql
* openpyxl
* cryptography
* mysql-connector-python
* mysqlclient

## ETL process
1. Extracting the raw data into the python workspace to work with it.
2. Transform the raw data converting it into pandas dataframe.
3. Load the results of data modelling into the database with mysql connector.

## Conclusion
The results of the data modelling is thus loaded into the db and the sample result of this is follows with a sql query:<br>

```
show tables;
```
output:
<div style="text-align: center;">
    <img src="assets_files\sample_output.png" alt="erd.png">
</div>
