-- grant all permissions to user
GRANT ALL PRIVILEGES ON salesdb_data_modelling.* TO 'user'@'%';
FLUSH PRIVILEGES;

show tables;

-- sample test for correct loading 
select count(*) from sales_order;
-- result count(*) 7991 

commit;