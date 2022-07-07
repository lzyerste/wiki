---
title: docker
---

[yeasy/docker_practice](https://github.com/yeasy/docker_practice)

## 安装

Ubuntu下安装：

[How to Install Docker On Ubuntu 18.04 {2019 Tutorial} - PhoenixNAP](https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04)

```cpp
sudo apt install docker.io
```

```cpp
sudo systemctl start docker
sudo systemctl enable docker
```

## 命令

```cpp
sudo docker command
```

### pull

拉取镜像

```cpp
sudo docker pull library/centos:7.2.1511
```

### ps

查看正在运行的容器：

```cpp
sudo docker ps
```

查看所有容器：

```cpp
sudo docker ps -a
```

### run

创建一个容器：

```cpp
sudo docker run -d --name ceph-dev -v $(pwd):/ceph library/centos:7.2.1511 sleep 3600d
```

### start

启动一个容器：

```cpp
sudo docker start container_name
```

### stop

停止一个容器：

```cpp
sudo docker stop container_name
```

### rm

删除一个容器：

```cpp
sudo docker rm container_name
```

### images

查看本地镜像：

```cpp
sudo docker images
```