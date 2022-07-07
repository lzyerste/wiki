---
title: lightdm
---

#ubuntu #gdm

使用lightdm桌面管理器之后，向日葵远程正常了。但：

- [x] 锁屏Win+L没有自动生效。
- [x] 锁屏后，不能远程ssh了。
- [x] 锁屏后，显示器还亮着。有一次手动关闭显示器电源，之后锁屏显示器就能黑屏了。

## 使用gnome-screensaver

每次开机要启动一下。

## 锁屏修改

https://askubuntu.com/questions/1245071/cant-lock-screen-with-shortcut-on-ubuntu-20-04-gnome

自定义快捷键Win+L到如下命令（移除原来Win+L的默认功能）：

```c
dm-tool lock
```

## 防止休眠

https://askubuntu.com/questions/942366/how-to-disable-sleep-suspend-at-login-screen