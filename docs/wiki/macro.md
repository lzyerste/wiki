---
title: macro
---

#macro #gcc #c

## 常用宏

```
文件名： __FILE__  字符串

文件行号： __LINE__  数字

函数名： __func__  字符数组？

```

## 数字macro转为字符串

https://stackoverflow.com/questions/240353/convert-a-preprocessor-token-to-a-string

注意需要两层转换。

```c
#define STRINGIFY(x) #x
#define TOSTRING(x) STRINGIFY(x)
#define AT __FILE__ ":" TOSTRING(__LINE__)
```

## 文件名与行号拼接成字符串

文件名与行号拼接成字符串：

https://stackoverflow.com/questions/19343205/c-concatenating-file-and-line-macros/19343239

```c
#define S1(x) #x
#define S2(x) S1(x)
#define LOCATION __FILE__ " : " S2(__LINE__)
```