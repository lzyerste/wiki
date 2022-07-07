---
title: Keep_Hydrated!_58bc80fe53d349d1bc9fae2cd3b665e6
---

# Keep Hydrated!

难度: 8kyu

[Keep Hydrated!](https://www.codewars.com/kata/keep-hydrated-1/sql)

## 题意

Nathan loves cycling.

Because Nathan knows it is important to stay hydrated, he drinks 0.5 litres of water per hour of cycling.

You get given the time in hours and you need to return the number of litres Nathan will drink, rounded to the smallest value.

For example:

time = 3 ----> litres = 1

time = 6.7---> litres = 3

time = 11.8--> litres = 5

You have to return 3 columns: `id`, `hours` and `liters` (not litres, it's a difference from the kata description)

## 题解

注意整数向下取整。

注意返回的列名是liters而不是litres，题目的问题。

floor（地板）函数向下取整，ceil（天花板）是向上取整，round则是四舍五入。

```python
select id, hours, floor(hours/2) as liters
from cycling
```