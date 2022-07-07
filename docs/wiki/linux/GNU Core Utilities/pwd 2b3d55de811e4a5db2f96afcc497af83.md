---
title: pwd_2b3d55de811e4a5db2f96afcc497af83
---

# pwd

- pwd打印的是当前工作目录，绝对路径形式。
- `pwd`命令有两种模式，参数`-L`的话，使用logical path，路径中可以有符号链接；参数`-P`的话，使用physical path，将符号链接都转换成目标文件。
- 当前工作目录也就是把``.``转化为绝对路径，可以通过父目录`..`一层层往上走到根目录`/`。但是这样代价比较大。
- 因为符号链接的存在，当前目录`.`可以有多种表现形式（路径字符串），但内部转化为inode时，指向的是同一个。所以，最后结果要`SAME_INODE`比较下。

---

函数分析：

`main`

```c
main()
	logical_getcwd()
	xgetcwd()
	robust_getcwd()
```

`logical_getcwd`

```c
logical_getcwd()
	char *wd = getenv ("PWD");  // 先尝试从进程的环境变量中获取
	wd格式检查
	/* System call validation.  */
  if (stat (wd, &st1) == 0 && stat (".", &st2) == 0 && SAME_INODE (st1, st2))
    return wd;
```

`SAME_INODE`

```c
#  define SAME_INODE(a, b)    \
    ((a).st_ino == (b).st_ino \
     && (a).st_dev == (b).st_dev)
```