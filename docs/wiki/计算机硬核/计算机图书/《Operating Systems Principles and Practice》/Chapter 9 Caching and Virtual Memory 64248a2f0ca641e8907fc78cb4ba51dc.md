---
title: Chapter_9_Caching_and_Virtual_Memory_64248a2f0ca641e8907fc78cb4ba51dc
---

# Chapter 9: Caching and Virtual Memory

- 疑问：如何知道一个物理页框是否dirty？
    - 按照谁的page table entry？
    - 因为多个进程可能有共享，一个进程里PTE有dirty bit，另一个进程应该感知不到？
    - 利用core map，查看page frame对应的所有PTE？
-