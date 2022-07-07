---
title: Easy_SQL_Cube_Root_and_Natural_Log_68f892e59e8e419a9d3c1f73fc1eb3d7
---

# Easy SQL: Cube Root and Natural Log

难度: 7kyu

[Train: Easy SQL: Cube Root and Natural Log | Codewars](https://www.codewars.com/kata/easy-sql-cube-root-and-natural-log/train/sql)

## 题意

Given the following table 'decimals':

**decimals table schema**

- id
- number1
- number2

Return a table with two columns (`cuberoot`, `logarithm`) where the values in cuberoot are the cube root of those provided in number1 and the values in logarithm are changed to the natural logarithm of those in number2.

## 题解

CBRT函数直接计算三次根，精度比power的1/3次要好。

```python
select cbrt(number1) as cuberoot, ln(number2) as logarithm
from decimals
```