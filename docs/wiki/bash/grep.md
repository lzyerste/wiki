---
title: grep
---

#grep #xargs

[TOC]

[How to Use Grep Command in Linux](https://linuxize.com/post/how-to-use-grep-command-to-search-files-in-linux/)

## 结合xargs高级用法

需求：将固件日志中的所有pda信息转为具体的geo信息。

步骤：

1. 通过grep获取所有pda地址
2. 传入xargs，针对每个pda，调用python脚本解析

```shell
grep -a -oP 'pda=\K(0x[a-fA-F0-9]+)' log___dev_ttyUSB3__20211222__18_09_21.txt | xargs -I {} sh -c 'echo {} ; python3 ~/git/tacoma/scripts/zns_parse_pda.py {}'

0x1000001
spb=8, page=0, itlv=0, du=1
0x1000029
spb=8, page=0, itlv=10, du=1
```

grep里的`\K`是为了group？

xargs的{}相当于变量，在后面的命令中直接使用。

## 搜索特定类型文件

https://stackoverflow.com/a/35280826/1148981

在日志文件里找timeout信息：

```shell
grep -irn --include='log*2022*.txt' 'timeout' ./
```

## 显示上下文

比如关键字的上下若干行。

```jsx
# 显示file文件中匹配foo字串那行以及上下5行
grep -C 5 foo file

# 显示foo及前5行
grep -B 5 foo file

# 显示foo及后5行
grep -A 5 foo file
```

## 指定文件类型

```bash
# 在java文件中搜索字符串findString
find . -name "*.java" | xargs grep -e findString -2
```

## 针对一个变量进行grep

[grep on a variable](https://unix.stackexchange.com/questions/163810/grep-on-a-variable)

```bash
# 注意echo的变量要双引号包起来
$ echo "$line" | grep select
```

## 正则表达式，group

https://unix.stackexchange.com/questions/13466/can-grep-output-only-specified-groupings-that-match

获取链接：

```bash
cat README.md | grep -a -oP '\[.*\]\(\K(.*)(?=\))'
```