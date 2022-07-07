---
title: _watch
---

定期观察命令执行结果。

比如观察slabinfo：

```sh
watch -n 1 'cat /proc/slabinfo | sort -n -k 2 -r'
```
