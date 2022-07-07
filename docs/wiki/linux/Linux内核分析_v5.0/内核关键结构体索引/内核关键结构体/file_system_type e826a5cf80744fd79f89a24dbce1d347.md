---
title: file_system_type_e826a5cf80744fd79f89a24dbce1d347
---

# file_system_type

url: https://elixir.bootlin.com/linux/v5.0/source/include/linux/fs.h#L2168
说明: 文件系统类型描述

```python
// https://elixir.bootlin.com/linux/v5.0/source/fs/filesystems.c#L33
// 全局，链接所有文件系统类型
static struct file_system_type *file_systems;
static DEFINE_RWLOCK(file_systems_lock);
```