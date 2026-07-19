-- Query 1
-- Products whose selling price is above overall average
select Name,`Selling Price`
from master_flipkart
where `Selling Price`> (
select avg(`Selling Price`)
from master_flipkart);

-- Query 2
-- Find the Top 5 Brands offering the highest average discount.
select Brand, avg(discount) as avg_discount
from master_flipkart 
group by brand
order by avg_discount DESC
limit 5;

-- Query 3
-- Find all brands that have 20 or more products.
select count(name) as Total_product, brand
from master_flipkart 
group by brand
having Total_product >= 20
order by Total_product desc;

-- Query 4
-- Find all brands whose average rating is above the overall average rating.
select brand, avg(ratings) as brand_ratings
from master_flipkart
group by brand
having brand_ratings > (select avg(ratings)
from master_flipkart)
order by brand_ratings desc;

-- Query 5
-- Find the products whose rating is higher than the average rating of their own brand.
SELECT
    m1.Name,
    m1.Brand,
    m1.Ratings
FROM master_flipkart m1
WHERE m1.Ratings >
(
    SELECT AVG(m2.Ratings)
    FROM master_flipkart m2
    WHERE m2.Brand = m1.Brand
);

-- Query 6
-- Find the Top 10 most reviewed products on Flipkart.
select name, no_of_reviews
from master_flipkart
order by no_of_reviews desc
limit 20;

-- Query 7
-- Find the top 5 most expensive products in each category.
SELECT Category,
       Name,
       `Selling Price`
FROM
(
    SELECT Category,
           Name,
           `Selling Price`,
           ROW_NUMBER() OVER (
               PARTITION BY Category
               ORDER BY `Selling Price` DESC
           ) AS rn
    FROM master_flipkart
) AS ranked_products
WHERE rn <= 5
ORDER BY Category, `Selling Price` DESC;

-- Query 8
-- ind premium products with Rating ≥ 4.5 and Discount ≥ 10%.
with premium_products as
(
    select*
    from master_flipkart
    where ratings >= 4.5
     and discount >= 0.10
)
select
     Name,
     Brand,
     `Selling Price`,
     ratings
from premium_products;

-- Query 9
-- Find the total count and average selling price of expensive products.
with Expensive_products as
(
    select *
    from master_flipkart 
    where `selling price` > 50000
)
select
    count(name),
    avg(`selling price`)
from Expensive_products

-- Query 10
-- Find the number of top-rated products for each brand.
with top_rated as(
select *
from master_flipkart
where ratings >= 4.5
)
select brand,count(name) from top_rated
group by brand 
order by count(name) desc;

-- Query 11
-- Find the Top 3 most expensive products in each category.
with Expensive_products as
(
  select
   Name,
   category,
   `Selling price`,
   ROW_NUMBER() OVER(
      partition by category
      order by `Selling price` desc
   ) as mhenga
from master_flipkart
)
select 
  Category,
  name,
  `Selling price`
from Expensive_products 
where mhenga <= 3;

-- Query 12     
-- Count the number of premium products for each brand.
with Premium_products as
(
select*
from master_flipkart 
where ratings >= 4.5
  and discount >= 0.2
  and No_of_ratings >= 1000
)
select
      Brand,
      count(*) as Premium_Product_Count
from premium_products   
group by brand
order by Premium_Product_Count desc;
      
      
-- Query 13
-- Solve the same business problem without using a CTE.
select
 Brand,
 count(*) as premium_products
 from master_flipkart 
where ratings >= 4.5
and discount >= 0.2
and No_of_ratings >= 1000
group by brand
order by premium_products desc;

-- Query 14
-- Find the Top 2 highest-rated products in each category.
with highest_rated_products as
(
 select
  Name,
  Category,
  Brand,
  Ratings,
  row_number() over(
  partition by category
  order by ratings desc
  )as rated
from master_flipkart
)
select
 Name,
 category,
 Brand,
 ratings
 from highest_rated_products
 where rated <= 2;











































