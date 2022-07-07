---
title: glog安装
---

# glog安装

Tags: glog

CentOS直接安装：

```c
sudo yum install -y glog-devel
```

Ubuntu直接安装：

```c
sudo apt install libgoogle-glog-dev
```

[google/glog](https://github.com/google/glog)

glog的安装依赖gflags库，如果gflags库安装在local目录下，需要将该目录导出到`LD_LIBRARY_PATH`之内。比如：

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

```c
git clone https://github.com/google/glog.git
****cd glog
git checkout v0.4.0
./autogen.sh && ./configure && make && make install
```