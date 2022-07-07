---
title: Adults_only__SQL_for_Beginners__1__52158789a1c54eb6be02ff94f73ffb72
---

# Adults only (SQL for Beginners #1)

难度: 8kyu

[](SQL for Beginners #1)](https://www.codewars.com/kata/adults-only-sql-for-beginners-number-1)

## 题意

In your application, there is a section for adults only. You need to get a list of names and ages of `users` from the users table, who are `18 years old or older`.

users table schema

- name
- age

NOTE: Your solution should use pure SQL. Ruby is used within the test cases to do the actual testing.

---

This kata is part of a collection of SQL challenges for beginners. You can take the rest of the challenges [here!](https://www.codewars.com/collections/sql-for-beginners)

## 题解1：基本操作

```sql
select name, age
from users
where age >= 18
```