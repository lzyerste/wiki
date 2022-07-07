---
title: bash语法检查
---

# bash语法检查

[ShellCheck](https://www.shellcheck.net/)

## bash防止误删根目录，rm -rf /*

[koalaman/shellcheck](https://github.com/koalaman/shellcheck/wiki/SC2115)

有问题的代码：

```cpp
rm -rf "$STEAMROOT/"*
```

如果变量没有设置的话，就会从根目录开始删除了。

正确代码：

```cpp
rm -rf "${STEAMROOT:?}/"*
```

如果变量未定义或者为空，都会报错退出：parameter not set or null

所以，脚本里的删除操作必须非常小心，尤其是路径的第一项，如果是变量的话，必须加上:?