---
title: ssh
---

#ssh

[我的公钥_ssh](../../personal/我的公钥_ssh.md)

# ssh

## 生成公私钥对

```
ssh-keygen
```

一路默认回车即可。

生成目录`~/.ssh`，公钥为id_rsa.pub，私钥为id_rsa。

## 密码方式

```
ssh <user>@<IP>
```

比如

```
ssh lzy@10.20.3.160
```

提示输入密码即可。

## 公钥方式

将之前生成的公钥拷给目标机器，粗暴方式直接写入目标机的authorized_keys文件。

推荐方式使用ssh-copy-id命令。

```
ssh-copy-id -i ~/.ssh/id_rsa.pub lzy@10.20.3.160
```

提示输入密码即可。

之后，就可以直接免密连接目标机。

```
ssh lzy@10.20.3.160
```

不用输入密码。

## .ssh/config，跳板机

比如使用ssh test来代替之前的ssh lzy@10.20.3.160，可以修改config文件。

```
Host test
    HostName 10.20.3.160
    User lzy
```

还可以使用跳板机中转，比如连接到A，再连接到B。

```
Host proxy
    HostName 10.20.3.60
    Port 2201
    User luzhongyong
    IdentityFile "/Users/Lu-macbook/.ssh/id_rsa"

Host lzyerste-pcu
    HostName 172.17.41.238
    User lzyerste
    ProxyJump proxy
```

疑问：公钥分发给跳板机跟目标机么？分两步来理解，第一步是要先连上跳板机proxy，比如上面指定了私钥文件。连上跳板机后，相当于处于内网了，这时候直面目标机，相当于直连，可以使用不同的公钥，也可以使用连跳板机的公钥。

可行的做法：

1. 公钥加入到跳板机。接下来就可以连接到跳板机了。
2. 首次连接目标机，经过跳板机中转后，会提示输密码。正确输入密码后就连接成功了。
3. 为了以后免密连接目标机，将公钥加入到目标机。

## 加了公钥还要密码？

authorized_keys权限改为600.

注意，home也有要求，不能是777，改成755可以。

## windows平台

windows平台可以使用git bash里的ssh程序，不要使用自带的，要不然跳板机失败。

之后，vscode里设置remote-ssh时使用的ssh程序，比如：

```jsx
"remote.SSH.path": "D:\\Program Files\\Git\\usr\\bin\\ssh.exe",
```