---
title: pcie
---

## 重新扫描设备

host先重新识别下pcie设备。注意相对应的pcie设备号。

```c
lspci | grep Non
01:00.0 Non-Volatile memory controller: Xilinx Corporation Device 9034
```

```c
sudo bash -c "echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove" ; sudo bash -c "echo 1 > /sys/bus/pci/rescan"
```

lsblk能够看到设备了：

```c
lsblk
NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda       8:0    0 111.8G  0 disk
└─sda1    8:1    0 111.8G  0 part /
nvme0n1 259:0    0   256K  0 disk
```