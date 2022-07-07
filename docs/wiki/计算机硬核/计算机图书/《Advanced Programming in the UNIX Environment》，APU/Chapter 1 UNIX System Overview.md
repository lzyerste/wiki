---
title: Chapter_1_UNIX_System_Overview
---

# Chapter 1: UNIX System Overview

2019-03-05 12:50:39，过了一遍，MarginNote

本章代码对应目录为`intro`。

man命令查看命令手册（下面的数字1表示哪个section）。

```bash
man 1 ls
man -s1 ls
```

## 编译

一开始直接编译出问题。

平台：Mac OS

直接敲命令`make`，报错：

```
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools),
```

修复：

```bash
sudo xcode-select --install
```

之后编译正常。

参考：

[Mac下xcrun: error: invalid active developer path问题解决方法 - 木小鱼的笔记 - CSDN博客](https://blog.csdn.net/blueheart20/article/details/78767806)

## 例子

[Examples](assets/Examples.csv)