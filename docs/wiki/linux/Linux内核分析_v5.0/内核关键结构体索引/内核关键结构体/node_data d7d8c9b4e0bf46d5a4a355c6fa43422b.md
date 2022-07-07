---
title: node_data_d7d8c9b4e0bf46d5a4a355c6fa43422b
---

# node_data

url: https://elixir.bootlin.com/linux/v5.0/source/arch/x86/mm/numa.c#L24
说明: 跟踪所有NUMA节点

```python
// https://elixir.bootlin.com/linux/v5.0/source/arch/x86/mm/numa.c#L24

struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
EXPORT_SYMBOL(node_data);
```

```python
// https://elixir.bootlin.com/linux/v5.0/source/include/linux/numa.h#L6

#ifdef CONFIG_NODES_SHIFT
#define NODES_SHIFT     CONFIG_NODES_SHIFT
#else
#define NODES_SHIFT     0
#endif

#define MAX_NUMNODES    (1 << NODES_SHIFT)
```

```python
// https://elixir.bootlin.com/linux/v5.0/source/arch/x86/Kconfig#L1593
// 可以查看下机器/boot目录下的config文件

config NODES_SHIFT
	int "Maximum NUMA Nodes (as a power of 2)" if !MAXSMP
	range 1 10
	default "10" if MAXSMP
	default "6" if X86_64
	default "3"
	depends on NEED_MULTIPLE_NODES
	---help---
	  Specify the maximum number of NUMA Nodes available on the target
	  system.  Increases memory reserved to accommodate various tables.
```