---
title: Atomic_usage_patterns_in_the_kernel_LWN_net
---

# Atomic usage patterns in the kernel [LWN.net]

[https://lwn.net/Articles/698315/](https://lwn.net/Articles/698315/)

[Untitled](assets/Untitled%20Database%20186a981fd4f249c797e14081d592c13e.csv)

The Linux kernel uses a large variety of "atomic" operations — operations that are indivisible as observed from anywhere within the system — to provide safe and efficient behavior in a multi-threaded environment. A [recent article](https://lwn.net/Articles/695257/) explained why a new suite of atomic primitives was added but, as [reader "magnus" observed](https://lwn.net/Articles/695714/), that article didn't provide any context for how these, or any other atomic operations, actually get used. The new operations are hardly used at all as yet, so we can only guess how useful they might be. More mature operations are in wide use, and while cataloging every distinct use case would be unhelpfully tedious, finding a few common patterns can aid understanding. To this end, I went searching through the Linux kernel code to find out how different atomic operations are used and to look for examples that might shed light on the possible usefulness of the new operations.

### Simple flags

In general, atomic operations are only needed when multiple threads might update the same datum in potentially different ways. However, one of my early exposures to the importance of atomics involved values that weren't shared, or were only updated under a spinlock. The RPC (remote procedure call) layer of the NFS server uses a number of state flags, some of which were represented at that time as unsigned char while others were single-bit fields like:

```
    unsigned int sk_temp : 1,	/* temp socket */

```

The code that the C compiler generates to update fields like this one will read and then write a whole machine word. It is natural to use a lock to ensure that multiple read-modify-write operations do not happen in parallel but, if different fields in the same machine word are protected by different locks, these whole-word updates can easily interfere with each other. This code was originally safe because an extra spinlock was used just to protect these flags from each other. A [significant rewrite](http://git.kernel.org/cgit/linux/kernel/git/history/history.git/commit/?id=294d77d98b929017f6d8e3929c58ccfa189e44d7) of that code removed the extra spinlock and instead used set_bit() and clear_bit() to atomically update individual bits within a word.

So the first purpose of using atomic operations is isolation: ensuring that an update to one value doesn't disturb updates to neighboring, but unrelated, values. A write to an aligned value of the basic machine word size, typically 32 bits, can be assumed not to interfere with writes to neighboring values. Values with a smaller size, which might be updated concurrently with small neighbors, need some sort of protection, either with locking or with atomic operations.

### Counters

Of the many situations where concurrent updates to a single value can be expected, counters are probably the simplest. Linux uses atomic counters to count various things including [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/md/raid1.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n2122), [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/atm/idt77252.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n1073), [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/udl/udl_fb.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n149), and various other simple statistics. Atomic operations are not the most efficient way to collect statistics, so many are instead collected in separate per-CPU counters that are only summed when needed, as is done, for example, [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/genhd.h?id=fa8410b355251fd30341662a40ac6b22d3e38468#n290). Atomics are certainly easier, though, and when the events being counted are not too frequent they are a good choice.

Counting the number of some resource that is currently in use (or currently available) is a common use of atomics, and these use cases need to pay careful attention to what happens when the relevant limit is reached. jbd2, the journaling layer for ext4, tracks the blocks committed to the next transaction (outstanding_credits) with an atomic counter and, when the [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/jbd2/transaction.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n195), it simply subtracts off the last number and waits for space to become available. This means that the counter transiently exceeds the maximum, which presumably is not problematic.

The XFS filesystem also uses an atomic counter to track space commitment in the log, though in quite a different way. In this case, the counter is really a position in the log, and when it reaches the end it must atomically wrap around to the beginning. The "check for an overflow and adjust" approach used in jbd2 won't do here, so an atomic "compare-exchange" loop [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/xfs/xfs_log.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n146) to ensure only valid values are ever visible.

Thus a "reliable counter" is the second common use for atomic operations. It can gather statistics or monitor resource usage and sometimes impose hard limits. A common form of counter not mentioned yet is the reference counter. While these are "reliable counters", they have an important role in resource ownership, and so fit best a little later in our story.

### Exclusive ownership

Exclusive ownership of something is a frequent pattern in the Linux kernel, where the "something" might be a data structure, might be some specific part of, or access to, a data structure, or might be a more abstract resource. Often spinlocks or mutexes will be used to gain exclusive ownership but, in cases where there is no desire to wait if the resource is not immediately available, an atomic operation that reports whether or not ownership was obtained is usually the preferred approach.

Possibly the simplest way to gain exclusive ownership is with test_and_set_bit_lock().

```
    if (!test_and_set_bit_lock(BIT_NUM, &bitmap)) {
	/* make use of exclusive ownership here */
	clear_bit_unlock(BIT_NUM, &bitmap);
    } else
	/* try some other approach */

```

If the bit is clear and multiple threads run this code at the same time, only one will see that the bit wasn't set, and will have successfully set it. All the others will see the bit already set and will know they didn't set it and so did not gain ownership.

The _lock suffix and the _unlock suffix in clear_bit_unlock() are sometimes important and probably aren't used as much at they should be. test_and_set_bit_lock() and clear_bit_unlock() are variants of the unadorned test_and_set_bit() and clear_bit() functions; they should be used when resource ownership is being claimed as they bring both social and technical benefits. On the social side, they serve as useful documentation for the intent of the code. Not all test_and_set_bit() calls claim ownership; some only need the isolation properties of bit operations. Similarly, not all clear_bit() calls release ownership. Making the intention clear to the reader can be extremely valuable.

The technical value relates to the fact that the C compiler and the CPU hardware are permitted some flexibility in re-ordering memory accesses, providing that they don't change the behavior of a single-threaded program. In the absence of any "barriers" to restrain this flexibility, reads from memory that are textually between the "set bit" and the "clear bit" could be performed before the bit is set, and writes to memory could get delayed until after the bit is cleared. This re-ordering could allow one thread to see data that another thread is still manipulating, which is clearly undesired.

Without the locking suffixes, test_and_set_bit() actually provides a full two-way barrier so that no reads or writes can be moved from one side to the other. This is a stronger guarantee than needed, so test_and_set_bit_lock() can be used to just provide a one-way barrier to reads preventing them from being performed before the bit is set. This is referred to as an "acquire" semantic due to its used in gaining ownership of something. Conversely, clear_bit() provides no barriers at all, so clear_bit_unlock() is needed for correctness. It provides a "release" semantic — a one-way barrier to write requests that ensures that all writes that took place before the clearing of the bit will be visible before cleared bit itself is visible.

The different barrier behavior exhibited by the unadorned operations is explained by the rule that atomic operations that return a value (such as test_and_set_bit()) generally impose full memory barriers, while atomic operations that don't return a value (clear_bit(), for example) generally impose no barriers at all.

This need to be careful about memory barriers is one of the costs of using atomics rather than the safer (but slower) spinlocks. It used to be worse though. Prior to [2007](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=26333576fd0d0b52f6e4025c5aded97e188bdd44) there was no clear_bit_unlock(), so explicit barriers such as smp_mb__after_clear_bit() would need to be carefully placed to avoid races. Thankfully, that delightfully named function has long been deprecated and barriers are now usually integrated with the operation they protect. Many atomic operations are available with a variety of suffixes that indicate different ordering semantics, including _acquire, _release, _relaxed (which provides no ordering guarantees at all), and _mb (which gives a full memory barrier). As a general rule, these interfaces should probably be avoided unless you really know what you are doing. Even people who do know what they are doing can have [long conversations](https://lkml.org/lkml/2016/8/9/721) about the issues.

One pleasing example of using bit operations for exclusive access in the [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/block/cciss.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n979) is the cciss disk array driver. The driver maintains a pool of "commands" and a bitmap showing which commands are in use. It uses find_first_zero_bit() to find an available command, and then test_and_set_bit() to claim it. On failure, it just goes back to choose another command from the pool. This code could be made a little more readable by using test_and_set_bit_lock() and clear_bit_unlock(), but there is no reason to think the current code is not safe.

I chose that example to contrast it with [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/platforms/pasemi/dma_lib.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n146), which performs similar allocations from a pool, but with some differences: the bitmap identifies free resources, find_first_bit() is used to find one, and test_and_clear_bit() is used to claim it. There is no test_and_clear_bit_lock() or set_bit_unlock() so this code cannot self-document the use of the bits for locking, and we must hope there is no room for races around the set_bit() that releases the lock.

### Counters and pointers for exclusive ownership

One of the surprises I found while exploring the kernel was the number of drivers that used an atomic_t counter purely to gain exclusive access. These drivers, such as [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/s390/block/dasd.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n2111), a storage driver for IBM s390 systems, use atomic_cmpxchg() much like test_and_set_bit() so, for example:

```
    if (atomic_cmpxchg (&device->tasklet_scheduled, 0, 1) != 0)
	return;

```

will only continue to subsequent code if exclusive access was gained to whatever tasklet_scheduled protects. One reason that might justify this unusual construct is that the smallest bitmap that can be used with test_and_set_bit() and related functions is a single unsigned long integer, which is eight bytes on 64-bit architectures. In contrast, the value that atomic_cmpxchg() operates on is an atomic_t, which is only four bytes. Whether this small space saving justifies that non-standard code is a question we must leave to the individual developers to consider.

This space saving is one of the possible benefits of the new atomic_fetch*() operations. atomic_fetch_or() can be used to test and set any arbitrary bit in an atomic_t and [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/kernel/time/tick-sched.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n294) for two of the three call sites that are currently in the kernel. When an exclusive ownership is being requested, it would be better to use atomic_fetch_or_acquire() to document that intent. This currently produces identical code, but that may change.

A variation of exclusive ownership that requires a counter can be seen when the counter is used to identify a state in a state machine. A transition from one state to the next may require some particular action to be performed by precisely one thread. This pattern can be seen in quite a few network device drivers, though the first I came across was in the core code for Firewire devices. A Firewire device can transition from "initializing" to "running" to "gone" to "shutdown". Most of these transitions use atomic_cmpxchg() to avoid races and to detect which thread first made a particular transition. If the test:

```
    if (atomic_cmpxchg(&device->state,
	    	       FW_DEVICE_RUNNING,
		       FW_DEVICE_INITIALIZING) == FW_DEVICE_RUNNING) {

```

succeeds, then some extra work, which is needed when the device first starts running, can be performed.

A particularly common case that uses counters for a form of exclusive ownership are the various providers of unique serial numbers. [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/md/dm.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n2405) is just one example of more than a dozen that I found before losing interest. These atomically increment a value and return that value for local use. The caller is certain to be the only caller to be given that particular value, so they can be seen as having exclusive ownership of it. Of the ten places Davidlohr Bueso found to use the newly introduced atomic_fetch_inc(), seven were for unique serial numbers where there was a desire for the first number to be zero — atomic_inc_return() naturally starts by returning one. A similar simplification could be achieved by initializing the atomic counter to -1.

Atomic pointer updates are sometimes used to gain exclusive ownership, though with a slightly different understanding of the ownership concept. IPv6 supports a number of sub-protocols such as TCP, UDP, ICMP, etc. Handlers for these individual protocols can register themselves using [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/ipv6/protocol.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n31), which uses the cmpxchg() atomic function to install the provided handler into the table of protocol pointers. If a protocol was already registered, this fails. If not, the caller gains ownership of that particular protocol number and can continue as the registered handler.

A similar cmpxchg() to atomically replace a NULL with a pointer occurs in multiple places in the kernel such as in the [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/tty_audit.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n172) and in the [](https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/btrfs/raid56.c?id=fa8410b355251fd30341662a40ac6b22d3e38468#n196). Both of these install a newly allocated and initialized data structure for multiple threads to access. In the unlikely event that two threads find they need to create it at the same time, they might both prepare the structure but only one will successfully install it. The other must discard its structure as wasted effort. Here exclusive access is gained for "the right to initialize", which may seem to be a slightly contorted way to look at things, but does allow the formation of a uniform pattern.

### Shared ownership — for another day

The obvious sequel to exclusive ownership is the shared ownership provided by reference counters. This topic has been [covered before](https://lwn.net/Articles/336224/), so there is little point in more than a cursory review. However, a careful examination of one of the patterns found previously opens up a whole new collection of patterns and provides a hint at another possible use of the new atomic_fetch_*() operations. These topics will be covered in the companion article to this one.

([Log in](https://lwn.net/Login/?target=/Articles/698315/) to post comments)

Atomic usage patterns in the kernel

Posted Sep 5, 2016 13:33 UTC (Mon) by **tvld** (guest, #59052) [[Link](https://lwn.net/Articles/699466/)]

> In general, atomic operations are only needed when multiple threads might update the same datum in potentially different ways.

This is not true in general. In a setting such as C or C++, atomic operations are only needed when multiple threads might *access* the same datum concurrently, where "concurrently" means not already ordered by some other piece of code or rule in the language's memory model (e.g., in C11 concurrently would mean "not ordered by happens-before"). This is important because otherwise, one is making the implicit assumption that loads are atomic, which often happens to be the case but is not generally true (e.g., because it disallows reloading the value, as could be done by the code generated by the compiler).

It is also important to remember that due to using a high-level programming language, one is interfacing with the language's semantics first (and thus the compiler, which is part of the implementation of this semantics). The bitfield case you describe is a good example of that. The Linux kernel is making assumptions about what a compiler would do that go beyond what is required by the actual language semantics, so one should at least be aware of those assumptions. IMO, it is better to remember when/where one would need atomics in general, and then apply those assumptions (e.g., by using plain memory accesses when atomic ones would be required in general), instead of believing that these assumptions are universal. Whether these assumptions are good assumptions is another discussion, and languages (e.g., C11) or other projects (e.g., where glibc is heading) make different assumptions.