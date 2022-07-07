---
title: tmpfs
---

# tmpfs

[tmpfs总结](https://blog.csdn.net/wz947324/article/details/80007122)

挂载：

```bash
mkdir /mnt/leveldb
mount -t tmpfs -o size=10g tmpfs /mnt/leveldb
```