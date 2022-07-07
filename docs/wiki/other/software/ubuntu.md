---
title: ubuntu
---

#ubuntu

[centos](centos.md)

package搜索： https://pkgs.org/

# ubuntu [wiki]

[ubuntu重装系统](../../../personal/ubuntu重装系统.md)

[安装不同内核](ubuntu/安装不同内核.md)

[⭐给root用户添加密码，允许ssh以root连接](ubuntu/给root用户添加密码，允许ssh以root连接.md)

[修改鼠标滚轮速度，往前、往后](ubuntu/修改鼠标滚轮速度，往前、往后%20d1403a1b24584cc1a1758c9c80378a39.md)

[耳机麦克风没声音](ubuntu/耳机麦克风没声音%2093ef3bf01a4b4a30b56dcd221f2a3618.md)

[ubuntu桌面卡顿](ubuntu/ubuntu桌面卡顿.md)

# 新建用户

[How To Create a Sudo User on Ubuntu](https://linuxize.com/post/how-to-create-a-sudo-user-on-ubuntu/)

```python
adduser lzy
```

加入sudo：

```c
usermod -aG sudo lzy
```

# 发行版内核版本及glibc版本

![Pasted image 20220210143050](assets/Pasted%20image%2020220210143050.png)

# 锁屏后显示Authentication Failure Switch to greeter...

[ubuntu锁定屏幕后显示"Authentication Failure Switch to greeter..."](https://www.jianshu.com/p/f54c1d84e70d)

# 修改时区

[Ubuntu修改时区和更新时间 - zhengchaooo的博客 - CSDN博客](https://blog.csdn.net/zhengchaooo/article/details/79500032)

# 网络问题

2019-12-23 20:16:15

Ubuntu 16.04安装4.15.0-42（降级）内核后，没有网络了，看不到网卡。

解决办法：重装网络驱动。

[How To get your Realtek RTL8111/RTL8168 working](https://unixblogger.com/how-to-get-your-realtek-rtl8111rtl8168-working-updated-guide/)