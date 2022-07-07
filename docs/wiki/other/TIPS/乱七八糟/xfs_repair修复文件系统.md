---
title: xfs_repair修复文件系统
---

# xfs_repair修复文件系统

Tags: xfs

centos上有个目录删不掉

```cpp
Structure needs cleaning
```

```cpp
[Wed Aug  5 10:24:47 2020] XFS (dm-2): Metadata corruption detected at xfs_dinode_verify+0x226/0x4e0 [xfs], inode 0x20340938 dinode
[Wed Aug  5 10:24:47 2020] XFS (dm-2): Unmount and run xfs_repair
[Wed Aug  5 10:24:47 2020] XFS (dm-2): First 128 bytes of corrupted metadata buffer:
```

修复：

```cpp
# umount /home
# xfs_repair /dev/mapper/centos-home
# mount /dev/mapper/centos-home /home
```

可以删了。