---
title: 4_Interrupts_and_Exceptions
---

# 4. Interrupts and Exceptions

2020-10-29 15:35:58，阅。

```python
https://elixir.bootlin.com/linux/v2.6.11/source/arch/i386/kernel/traps.c#L72

/*
 * The IDT has to be page-aligned to simplify the Pentium
 * F0 0F bug workaround.. We have a special link segment
 * for this.
 */
struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
```

```python
https://elixir.bootlin.com/linux/v2.6.11/source/include/asm-i386/processor.h#L27

// 8个字节？
struct desc_struct {
	unsigned long a,b;
};
```

```python
https://elixir.bootlin.com/linux/v2.6.11/source/arch/i386/kernel/head.S#L453

// 6个字节
idt_descr:
	.word IDT_ENTRIES*8-1		# idt contains 256 entries  表示的是limit，所以减1
	.long idt_table
```