---
title: contig_page_data_b8e72c01091d4154ac367846aeeb64f8
---

# contig_page_data

url: https://elixir.bootlin.com/linux/v5.0/source/mm/memblock.c#L92
说明: UMA单一节点

如果只有一个NUMA节点（UMA），那么使用contig_page_data变量来表示。

但一般机器也是采用NUMA表示？CONFIG_NEED_MULTIPLE_NODES为y

```python
// https://elixir.bootlin.com/linux/v5.0/source/mm/memblock.c#L92

#ifndef CONFIG_NEED_MULTIPLE_NODES
struct pglist_data __refdata contig_page_data;
EXPORT_SYMBOL(contig_page_data);
#endif
```