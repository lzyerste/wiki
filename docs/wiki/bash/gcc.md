---
title: gcc
---

#gcc

## gcc

#gcc

### 指定某函数优化等级

https://stackoverflow.com/questions/2219829/how-to-prevent-gcc-optimizing-some-statements-in-c

```c
void __attribute__((optimize("O0"))) foo(unsigned char data) {
    // unmodifiable compiler code
}
```

### 强行inline

https://stackoverflow.com/questions/8381293/how-do-i-force-gcc-to-inline-a-function

使用`__attribute__((always_inline))`，固件里包装了宏`ALWAYS_INLINE`。

### 强行不inline

https://stackoverflow.com/questions/1474030/how-can-i-tell-gcc-not-to-inline-a-function

```c
void __attribute__ ((noinline)) foo() 
{
  ...
}
```

固件里包装了宏`NOINLINE`。

### 避免编译警告：unused

比如未使用的变量或函数，固件里包装了宏UNUSED，展开是`__attribute__((unused))`。

## 其他

### gcc安装

[GCC 7.3.0编译安装 - RBPi' Blog - CSDN博客](https://blog.csdn.net/rbpicsdn/article/details/79565383)

### gcc各版本的flag支持

[Barro/compiler-warnings](https://github.com/Barro/compiler-warnings)