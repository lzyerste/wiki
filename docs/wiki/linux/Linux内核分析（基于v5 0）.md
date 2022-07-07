---
title: Linux内核分析（基于v5_0）
---

# Linux内核分析（基于v5.0）

[《Linux Kernel Development》](../计算机硬核/计算机图书/《Linux%20Kernel%20Development》.md)

[Understanding the Linux Kernel](../计算机硬核/计算机图书/Understanding%20the%20Linux%20Kernel.md) 

- 内核版本号：Linux 5.0，git tag 为 v5.0
    
    ```python
    commit 1c163f4c7b3f621efff9b28a47abb36f7378d783
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Sun Mar 3 15:21:29 2019 -0800
    
        Linux 5.0
    ```
    
- 使用sublime text阅读源码
    
    使用ctags生成索引
    
    ```python
    ctags -R -f .tags
    ```
    

[内核关键结构体索引](Linux内核分析_v5.0/内核关键结构体索引.md)

[内核关键函数索引](Linux内核分析_v5.0/内核关键函数索引.md)

---

[资源](Linux内核分析_v5.0/资源.md)

[好文](Linux内核分析_v5.0/好文.md)

# 数据结构

[链表，list](Linux内核分析_v5.0/链表，list.md)

[队列，kfifo](Linux内核分析_v5.0/队列，kfifo.md)

[红黑树](Linux内核分析_v5.0/红黑树.md)

[Radix Tree](Linux内核分析_v5.0/Radix%20Tree.md)

[位图，bitmap](Linux内核分析_v5.0/位图，bitmap.md)

# 进程管理

[关键概念](Linux内核分析_v5.0/关键概念.md)

[进程表示](Linux内核分析_v5.0/进程表示.md)

[进程调度](Linux内核分析_v5.0/进程调度.md)

[CFS调度器](Linux内核分析_v5.0/CFS调度器.md)

[调度相关系统调用](Linux内核分析_v5.0/调度相关系统调用.md)

# 内存管理

[内存管理](Linux内核分析_v5.0/内存管理.md)

[伙伴系统，buddy system](Linux内核分析_v5.0/伙伴系统，buddy%20system.md)

[slab分配器，slab allocator](Linux内核分析_v5.0/slab分配器，slab%20allocator.md)

[per-cpu变量](Linux内核分析_v5.0/per-cpu变量.md)

# 锁机制

[内核锁机制总结](Linux内核分析_v5.0/内核锁机制总结.md)

[自旋锁](Linux内核分析_v5.0/自旋锁.md)

[信号量](Linux内核分析_v5.0/信号量.md)

[互斥锁mutex](Linux内核分析_v5.0/互斥锁mutex.md)

[读写锁](Linux内核分析_v5.0/读写锁.md)

[顺序锁](Linux内核分析_v5.0/顺序锁.md)

[RCU](Linux内核分析_v5.0/RCU.md)

[原子变量与位操作](Linux内核分析_v5.0/原子变量与位操作.md)

[条件变量](Linux内核分析_v5.0/条件变量.md)

[Kernel Locking Techniques | Linux Journal](Linux内核分析_v5.0/Kernel%20Locking%20Techniques%20Linux%20Journal.md)

# 中断

# IO

# 文件系统

[debugfs](Linux内核分析_v5.0/debugfs.md)

# 剪辑

[Getting a handle on caching - LWN net](Linux内核分析_v5.0/Getting%20a%20handle%20on%20caching%20-%20LWN%20net.md)

[ioremap and memremap - LWN net](Linux内核分析_v5.0/ioremap%20and%20memremap%20-%20LWN%20net.md)

