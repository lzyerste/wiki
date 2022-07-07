---
title: Chapter_5_Synchronizing_Access_to_Shared_Objects_ef6037a0807948b090a09d2f8d8f88fc
---

# Chapter 5: Synchronizing Access to Shared Objects

- condition variable
    - signal之后，将等待线程从cv中移出，放到READY队列，运行的时候会去require lock，可能仍然会被阻塞，但此时已经不在cv上等待，而是在lock上等待，等别人release lock。
- 使用Lock和CV实现读写锁：
    
    ![Chapter%205%20Synchronizing%20Access%20to%20Shared%20Objects%20ef6037a0807948b090a09d2f8d8f88fc/Untitled.png](assets/2022-05-02_11-06-00.png)
    
- 使用Lock和CV实现synchronization barrier：
    
    ![Chapter%205%20Synchronizing%20Access%20to%20Shared%20Objects%20ef6037a0807948b090a09d2f8d8f88fc/Untitled%201.png](assets/2022-05-02_11-27-04.png)