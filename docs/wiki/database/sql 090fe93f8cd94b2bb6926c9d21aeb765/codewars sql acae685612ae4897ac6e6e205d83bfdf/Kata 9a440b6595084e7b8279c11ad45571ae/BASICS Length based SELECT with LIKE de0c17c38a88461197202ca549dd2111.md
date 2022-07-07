---
title: BASICS_Length_based_SELECT_with_LIKE_de0c17c38a88461197202ca549dd2111
---

# BASICS: Length based SELECT with LIKE

难度: 7kyu

[Train: BASICS: Length based SELECT with LIKE | Codewars](https://www.codewars.com/kata/5a8d94d3ba1bb569e5000198/train/sql)

## 题意

You will need to create `SELECT` statement in conjunction with `LIKE`.

Please list people which have first_name with `at least 6 character long`

### **names table schema**

- id
- first_name
- last_name

### **results table schema**

- first_name
- last_name

## 题解

`_`可匹配任意一个字符，`%`可匹配任意多个字符（包括0个）。

```sql
select first_name, last_name
from names
where first_name like '%______%'
```

其实保留1个%就够了。