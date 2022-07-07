---
title: xrdp，远程连接_3be58784362b49b69806f3e0cb751eb1
---

# xrdp，远程连接

```c
sudo apt install xrdp
```

[How to Install Xrdp Server (Remote Desktop) on Ubuntu 20.04](https://linuxize.com/post/how-to-install-xrdp-on-ubuntu-20-04/)

黑屏处理：

```bash
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
. $HOME/.profile
```

> By adding the above lines just before the test and exec in /etc/xrdp/startwm.sh
> 

[Ubuntu 18.04, Blank screen after login from Windows 10 · Issue #1358 · neutrinolabs/xrdp](https://github.com/neutrinolabs/xrdp/issues/1358)

## mac客户端

- parallels client支持rdp