---
title: Chapter_4_Files_and_Directories
---

# Chapter 4: Files and Directories

代码对应目录为filedir。

![Chapter%204%20Files%20and%20Directories/untitled](assets/19f8b738794f37faed17648a27112366.png)

判断文件类型：

![Chapter%204%20Files%20and%20Directories/untitled%201](assets/5d5dabdf4c4d09b82c6b4d21e14f3bc7.png)

IPC文件类型判断（一般并不被视为文件）：

![Chapter%204%20Files%20and%20Directories/untitled%202](assets/a4da6ecb6823047cbac436d02cc5993f.png)

st_mode包含的信息有：

- 文件类型
- set-user-ID bit和set-group-ID bit
- 文件访问权限

---

the UNIX System program that allows anyone to change his or her password, passwd(1), is a set-user-ID program

![Chapter%204%20Files%20and%20Directories/untitled%203](assets/ac96c975912e4dac036fc5adbe415a60.png)

文件访问权限：

![Chapter%204%20Files%20and%20Directories/untitled%204](assets/ef558102a99d2c729765c3efd2e360ed.png)

要打开一个文件，该路径上的所有目录权限必须有执行权限。

This is why the execute permission bit for a directory is often called the search bit.

对目录来说，执行权限代表了能否进入该目录；read权限表示能否读取目录内容，也就是文件列表。

![目录a有执行权限，无读权限。ls失败，但执行里面的脚本a.sh却能成功。cd能够进去。](assets/fe3a71d13651a2ee2faf25a3f42fd6d1.png)

目录a有执行权限，无读权限。ls失败，但执行里面的脚本a.sh却能成功。cd能够进去。

---

When this file is executed, set the effective user ID of the process to be the owner of the file (`st_uid`). 允许以owner ID来执行，但read跟write还是要检查原来的ID。

## chmod

![Chapter%204%20Files%20and%20Directories/untitled%206](assets/19b33b4e622f326a49f6e5a4923f628b.png)

## chown

## file size

- st_size
- st_blksize
- st_blocks

## File Systems

![Chapter%204%20Files%20and%20Directories/untitled%207](assets/fb93d212c7bf88827b214ac2ad241fff.png)

![Chapter%204%20Files%20and%20Directories/untitled%208](assets/b550f5e60583e50fed718b5f03723880.png)

## link

## rename

## File Times

![Chapter%204%20Files%20and%20Directories/untitled%209](assets/a39b920300e79ff29e618cfbf0dbbb83.png)

## mkdir，rmdir

## 例子

[Examples](assets/Examples.csv)