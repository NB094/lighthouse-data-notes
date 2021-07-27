/* SQL Exercise
====================================================================
We will be working with database northwind.db we have set up and connected to in the activity Connect to Remote PostgreSQL Database earlier.


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE 





--==================================================================  */
/* TASK I
-- Q1. Write a query to get Product name and quantity/unit.
*/
SELECT Products.ProductName, Products.QuantityPerUnit FROM Products;

/* TASK II
Q2. Write a query to get most expense and least expensive Product list (name and unit price)
*/
SELECT Products.ProductName, Products.unitprice FROM Products
  ORDER BY Products.unitprice DESC;


/* TASK III
Q3. Write a query to count current and discontinued products.
*/
SELECT COUNT(*),
  CASE
    WHEN products.discontinued = 0 THEN 'current'
    ELSE 'discontinued'
  END AS "product status"
FROM products
GROUP BY products.discontinued;


/* TASK IV
Q4. Select all product names and their category names (77 rows)
*/
SELECT Products.ProductName, categories.categoryname FROM products
  JOIN categories
  ON products.categoryid = categories.categoryid;

/* TASK V
Q5. Select all product names, unit price and the supplier region 
that don't have suppliers from USA region. (26 rows)
*/
SELECT suppliers.country, COUNT(suppliers.country) FROM suppliers
  GROUP BY suppliers.country;

SELECT * FROM products;

SELECT DISTINCT products.productname, products.unitprice, suppliers.region FROM products
  JOIN suppliers
  ON products.supplierid = suppliers.supplierid
  WHERE suppliers.country != 'USA';

/* TASK VI
Q6. Get the total quantity of orders sold.( 51317)
*/
SELECT SUM(order_details.quantity) as "Orders Sold" FROM order_details;

/* TASK VII
Q7. Get the total quantity of orders sold for each order.(830 rows)
*/
SELECT orders.orderid, COUNT(orders.orderid) as "Orders Sold" FROM orders
  JOIN order_details
  ON orders.orderid = order_details.orderid
  GROUP BY orders.orderid;

/* TASK VIII
Q8. Get the number of employees who have been working more than 5 years in the company. (9 rows)
*/
SELECT * FROM employees;

SELECT extract(YEAR FROM employees.hiredate) FROM employees;

SELECT COUNT(employees.employeeid) FROM employees
  WHERE extract(YEAR FROM age('1998-10-19'::date, employees.hiredate)) >= 5;

