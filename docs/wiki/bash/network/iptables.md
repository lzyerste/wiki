---
title: iptables
---

https://www.cnblogs.com/williamjie/p/10478026.html

## 设置白名单

```cpp
# disable all
sudo iptables -I INPUT -p tcp --dport 1085 -j DROP

# localhost
sudo iptables -I INPUT -p tcp --dport 1085 -j ACCEPT -s 127.0.0.1

# nijiayu
sudo iptables -I INPUT -p tcp --dport 1085 -j ACCEPT -s 172.17.42.163
```