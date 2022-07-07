---
title: scp
---

# scp

[每天学一个 Linux 命令（60）：scp](scp/每天学一个%20Linux%20命令（60）：scp%201de49d3579c747fb8aeccfeba995510a.md)

```shell
$ cheat scp
# To copy a file from your local machine to a remote server:
scp <file> <user>@<host>:<dest>

# To copy a file from a remote server to your local machine:
scp <user>@<host>:<src> <dest>

# To scp a file over a SOCKS proxy on localhost and port 9999 (see ssh for tunnel setup):
scp -o "ProxyCommand nc -x 127.0.0.1:9999 -X 4 %h %p" <file> <user>@<host>:<dest>
```

-r参数：拷贝目录

# 带转义字符

https://unix.stackexchange.com/questions/148929/how-do-i-copy-a-file-with-scp-with-special-characters

文件前加当前路径`./`。

```shell
scp ./0000\:07\:00.0_sequential_read_result.csv lzy@10.20.8.97:
```