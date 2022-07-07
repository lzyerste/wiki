---
title: ioremap___and_memremap___[LWN_net]
---

# ioremap() and memremap() [LWN.net]

[https://lwn.net/Articles/653585/](https://lwn.net/Articles/653585/)

[ioremap and memremap](assets/Untitled%20Database%2096f985a83d59403ab7d8f4f8e2793c67.csv)

Like user space, the kernel accesses memory through page tables; as a result, when kernel code needs to access memory-mapped I/O devices, it must first set up an appropriate kernel page-table mapping. The in-kernel tool for that job has long been ioremap(), which has a number of variants. It turns out that some of those variants are not always the right tool for the job, leading to a certain amount of workaround code in the kernel. That situation may change, though, as part of a move away from ioremap() for the problematic cases.

A successful call to ioremap() returns a kernel virtual address corresponding to start of the requested physical address range. This address is not normally meant to be dereferenced directly, though, for a number of (often architecture-specific) reasons. Instead, accessor functions like readb() or iowrite32() should be used. To enforce this rule, the return address from ioremap() is annotated with the __iomem marker; that will cause the sparse checker to complain about accesses that do not use the proper functions.

There is also the little matter of caching. The CPU normally caches data from memory, but that is a bad idea when I/O is involved for a number of reasons. Attempts to read a full cache line from I/O memory can have no end of unexpected side effects, and delaying writes to I/O memory can change the way the device operates. I/O memory should normally function as a direct control channel to the device; to that end, ioremap() disables caching on device memory — on the x86 architecture, at least.

In truth, the caching status of a memory range obtained from ioremap() is not fully defined. As a general rule, uncached is the default, but there is still an ioremap_nocache() that can be called by code that wants to be absolutely sure that there will be no cache between it and its device memory.

In some cases, though, I/O memory is just memory; the video memory used by a graphics adapter is a classic example. With this kind of memory, direct pointer references can be expected to work and caching in the CPU may be acceptable; indeed, it may be required to get reasonable performance. For such cases, there is an ioremap_cache() that creates a cached mapping if possible. Most architectures also have a couple of variants that allow caching of reads but limit caching of writes. In particular, ioremap_wc() allows combining of write operations and ioremap_wt() causes writes to go directly to device memory. With these variants, driver writers can obtain the kind of mapping they need for a specific piece of device memory.

Dan Williams recently ran into a couple of problems with this family of functions, though. One is that they all return pointers with the __iomem annotation. A driver that is mapping I/O memory with caching enabled almost certainly will treat the resulting address range as if it were ordinary memory — including directly dereferencing pointers into that range. To do so, they must either cast away the __iomem annotation or simply ignore it. In the former case, the code is noisier than it would otherwise be; in the latter case, anybody running sparse on the code will have to ignore the resulting warnings.

Beyond that, many architectures do not support all of the various caching modes, so the architecture-specific header files are full of lines like:

```
    #define ioremap_wt ioremap_nocache

```

The result is that callers of functions like ioremap_wt() may silently fail to get the writethrough caching that they are asking for.

Dan's answer to both problems is [a patch set](https://lwn.net/Articles/652964/) adding a new function for the mapping of device memory that behaves like memory:

```
    void *memremap(resource_size_t offset, size_t size, unsigned long flags);

```

This function will (on success) return an address for a mapping to the device memory found at the given physical offset and of the given size (in bytes). The flags argument can be either MEMREMAP_WB for full writeback caching or MEMREMAP_WT for writethrough caching. The returned address does not have the __iomem annotation. If the requested caching behavior cannot be provided, memremap() will return NULL rather than fall back to a different type of caching.

The patch set converts most in-kernel code over to the new interface.

This work is in its third revision as of this writing, and the (few) review comments made have been addressed. It clarifies the driver API, clearly separating two different use cases for the mapping of device memory, and it should result in less sparse warning noise. There is not much to dislike at this point, so there shouldn't be much keeping it out of the 4.3 merge window.

([Log in](https://lwn.net/Login/?target=/Articles/653585/) to post comments)