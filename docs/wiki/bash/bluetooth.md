---
aliases:
- 蓝牙
title: bluetooth
---

ubuntu通过命令行开启蓝牙（蓝牙关闭了，无线鼠标用不了）。

https://askubuntu.com/questions/380096/turn-on-off-bluetooth-from-shell-not-from-applet

```
rfkill block bluetooth

rfkill unblock bluetooth
```