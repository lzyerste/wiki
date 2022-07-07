---
title: Chapter_3_File_I_O
---

# Chapter 3: File I/O

代码目录为fileio

![Chapter%203%20File%20I%20O/untitled](assets/bce656ea0a58bafd3772d616fe491324.png)

两个打开同一个文件：

![Chapter%203%20File%20I%20O/untitled%201](assets/95512884e22598448f86da51d0ce1003.png)

每个进程都有自己的file table，这样可以独立维护各自文件的状态，如flag及offset。

同一个进程内，也可以有多个fd指向同一个file table entry (dup)。

file table entry是属于进程还是属于内核管理？属于内核。

The kernel maintains a file table for all open files.

O_APPEND保证在每次write之前，将offset更新到文件末尾。

---

O_CREAT and O_EXCL：当这两个组合同时存在时，只有文件不存在时，才能open成功（真的创建文件）。检查与创建合并为一个原子操作。

file descriptor flags与file status flags？

dup2?

---

针对同一个文件，不同进程各自打开时，内核中分别有各自的file table entry，只是vnode指向同一个。

![Chapter%203%20File%20I%20O/untitled%202](assets/eb34c609aeb5e1aef096a97eab85d39f.png)

## 例子

[Examples](assets/Examples.csv)