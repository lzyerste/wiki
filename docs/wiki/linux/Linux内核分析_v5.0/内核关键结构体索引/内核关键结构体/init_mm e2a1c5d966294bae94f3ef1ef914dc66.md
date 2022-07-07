---
title: init_mm_e2a1c5d966294bae94f3ef1ef914dc66
---

# init_mm

url: https://elixir.bootlin.com/linux/v5.0/source/mm/init-mm.c#L28
说明: 0号进程所使用的mm

- 0号进程所使用的mm，其他进程的mm都通过链表（成员mmlist）串起来，init_mm就相当于是head。
- 锁保护为mmlist_lock
    
    ```python
    // https://elixir.bootlin.com/linux/v5.0/source/kernel/fork.c#L932
    
    __cacheline_aligned_in_smp DEFINE_SPINLOCK(mmlist_lock);
    ```