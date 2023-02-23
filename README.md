# -Mid-Bootcamp-Project
 Build a classification model able to predict if future customers are likely to accept a credit card offer based on their characteristics.



Business Background

Position: Risk Analyst

Business: Bank

Business Services: 
Banking, Loans, Credit Cards

Business Objective:
Understanding the demographics/characteristics of customers that accept/do not accept credit cards + adjacent findings
Data Gathering Process:
The bank designed a focused marketing study, with 18,000 current bank customers.
This focused approach allows the bank to know who does and does not respond to the credit card offer, and to use existing demographic data already available on each customer.


Data Analytics Process

1. Initial Data Exploration

    The initial data exploration process involved the creation of an SQL database, followed by some basic queries to better understand the dataset.

2. Data Cleaning, Wrangling & Exploration (Pandas)

    The data cleaning & wrangling process was minimal due to the data being relatively clean to begin with. The only notable modification was the filling the null values in balances columns.
    
    
3. Exploratory Data Analysis (Pandas, Tableau)


4. Data Pre-processing & Classification Model (Scikit-Learn)

   To prepare the data for modelling, the outliers were removed from numerical columns and the numerical data scaled, whereas the categorical data was encoded so it      becomes a numerical feature for the prediction models.The models used were logistic regression, K-Nearest Neighbors (with multiple neighbor values) and Decision        trees in the presence and absence of SMOTE oversampling.
   

