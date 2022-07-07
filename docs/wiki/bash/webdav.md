---
title: webdav
---

#webdav 

- [坚果云，jgy](../../personal/nutstore.md)
- [zotero](../tech/zotero.md)
- [keepass](../../personal/keepass.md)

## win10添加webdav

==Windows 网络地址映射==

https://www.jianshu.com/p/7ba5f0756efc

不用装任何软件，轻量使用的话超推荐这个办法。

在「我的电脑」画面中右键「添加一个网络位置」，「下一步」，「选择自定义网络位置」，网络地址输入为 WebDAV 的地址，比如坚果云就是 `https://dav.jianguoyun.com/dav/`，再点「下一步」，给该位置输入名称。

完成后可以在「我的电脑」画面看到新建的这个 WebDAV 地址的快捷方式了。第一次进入的时候需要输入用户名和密码。

另外映射 WebDAV 服务器默认只支持 `https`，如果需要 `http` 支持的话可以参考 CSDN 上这篇 [Win 10 映射 WebDAV](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fkh766200466%2Farticle%2Fdetails%2F91951568)，修改注册表键值。

![Pasted image 20220108133336](assets/Pasted%20image%2020220108133336.png)