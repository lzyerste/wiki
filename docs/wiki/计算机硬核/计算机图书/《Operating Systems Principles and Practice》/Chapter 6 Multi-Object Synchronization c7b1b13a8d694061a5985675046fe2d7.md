---
title: Chapter_6_Multi-Object_Synchronization_c7b1b13a8d694061a5985675046fe2d7
---

# Chapter 6: Multi-Object Synchronization

- MCS
- RCU
- Two Phase Locking
    - 前期按需持多个锁，最后全部释放。
    - 可能会导致死锁
- 死锁产生的四个条件
    - Bounded resources，资源可被多个线程同时抢占，但互斥，只能一个拥有。
    - No preemption，持有资源了后就不可被抢占
    - Wait while holding，持有了资源A的情况下，在等待其他资源
    - Circular waiting，形成环，相互等待
- Banker's Algorithm
    - 那不是要预先知道各个线程所需要的资源情况么？
    - 实际真实应用并不多，但要理解背后的思想。分配资源前要保证所有线程处于safe状态，也就是保证某个线程A完成了，然后回收线程A的所有资源，然后能够满足另一线程B的执行，B执行完了再回收B，分配给其他线程，以此类推，保证所有线程能够完成。
- Detect and recover from deadlocks
    - 为什么允许死锁发生？因为死锁可能并不是个common case。
    - 有向图