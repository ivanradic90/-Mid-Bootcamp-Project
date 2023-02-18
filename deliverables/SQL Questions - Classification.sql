# 1. Create a database called credit_card_classification.
create database if not exists credit_card_classification;


# 2.  Create a table credit_card_data with the same columns as given in the csv file. You can find the names of the headers for the table in the creditcardmarketing.xlsx file. Use the same column names as the names in the excel file. Please make sure you use the correct data types for each of the columns.

use credit_card_classification;
drop table if exists credit_card_data;

CREATE TABLE credit_card_data (
  `customer_number` int(11) UNIQUE NOT NULL,
  `offer_Accepted` varchar(4) DEFAULT NULL,
  `reward` varchar(20) DEFAULT NULL,
  `mailer_type` varchar(20) DEFAULT NULL,
  `income_level` varchar(20) DEFAULT NULL,
  `number_bank_accounts_open` int(5) DEFAULT NULL,
  `overdraft_protection` varchar(11) DEFAULT NULL,
  `credit_rating` varchar(11) DEFAULT NULL,
  `credit_cards_held` int(11) DEFAULT NULL,
  `homes_owned` int(11) DEFAULT NULL,
  `household_size` int(11) DEFAULT NULL,
  `own_your_home` varchar(4) DEFAULT NULL,
  `average_balance` float DEFAULT NULL,
  `q1_balance` int(11) DEFAULT NULL,
  `q2_balance` int(11) DEFAULT NULL,
  `q3_balance` int(11) DEFAULT NULL,
  `q4_balance` int(11) DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (`customer_number`)
);

# 3. Import the data from the csv file into the table. Before you import the data into the empty table, make sure that you have deleted the headers from the csv file. (in this case we have already deleted the header names from the csv files). To not modify the original data, if you want you can create a copy of the csv file as well. Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

load data local infile 'C:/Users/ivanr/Downloads/mid-bootcamp-project-details/classification/creditcardmarketing.csv'
into table credit_card_data
fields terminated BY ',';





# 4. Select all the data from table credit_card_data to check if the data was imported correctly.
select * from credit_card_data;



#5. Use the alter table command to drop the column q4_balance from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.

ALTER TABLE credit_card_data
drop column q4_balance;

select * from credit_card_data
limit 10;

# 6.Use sql query to find how many rows of data you have.

select count(*) from credit_card_data;

# 7. Now we will try to find the unique values in some of the categorical columns:

#What are the unique values in the column Offer_accepted?

select distinct offer_accepted from credit_card_data;

#What are the unique values in the column Reward?

select distinct reward from credit_card_data;

#What are the unique values in the column mailer_type?

select distinct mailer_type from credit_card_data;

#What are the unique values in the column credit_cards_held?

select distinct credit_cards_held from credit_card_data;

#What are the unique values in the column household_size?

select distinct household_size from credit_card_data;

# 8. Arrange the data in a decreasing order by the average_balance of the house. Return only the customer_number of the top 10 customers with the highest average_balances in your data.

select customer_number from credit_card_data
order by average_balance desc
limit 10;

# 9. What is the average balance of all the customers in your data?

select avg(average_balance) from credit_card_data;

# 10. n this exercise we will use group by to check the properties of some of the categorical variables in our data. Note wherever average_balance is asked in the questions below, please take the average of the column average_balance:

#What is the average balance of the customers grouped by Income Level? The returned result should have only two columns, income level and Average balance of the customers. Use an alias to change the name of the second column.
 
 select income_level, avg(average_balance) as average_balance from credit_card_data
 group by 1;
 
#What is the average balance of the customers grouped by number_of_bank_accounts_open? The returned result should have only two columns, number_of_bank_accounts_open and Average balance of the customers. Use an alias to change the name of the second column.

select number_bank_accounts_open, avg(average_balance) as average_balance from credit_card_data
group by 1;


#What is the average number of credit cards held by customers for each of the credit card ratings? The returned result should have only two columns, rating and average number of credit cards held. Use an alias to change the name of the second column.

select credit_rating, round(avg(credit_cards_held)) as average_cards
from credit_card_data
group by 1;

#Is there any correlation between the columns credit_cards_held and number_of_bank_accounts_open? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables. You might also have to check the number of customers in each category (ie number of credit cards held) to assess if that category is well represented in the dataset to include it in your analysis. For eg. If the category is under-represented as compared to other categories, ignore that category in this analysis

select credit_cards_held, round(avg(number_bank_accounts_open)) as average_accounts
from credit_card_data
group by 1
order by 1;

# apparently there is no correlation since average amount of accounts doesnt change when the amount of cards change


# 11. Your managers are only interested in the customers with the following properties:

#Credit rating medium or high
#Credit cards held 2 or less
#Owns their own home
#Household size 3 or more
#For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them? Can you filter the customers who accepted the offers here?

select customer_number from credit_card_data
where credit_rating in ('High', 'Medium') and
credit_cards_held <= 2 and
own_your_home = 'Yes' and
household_size >= 3;

select customer_number, reward from credit_card_data
where credit_rating in ('High', 'Medium') and
credit_cards_held <= 2 and
own_your_home = 'Yes' and
household_size >= 3;

select customer_number,reward from credit_card_data
where credit_rating in ('High', 'Medium') and
credit_cards_held <= 2 and
own_your_home = 'Yes' and
household_size >= 3
and offer_accepted = 'Yes';

# 12. Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database. Write a query to show them the list of such customers. You might need to use a subquery for this problem.

select customer_number from credit_card_data
where average_balance > (
select avg(average_balance) from credit_card_data)
;

# 13. Since this is something that the senior management is regularly interested in, create a view called Customers__Balance_View1 of the same query.

create view Customers__Balance_View1 AS
select customer_number from credit_card_data
where average_balance < (select avg(average_balance) from credit_card_data);

# 14. What is the number of people who accepted the offer vs number of people who did not?

select offer_accepted, count(*) from credit_card_data
group by 1;

# 15. Your managers are more interested in customers with a credit rating of high or medium. What is the difference in average balances of the customers with high credit card rating and low credit card rating?

select   credit_rating, round(avg(average_balance)) as average_balance from credit_card_data
where credit_rating in ('High', 'Low')
group by 1;

# 16. In the database, which all types of communication (mailer_type) were used and with how many customers?

select distinct mailer_type, count(*) as number_of_customers from credit_card_data
group by 1;

# 17. Provide the details of the customer that is the 11th least Q1_balance in your database.

select customer_number from 
(select  customer_number, q1_balance from credit_card_data
order by 2 asc
limit 11)sq1
order by 
q1_balance desc
limit 1;


