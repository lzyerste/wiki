---
title: SQL_Basics_Top_10_customers_by_total_payments_amou_0eb3a1f230b049abb780cdfcabb36a7e
---

# SQL Basics: Top 10 customers by total payments amount

难度: 6kyu

[Train: SQL Basics: Top 10 customers by total payments amount | Codewars](https://www.codewars.com/kata/sql-basics-top-10-customers-by-total-payments-amount/train/sql)

[SQL Basics: Top 10 customers by total payments amount](https://www.jianshu.com/p/9d45ee9c8c75)

## 题意

### Overview

For this kata we will be using the [DVD Rental database](http://www.postgresqltutorial.com/postgresql-sample-database/).

Your are working for a company that wants to reward its top 10 customers with a free gift. You have been asked to generate a simple report that returns the `top 10 customers by total amount spent`. Total number of payments has also been requested.

The query should output the following columns:

- `customer_id` [int4]
- `email` [varchar]
- `payments_count` [int]
- `total_amount` [float]

and has the following requirements:

- only returns the 10 top customers, ordered by total amount spent

### Database Schema

![http://www.postgresqltutorial.com/wp-content/uploads/2013/05/PostgreSQL-Sample-Database.png](http://www.postgresqltutorial.com/wp-content/uploads/2013/05/PostgreSQL-Sample-Database.png)

## 题解

```sql
select C.customer_id, C.email, 
  count(*) as payments_count, 
  cast(sum(P.amount) as float) as total_amount
from customer as C, payment as P
where C.customer_id = P.customer_id
group by C.customer_id
order by total_amount desc
limit 10
```

拆解如下：

首先，参与的表只需要`customer`表（提供客户基本信息）及`payment`表（提供支付记录）。两张表合并（根据客户ID来`join`），可以得到payment表中的每笔支付记录对应到哪个客户。

```sql
select C.customer_id, C.email
from customer as C, payment as P
where C.customer_id = P.customer_id
```

接下来，需要汇总，统计每个客户有多少笔支付（count）以及总共花了多少（sum）。payment表中的amount字段表示了一笔交易记录的金额。汇总操作使用`group by`，字段显然是客户ID。

```sql
select C.customer_id, C.email
  count(*) as payments_count, 
  cast(sum(P.amount) as float) as total_amount
from customer as C, payment as P
where C.customer_id = P.customer_id
group by C.customer_id
```

cast操作只是转换类型，numerical转换为float（题目要求）。

接下来，就简单了，只需要挑选消费最高的10个客户。根据消费金额倒序排下（`order by`操作），然后限制选择10个就行（`limit`操作）。

```sql
select C.customer_id, C.email, 
  count(*) as payments_count, 
  cast(sum(P.amount) as float) as total_amount
from customer as C, payment as P
where C.customer_id = P.customer_id
group by C.customer_id
order by total_amount desc
limit 10
```