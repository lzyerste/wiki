---
title: 每天学一个_Linux_命令（60）：scp_1de49d3579c747fb8aeccfeba995510a
---

# 每天学一个 Linux 命令（60）：scp

[https://mp.weixin.qq.com/s?__biz=MzI0MDQ4MTM5NQ==&mid=2247509649&idx=2&sn=2266791f1e5ae714ccbeb468ddefbe77&chksm=e918c38dde6f4a9b22b2ad556367cb6731dcd7898fae00c8b3dda70a85ac38bedc7c299df033&xtrack=1&scene=90&subscene=93&sessionid=1615517694&clicktime=1615517698&enterid=1615517698&ascene=56&devicetype=android-29&version=2800015b&nettype=ctnet&abtest_cookie=AAACAA%3D%3D&lang=zh_CN&exportkey=AcZJY5cuoZ%2Fm3pEKQgAcJ%2Bo%3D&pass_ticket=IrWZgEJSr%2Fs%2FC%2F8HCQVz%2FVwEg8E2d94RU25cXRoqQHZ%2B62jeZzxBzULF7e1vNVvZ&wx_header=1](https://mp.weixin.qq.com/s?__biz=MzI0MDQ4MTM5NQ==&mid=2247509649&idx=2&sn=2266791f1e5ae714ccbeb468ddefbe77&chksm=e918c38dde6f4a9b22b2ad556367cb6731dcd7898fae00c8b3dda70a85ac38bedc7c299df033&xtrack=1&scene=90&subscene=93&sessionid=1615517694&clicktime=1615517698&enterid=1615517698&ascene=56&devicetype=android-29&version=2800015b&nettype=ctnet&abtest_cookie=AAACAA%3D%3D&lang=zh_CN&exportkey=AcZJY5cuoZ%2Fm3pEKQgAcJ%2Bo%3D&pass_ticket=IrWZgEJSr%2Fs%2FC%2F8HCQVz%2FVwEg8E2d94RU25cXRoqQHZ%2B62jeZzxBzULF7e1vNVvZ&wx_header=1)

**昨日推荐：**[](http://mp.weixin.qq.com/s?__biz=MzI0MDQ4MTM5NQ==&mid=2247509626&idx=3&sn=27d1721b4a22a6c2e47b5f8c3a818a4f&chksm=e918c366de6f4a7066a6493f7ffa8d5b23eda002df16a222ebda4bac35c574501eaaea45d3d3&scene=21#wechat_redirect)

## **命令简介**

scp 全拼secure copy，用于不同主机之间复制文件。

scp命令常用于在Linux系统下两个不同主机之间传输文件，其功能与[](http://mp.weixin.qq.com/s?__biz=MzI0MDQ4MTM5NQ==&mid=2247505820&idx=3&sn=81901b7399074ef67b2cfe409d6dd234&chksm=e918b280de6f3b9693be662b613cb28ccec2e6a41b7bf0795936759ad80477c3ab358f61b306&scene=21#wechat_redirect)相似，但是不同是，cp命令只能用于在本机环境下传输或复制拷贝文件，scp命令可以跨越不同主机，而scp传输文件是加密的。

scp 它使用ssh进行数据传输，并使用与ssh相同的身份验证并提供相同的安全性，scp 会要求输入密码或其它方式以进行身份验证。

## **语法格式**

```
scp [-12346BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file]
    [-l limit] [-o ssh_option] [-P port] [-S program]
    [[user@]host1:]file1 ... [[user@]host2:]file2
```

- 源文件：需要复制的文件
- 目标文件：格式为 user@host:filename（文件名为目标文件的名称）

## **选项说明**

```
-1	#指定使用ssh协议版本为1
-2	#指定使用ssh协议版本为2
-3	#指定两个主机之间的副本通过本地主机传输
-4	#指定使用ipv4
-6	#指定使用ipv6
-B	#使用批处理模式
-C	#使用压缩模式传输文件
-F	#使用指定的ssh配置文件
-i identity_file	#从指定文件中读取传输时使用的密钥文件
-l	#宽带限制
-o	#使用的ssh选项
-P	#远程主机的端口号
-p	#保留文件的最后修改时间，最后访问时间和权限模式
-q	#不输出复制进度信息
-r	#以递归方式复制
-S program	#指定加密传输时所使用的程序
-v	#显示传输过程的详细信息
```

## **应用举例**

从远程服务器复制到本地服务器

```
#复制文件
scp root@192.168.1.2:/download/soft/nginx.tar.gz /download/soft/

#复制目录
scp -r root@192.168.1.2:/app/soft/mongodb /app/soft/
```

以mingongge用户身份将远程主机mingongge.com上的/home/mingongge/backup.tar.gz 文件传送到当前工作目录下，并将传输限制为每秒 80 KB

```
scp -l 80 mingongge@mingongge.com:/home/mingongge/backup.tar.gz
#也可以写成如下
scp -l 80 mingongge@mingongge.com:/home/mingongge/backup.tar.gz ./
```

使用指定的端口号传输文件

```
scp -P 9999 root@192.168.1.2:/download/soft/nginx.tar.gz /download/soft/
```

查看详细的传输过程

```
[root@centos7 ~]# scp -v root@192.168.1.100:/root/nginxWebUI-1.3.5.jar  /root/download/
Executing: program /usr/bin/ssh host 192.168.1.100, user root, command scp -v -f /root/nginxWebUI-1.3.5.jar
OpenSSH_7.4p1, OpenSSL 1.0.2k-fips  26 Jan 2017
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: /etc/ssh/ssh_config line 58: Applying options for *
debug1: Connecting to 192.168.1.100 [192.168.1.100] port 22.
debug1: Connection established.
debug1: permanently_set_uid: 0/0
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_rsa type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_rsa-cert type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_dsa type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_dsa-cert type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_ecdsa type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_ecdsa-cert type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_ed25519 type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_ed25519-cert type -1
debug1: Enabling compatibility mode for protocol 2.0
debug1: Local version string SSH-2.0-OpenSSH_7.4
debug1: Remote protocol version 2.0, remote software version OpenSSH_7.4
debug1: match: OpenSSH_7.4 pat OpenSSH* compat 0x04000000
debug1: Authenticating to 192.168.1.100:22 as 'root'
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: algorithm: curve25519-sha256
debug1: kex: host key algorithm: ecdsa-sha2-nistp256
debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: kex: curve25519-sha256 need=64 dh_need=64
debug1: kex: curve25519-sha256 need=64 dh_need=64
debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
debug1: Server host key: ecdsa-sha2-nistp256 SHA256:GqOqgdhVZyEtg/wSM8l5YB+Y6GO8K3Ii7OFsKW9R2n0
The authenticity of host '192.168.1.100 (192.168.1.100)' can't be established.
ECDSA key fingerprint is SHA256:GqOqgdhVZyEtg/wSM8l5YB+Y6GO8K3Ii7OFsKW9R2n0.
ECDSA key fingerprint is MD5:cc:4b:7d:b6:59:0f:77:83:a9:a5:32:70:4e:87:0d:41.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.1.100' (ECDSA) to the list of known hosts.
debug1: rekey after 134217728 blocks
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: SSH2_MSG_NEWKEYS received
debug1: rekey after 134217728 blocks
debug1: SSH2_MSG_EXT_INFO received
debug1: kex_input_ext_info: server-sig-algs=<rsa-sha2-256,rsa-sha2-512>
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password
debug1: Next authentication method: gssapi-keyex
debug1: No valid Key exchange context
debug1: Next authentication method: gssapi-with-mic
debug1: Unspecified GSS failure.  Minor code may provide more information
No Kerberos credentials available (default cache: KEYRING:persistent:0)

debug1: Unspecified GSS failure.  Minor code may provide more information
No Kerberos credentials available (default cache: KEYRING:persistent:0)

debug1: Next authentication method: publickey
debug1: Trying private key: /root/.ssh/id_rsa
debug1: Trying private key: /root/.ssh/id_dsa
debug1: Trying private key: /root/.ssh/id_ecdsa
debug1: Trying private key: /root/.ssh/id_ed25519
debug1: Next authentication method: password
root@192.168.1.100's password:
debug1: Authentication succeeded (password).
Authenticated to 192.168.1.100 ([192.168.1.100]:22).
debug1: channel 0: new [client-session]
debug1: Requesting no-more-sessions@openssh.com
debug1: Entering interactive session.
debug1: pledge: network
debug1: client_input_global_request: rtype hostkeys-00@openssh.com want_reply 0
debug1: Sending environment.
debug1: Sending env LANG = en_US.UTF-8
debug1: Sending command: scp -v -f /root/nginxWebUI-1.3.5.jar
Sending file modes: C0644 36196329 nginxWebUI-1.3.5.jar
Sink: C0644 36196329 nginxWebUI-1.3.5.jar
nginxWebUI-1.3.5.jar                 100%   35MB  12.1MB/s   00:02
debug1: client_input_channel_req: channel 0 rtype exit-status reply 0
debug1: client_input_channel_req: channel 0 rtype eow@openssh.com reply 0
debug1: channel 0: free: client-session, nchannels 1
debug1: fd 0 clearing O_NONBLOCK
debug1: fd 1 clearing O_NONBLOCK
Transferred: sent 12604, received 36237992 bytes, in 4.3 seconds
Bytes per second: sent 2916.1, received 8384212.5
debug1: Exit status 0
```

通过上述过程信息，可以知道scp传输文件的整个过程是什么样的，也可以明白一些原理。

[](http://mp.weixin.qq.com/s?__biz=MzI0MDQ4MTM5NQ==&mid=2247509451&idx=3&sn=fb99c293c139e292396547dfb9e1cf89&chksm=e918c0d7de6f49c1850c0c77b72b870ca213d101d327bb973ac2e387e40210589b076a94a542&scene=21#wechat_redirect)