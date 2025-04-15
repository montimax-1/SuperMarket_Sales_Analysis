
create database SuperMarket_Sales

use SuperMarket_Sales

Select * from supermarket_sales

-- Checking for duplicate entries and ensuring data consistency.--

SELECT distinct * from supermarket_sales

--Query to count transactions by customer type.--

SELECT Customer_type, COUNT(*) As No_of_Transaction
FROM supermarket_sales
GROUP BY customer_type;
 


--Analyze average spending per customer type.--

SELECT Customer_type, AVG(total) As Average_Spending
FROM supermarket_sales
GROUP BY  Customer_type;

--SQL query to determine sales performance over time--

--Sales by Month

SELECT 
    DATEPART(YEAR, date) AS sale_year,
    DATEPART(MONTH, date) AS sale_month,
    SUM(Unit_Price) AS total_sales
FROM 
    supermarket_sales
GROUP BY 
    DATEPART(YEAR, date),
    DATEPART(MONTH, date)
ORDER BY 
    sale_year, sale_month;


--If You want to display by Day


SELECT 
    CAST(date AS DATE) AS sale_day,
    SUM(Unit_Price) AS total_sales
FROM 
    supermarket_sales
GROUP BY 
    CAST(date AS DATE)
ORDER BY 
    sale_day;




--Merge date and time column in One column--
SELECT 
    CAST(date AS DATETIME) + CAST(time AS DATETIME) AS sale_datetime
FROM supermarket_sales;


--


Select distinct * from supermarket_sales



--	Query to rank product lines by total revenue --


SELECT product_line,
    SUM(total) AS total_revenue,
    RANK() OVER (ORDER BY SUM(Total) DESC) AS revenue_rank
FROM 
    supermarket_sales
GROUP BY 
    product_line;


--Compute average quantity sold per product category.--

SELECT product_line,
    AVG(Quantity) AS Avg_Quantity
FROM 
    supermarket_sales
GROUP BY 
    product_line;


--Query to determine the most preferred payment methods--

SELECT Payment,
    COUNT(*) AS Most_Pref
FROM 
    supermarket_sales
GROUP BY 
    Payment
ORDER BY 
    Most_Pref DESC;



--Evaluate the correlation between payment methods and customer satisfaction--

SELECT Payment,
    COUNT(*) AS total_responses,
    AVG(Rating) AS avg_satisfaction
FROM 
    supermarket_sales
GROUP BY 
    Payment
ORDER BY 
    avg_satisfaction DESC;



--Query to compare sales revenue across branches and cities.--

SELECT 
    city,
    branch,
    SUM(Total) AS total_revenue
FROM 
    supermarket_sales
GROUP BY 
    city, branch
ORDER BY 
    city, total_revenue Asc;


--Query to determine whether members or normal customers contribute more to revenue.--

SELECT 
    customer_type,
    COUNT(*) AS total_transactions,
    SUM(Total) AS total_revenue,
    AVG(Total) AS avg_revenue_per_transaction
FROM 
    supermarket_sales
GROUP BY 
    customer_type
ORDER BY 
    total_revenue DESC;



--SQL query to compute the highest profit margins by product category.--

SELECT 
    product_line,
    ROUND(AVG((Total - Tax_5) / NULLIF(Total, 0)) * 100, 2) AS avg_profit
FROM 
    supermarket_sales
GROUP BY 
    product_line
ORDER BY 
    avg_profit DESC;


--Calculate total gross income and gross margin percentages using SQL.--

SELECT 
    SUM(Total - Tax_5) AS total_gross_income,
    ROUND((SUM(Total - Tax_5) / NULLIF(SUM(Total), 0)) * 100, 2) AS gross_margin_percentage
FROM 
    supermarket_sales;


--Analyze customer ratings by product line and store branch.--

SELECT 
    Branch,
    Product_line,
    Sum(Rating) AS Total_rating
FROM 
    supermarket_sales
GROUP BY 
   Branch,
   Product_line
ORDER BY 
    Branch, Total_rating Asc;


--Identify factors influencing higher customer satisfaction scores.--

SELECT 
    customer_type,
    COUNT(*) AS responses,
    ROUND(AVG(Rating), 2) AS avg_satisfaction
FROM 
    supermarket_sales
GROUP BY 
    customer_type
ORDER BY 
    avg_satisfaction DESC;