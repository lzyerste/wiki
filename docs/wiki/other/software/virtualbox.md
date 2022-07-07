---
aliases:
- vb
title: virtualbox
---

#virtualbox

# virtualbox [wiki]

安装增强工具。

## 共享目录

[How to access a shared folder in VirtualBox?](https://askubuntu.com/questions/161759/how-to-access-a-shared-folder-in-virtualbox)

![](assets/Pasted%20image%2020211225200938.png)

进入ubuntu之后，能够看到目录/medai/sf_d，但还没有权限访问，需要把用户加入group。

```sh
sudo usermod -aG vboxsf userName
```

重启就可以了。


## TIPS

### 全屏隐藏底部工具栏

控制 -> 设置 -> 用户界面 -> 把`在全屏或无缝模式显示`前面的勾去掉

![](assets/Pasted%20image%2020211225195830.png)