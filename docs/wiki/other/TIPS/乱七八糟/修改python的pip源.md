---
title: 修改python的pip源
---

# 修改python的pip源

Tags: pip, python

[Seven丨Pounds](https://www.cnblogs.com/zhx-blog/p/11619809.html)

## **pip源有以下**

新版ubuntu要求使用https源，要注意。清华：https://pypi.tuna.tsinghua.edu.cn/simple阿里云：http://mirrors.aliyun.com/pypi/simple/中国科技大学 https://pypi.mirrors.ustc.edu.cn/simple/华中理工大学：http://pypi.hustunique.com/山东理工大学：http://pypi.sdutlinux.org/豆瓣：http://pypi.douban.com/simple/

## **Windows下修改方式：**

直接在user目录中创建一个pip目录，如：C:\Users\xx\pip，新建文件pip.ini

文件内容为：

[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host=pypi.tuna.tsinghua.edu.cn

以清华源为例

## **Linux下修改方式：**

在用户家目录下的 .pip 目录下创建一个 pip.conf 文件 ， 如果没有 .pip 目录自行创建。

```
mkdir ~/.pip

cd ~/.pip

touch pip.conf

#编辑pip.conf文件
sudo gedit ~/.pip/pip.conf
```

将以下文件复制到 pip.conf 内

```cpp
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host=pypi.tuna.tsinghua.edu.cn
```

以清华源为例