---
title: kopia
---

#todo

支持GUI。

![Pasted image 20220310172642](assets/Pasted%20image%2020220310172642.png)

## 安装命令行工具

```c
curl -s https://kopia.io/signing-key | sudo gpg --dearmor -o /usr/share/keyrings/kopia-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/kopia-keyring.gpg] http://packages.kopia.io/apt/ stable main" | sudo tee /etc/apt/sources.list.d/kopia.list

sudo apt update

sudo apt install kopia
```

## 快速入门（命令行）

比如前面已经用GUI创建了repository（sftp方式）。

==连接==

```c
kopia repository connect sftp --host 10.20.3.154 --username lzy --sftp-password lzy --known-hosts ~/.ssh/known_hosts --path /home/lzy/kopia
```

会提示输入repo的密码。

==查看snapshot==

```c
$ kopia snapshot list
lzy@lzy-pcu:/home/lzy/Downloads
  2022-02-17 14:00:00 CST k7b6fd9b535c1ad75ba3c8d4b62c880e8 2.8 GB drwxr-xr-x files:2562 dirs:276 (weekly-4)
......
  2022-03-09 20:00:02 CST kad615059e86ec1cbb484c221a85cc80e 2.9 GB drwxr-xr-x files:2692 dirs:289 (latest-2..4,hourly-2..4,daily-2)
  + 2 identical snapshots until 2022-03-10 08:00:00 CST
  2022-03-10 14:00:00 CST keed1ee49415652b36381abc6680a1b68 2.9 GB drwxr-xr-x files:2692 dirs:289 (latest-1,hourly-1,daily-1,weekly-1,monthly-1,annual-1)
```

==查看文件列表==

比如上面最新的哈希号keed1ee49415652b36381abc6680a1b68

```c
$ kopia ls -l keed1ee49415652b36381abc6680a1b68
drwxrwxr-x            0 2021-11-18 19:19:50 CST k86210a729076270d1e34eccdd1c4b257  .ts/
-rw-rw-rw-          165 2021-12-01 16:18:16 CST d671bba0887e2b883cdf2901013f3e3a   .~inno_2.4.xlsx
-rw-rw-r--     98504021 2021-12-15 11:05:26 CST Ix3eef1041ae735c6ead1bc945c5941ea5 4K_write_clat.log
-rw-rw-r--        42846 2021-11-08 18:04:56 CST 735bfae175b49ea2b003368935a15988   4k-256.png
......
```

==mount==

```c
mkdir /tmp/mnt

kopia mount keed1ee49415652b36381abc6680a1b68 /tmp/mnt &

ls -l /tmp/mnt/

umount /tmp/mnt
```

==snap restore==

比如恢复上面的keed1ee49415652b36381abc6680a1b68：

```c
kopia snapshot restore keed1ee49415652b36381abc6680a1b68 d1

ls d1
```

恢复到本地目录则是d1。

==离开==

```c
kopia repository disconnect
```

## 配置文件

```c
$ kopia repository status -t -s
Config file:         /home/lzy/.config/kopia/repository.config

Description:         My Repository
Hostname:            lzy-pcu
Username:            lzy
Read-only:           false
Format blob cache:   15m0s

Storage type:        sftp
Storage config:      {
                       "path": "/home/lzy/kopia",
                       "host": "10.20.3.154",
                       "port": 22,
                       "username": "lzy",
                       "password": "***",
                       "knownHostsFile": "/home/lzy/.ssh/known_hosts",
                       "externalSSH": false,
                       "dirShards": null
                     }

Unique ID:           5d9ea8e0692cf6847ccfdaa1cd98a7925cbeb59a2f4f352f92ea4e17f1dcf818
Hash:                BLAKE2B-256-128
Encryption:          AES256-GCM-HMAC-SHA256
Splitter:            DYNAMIC-4M-BUZHASH
Format version:      2
Content compression: true
Password changes:    true
Max pack length:     20 MiB
Index Format:        v2

Epoch Manager:       enabled
Current Epoch: 20

Epoch refresh frequency: 20m0s
Epoch advance on:        20 blobs or 10 MiB, minimum 24h0m0s
Epoch cleanup margin:    4h0m0s
Epoch checkpoint every:  7 epochs

To reconnect to the repository use:

$ kopia repository connect from-config --token eyJ2ZXJzaW9uIjoiMSIsInN0b3JhZ2UiOnsidHlwZSI6InNmdHAiLCJjb25maWciOnsicGF0aCI6Ii9ob21lL2x6eS9rb3BpYSIsImhvc3QiOiIxMC4yMC4zLjE1NCIsInBvcnQiOjIyLCJ1c2VybmFtZSI6Imx6eSIsInBhc3N3b3JkIjoibHp5Iiwia25vd25Ib3N0c0ZpbGUiOiIvaG9tZS9senkvLnNzaC9rbm93bl9ob3N0cyIsImV4dGVybmFsU1NIIjpmYWxzZSwiZGlyU2hhcmRzIjpudWxsfX0sInBhc3N3b3JkIjoibHp5MzI1MTEzIn0

NOTICE: The token printed above can be trivially decoded to reveal the repository password. Do not store it in an unsecured place.
```