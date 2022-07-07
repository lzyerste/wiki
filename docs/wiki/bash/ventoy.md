---
title: ventoy
---

#神器 #启动盘 #iso

tag: U盘、多系统、ISO、镜像、启动盘

[ventoy/Ventoy](https://github.com/ventoy/Ventoy)

[Ventoy](https://www.ventoy.net/en/index.html)

安装ventoy，然后格式化U盘，最后直接把ISO镜像拷到U盘即可。

```python
For Linux
Download the installation package, like ventoy-x.x.xx-linux.tar.gz and decompress it.
Run the shell script as root sh Ventoy2Disk.sh { -i | -I | -u } /dev/XXX   XXX is the USB device, for example /dev/sdb.

Attention that the USB drive will be formatted and all the data will be lost after install.
You just need to install Ventoy once, after that all the things needed is to copy the iso files to the USB.
You can also use it as a plain USB drive to store files and this will not affact Ventoy's function.
```