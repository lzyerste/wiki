---
title: kdump
---

# kdump

经验贴： [付景辉crash排查，2020-04-23](https://www.notion.so/crash-2020-04-23-2ef720f9be224bf3a6d5ebcb852ba82c) 

[AIC pika AMD crash，#4150，1.9.0，2020-08-03](https://www.notion.so/AIC-pika-AMD-crash-4150-1-9-0-2020-08-03-d5c4dd5e40c445a7aeff6542709e4d85) 

---

[How to enable Kdump on RHEL 7 and CentOS 7](https://www.linuxtechi.com/how-to-enable-kdump-on-rhel-7-and-centos-7/)

注意crash工具要同步更新。注意内核版本的匹配。

安装debuginfo，调试crash文件vmcore：

下载安装包：

[Index of /7/x86_64](http://debuginfo.centos.org/7/x86_64/)

一个是kernel-debuginfo-common-x86_64-3.10.0-957.el7.x86_64.rpm。

一个是kernel-debuginfo-3.10.0-957.el7.x86_64.rpm。

安装完毕后，使用crash来恢复现场。

```jsx
sudo crash /usr/lib/debug/lib/modules/3.10.0-957.el7.x86_64/vmlinux vmcore
```

bt -l查看trace。

---

如何加载驱动?

```jsx
mod -s venice /home/shannon/swift-kv/venice.ko
```

[内核调试工具 - kdump & crash_运维_zhangskd的专栏-CSDN博客](https://blog.csdn.net/zhangskd/article/details/38084337)

---

[Chapter 7. Kernel crash dump guide Red Hat Enterprise Linux 7 | Red Hat Customer Portal](kdump/Chapter%207%20Kernel%20crash%20dump%20guide%20Red%20Hat%20Enterpri.md)

[Analyzing Linux kernel crash dumps with crash - The one tutorial that has it all](https://www.dedoimedo.com/computers/crash-analyze.html)

## ubuntu

[https://ubuntu.com/server/docs/kernel-crash-dump](https://ubuntu.com/server/docs/kernel-crash-dump)

[https://ruffell.nz/programming/writeups/2019/02/22/beginning-kernel-crash-debugging-on-ubuntu-18-10.html](https://ruffell.nz/programming/writeups/2019/02/22/beginning-kernel-crash-debugging-on-ubuntu-18-10.html)