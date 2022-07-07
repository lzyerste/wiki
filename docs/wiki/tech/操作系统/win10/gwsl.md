---
title: gwsl
---

在windows下运行wsl里的桌面应用。

注意设置好DISPLAY环境变量，使用host主机的ip。比如我的是192.168.0.116

https://stackoverflow.com/questions/61860208/wsl-2-run-graphical-linux-desktop-applications-from-windows-10-bash-shell-erro

```c
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
```

> 使用了这个后，好像影响vim，不开gwsl的话，vim会卡住。

wsl里打开sublime merge（/opt/sublime_merge/sublime_merge）：操作稍微有点卡，影响不大。

gwsl里使用快捷方式不能打开。重新打开gwsl可以了。

字体有点小，使用Hi-DPI后又太大。

DPI使用Windows方式会快一些、界面也大了些、但会变模糊。

![](assets/Pasted%20image%2020220325194658.png)