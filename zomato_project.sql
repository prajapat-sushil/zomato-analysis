CREATE database ZOMATO;
USE ZOMATO;

CREATE TABLE goldusers_signup(
	userid integer,
    gold_signup_date date
    );
INSERT INTO goldusers_signup (userid, gold_signup_date) 
 VALUES (1,'2017-09-22'), 
        (3,'2017-04-21');

CREATE TABLE users(
	userid integer,
    signup_date date
    );
INSERT INTO users(userid,signup_date) 
 VALUES (1,'2014-09-02'),
		(2,'2015-01-15'),
		(3,'2014-04-11');

CREATE TABLE sales(
	userid integer,
    order_date date,
    product_id integer
    ); 

INSERT INTO sales(userid, order_date, product_id) 
 VALUES (1,'2017-04-19',2),
		(3,'2019-12-18',1),
		(2,'2020-07-20',3),
		(1,'2019-10-23',2),
		(1,'2018-03-19',3),
		(3,'2016-12-20',2),
		(1,'2016-11-09',1),
		(1,'2016-05-20',3),
		(2,'2017-09-24',1),
		(1,'2017-03-11',2),
		(1,'2016-03-11',1),
		(3,'2016-11-10',1),
		(3,'2017-12-07',2),
		(3,'2016-12-15',2),
		(2,'2017-11-08',2),
		(2,'2018-09-10',3);

CREATE TABLE product(
	product_id integer,
    product_name text,
    price integer
    ); 

INSERT INTO product(product_id,product_name,price) 
 VALUES (1,'p1',980),
		(2,'p2',870),
		(3,'p3',330);

select*from goldusers_signup;
select*from users;
select*from sales;
select*from product;

-- 1. what is the total amount spent by each costumer on Zomato ?
select a.userid, sum(b.price) as total_amt_spent from sales as a inner join product as b on a.product_id=b.product_id group by userid;

 -- 2. How many days has each customer visited zomato ?
 select userid ,count(distinct order_date) as distinct_days from sales group by userid;

-- 3. what is the first product purchased by each costumer ?
select * from 
(select *, rank() over(partition by userid order by order_date) rnk from sales ) as a where rnk =1;

-- 4. what is the most purchased on the the menu and how many times was is purchased by all customers ?
select userid, count(product_id) as cnt from sales where product_id =
(select top 1 product_id from sales group by product_id order by count(product_id) desc)
group by userid;

-- 5. Which item was the most popular for each customer ?
select * from 
(select * ,rank() over(partition by userid order by cnt desc) rnk from
(select userid, product_id, count(product_id) cnt from sales group by userid, product_id)a)b
where rnk = 1



 
