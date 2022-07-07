---
title: grub2
---

# grub2

重启的时候进入上一次的系统（文件/etc/default/grub）：

```c
GRUB_SAVEDEFAULT=true
# 需要重新grub2-mkconfig
```

[zh/HowTos/Grub2 - CentOS Wiki](https://wiki.centos.org/zh/HowTos/Grub2)

修改grub启动项名字？grub-customizer

[grub customizer](grub2/grub%20customizer.md)

[How do I customize the GRUB 2 menu?](https://askubuntu.com/questions/532238/how-do-i-customize-the-grub-2-menu)

需要先加上epel的repo：

```c
sudo yum install epel-release
sudo yum repolist
sudo yum install -y grub-customizer
```

比如修改grub启动项名字，它是通过/etc/grub.d/45_custom_proxy来实现的：

```c
#!/bin/sh
#THIS IS A GRUB PROXY SCRIPT
'/etc/grub.d/proxifiedScripts/custom' | /etc/grub.d/bin/grubcfg_proxy "+*
+#text
-'CentOS Linux YL (4.7.0-1.el7.elrepo.x86_64) 7 (Core)'~8f4d3970d3c3552323a28f47e64f851e~ as 'CentOS Linux (4.7.0-1.el7.elrepo.x86_64) 7 (Core)'
```

---

更新grub boot：

```c
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-install /dev/sda
```

## 问题

启动出现error: environment block too small，而且不是进入上一次的系统。

解决：重新生成grubenv，原因可能是之前的grub是Ubuntu生成的，现在是CentOS重新生成的，saved_entry的名字其实变动了，而grubenv保留的还是Ubuntu的版本。

```c
mv /boot/grub2/grubenv /boot/grub2/grubenv.old
grub-editenv /boot/grub2/grubenv create
```

## 修改默认启动项

[How can I boot with an older kernel version?](https://askubuntu.com/questions/82140/how-can-i-boot-with-an-older-kernel-version)

比如：先选1（Advanced），进入后再选2

```jsx
GRUB_DEFAULT="1>2"
```