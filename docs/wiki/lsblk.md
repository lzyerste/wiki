---
title: lsblk
---

查看块设备信息。

例子：

```c
$ lsblk
NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
loop0     7:0    0     4K  1 loop /snap/bare/5
loop1     7:1    0  55.5M  1 loop /snap/core18/2253
loop2     7:2    0  54.2M  1 loop /snap/snap-store/558
loop3     7:3    0  43.6M  1 loop /snap/snapd/14978
loop4     7:4    0  61.9M  1 loop /snap/core20/1361
loop5     7:5    0 248.8M  1 loop /snap/gnome-3-38-2004/99
loop6     7:6    0  65.1M  1 loop /snap/gtk-common-themes/1515
loop7     7:7    0  65.2M  1 loop /snap/gtk-common-themes/1519
loop8     7:8    0   219M  1 loop /snap/gnome-3-34-1804/72
loop10    7:10   0   219M  1 loop /snap/gnome-3-34-1804/77
loop11    7:11   0 247.9M  1 loop /snap/gnome-3-38-2004/87
loop12    7:12   0  55.5M  1 loop /snap/core18/2284
loop13    7:13   0    51M  1 loop /snap/snap-store/547
loop14    7:14   0  61.9M  1 loop /snap/core20/1376
sda       8:0    0 223.6G  0 disk 
├─sda1    8:1    0   512M  0 part /boot/efi
└─sda2    8:2    0 223.1G  0 part /
nvme0n1 259:0    0  14.1T  0 disk 
```

可以查看uuid：

```c
lsblk -o name,mountpoint,size,type,ro,label,uuid
```