---
aliases:
- iftop
title: iftop，监控网络流量
---

```c
sudo iftop -m 20M -B

-m表示最大右刻度
-B表示以Byte显示
```

字符l可以过滤。

字符t可以切换单行多行显示。

L可以切换带宽显示是线性的还是log的（推荐线性）。