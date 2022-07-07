---
title: SQL_Basics_Simple_JOIN_and_RANK_81c5fe6749ee410a844cdf189e030826
---

# SQL Basics: Simple JOIN and RANK

难度: 6kyu

[SQL Basics: Simple JOIN and RANK](https://www.codewars.com/kata/sql-basics-simple-join-and-rank/sql)

## 题意

For this challenge you need to create a simple SELECT statement that will return all columns from the `people` table, and join to the `sales` table so that you can return the COUNT of all sales and RANK each person by their sale_count.

### **people table schema**

- id
- name

### **sales table schema**

- id
- people_id
- sale
- price

You should `return all people fields` as well as the sale count as "`sale_count`" and the rank as "`sale_rank`".

> NOTE: Your solution should use pure SQL. Ruby is used within the test cases to do the actual testing.
> 

## 题解

子查询统计好销量，然后外层再统计rank。

```sql
select *, rank() over(order by sale_count desc) as sale_rank
from (
	select people.id, people.name, count(sale) as sale_count
	from people, sales
	where people.id = sales.people_id
	group by people.id
	) as T
```