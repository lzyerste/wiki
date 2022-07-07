---
title: Chapter_16_Network_IPC_Sockets
---

# Chapter 16: Network IPC: Sockets

- Stevens, Fenner, and Rudoff [2004]: UNIX Network Programming
- 

![Chapter%2016%20Network%20IPC%20Sockets/untitled](assets/73d6a8532a4034e70a3acb2f83444f49.png)

![Chapter%2016%20Network%20IPC%20Sockets/untitled%201](assets/32988d083827bb68af0a9577cc91b3fe.png)

![Chapter%2016%20Network%20IPC%20Sockets/untitled%202](assets/c8a08db9bcfde135d09c954143b86d21.png)

![Chapter%2016%20Network%20IPC%20Sockets/untitled%203](assets/e0beb4ffce68d002d6a6a38049e8bf18.png)

- The TCP/IP protocol suite uses `big-endian` byte order.
- 如何运行`ruptime`示例（mac os）
    - 给系统添加ruptime服务，在/etc/services添加
        - ruptime 4000/tcp
    - 启动server端
        - ./ruptimed，弹框时允许网络访问，会后台运行（守护进程）
    - 查看本机网络名
        - 命令hostname：Lus-MacBook-Air.local
    - 启动client端
        
        ![Chapter%2016%20Network%20IPC%20Sockets/untitled%204](assets/e8b7a69adfa1f4f048d7c20a27f7f149.png)