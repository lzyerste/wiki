---
title: wol
aliases: [wakeonlan]
---

#wol

https://wiki.debian.org/WakeOnLan

- 进入 BIOS，电源管理，允许 pcie 唤醒（wol）
- 测试机设置允许 wol： sudo ethtool -s eth0 wol g

* 强行关机

  ```sh
  sudo bash -c 'sync ; echo o > /proc/sysrq-trigger'
  ```

* 局域网其他电脑发送命令唤醒，使用mac地址。

  ```sh
  $ wakeonlan 7c:10:c9:3f:03:56
  Sending magic packet to 255.255.255.255:9 with 7c:10:c9:3f:03:56
  ```
