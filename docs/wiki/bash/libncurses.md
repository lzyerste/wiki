---
title: libncurses
---

#gdb #libncurses

报错：

```sh
error while loading shared libraries: libncurses.so.5: cannot open shared object file: No such file or directory
```

https://stackoverflow.com/questions/17005654/error-while-loading-shared-libraries-libncurses-so-5

实际已经安装了libncurses库，但是版本太高了？默认是版本6，而有些程序依赖的是版本5。

解决：建立版本5的软链接，实际指向版本6。

```sh
sudo ln -s /usr/lib/x86_64-linux-gnu/libncursesw.so.6 /usr/lib/libncurses.so.5
sudo ln -s /usr/lib/x86_64-linux-gnu/libncursesw.so.6 /usr/lib/libtinfo.so.5
```

根据实际情况找下版本6安装在哪里。