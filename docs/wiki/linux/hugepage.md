---
title: hugepage_[wiki]
---

# hugepage [wiki]

## 释放

[Hugepages seems to be stuck](https://serverfault.com/questions/912449/hugepages-seems-to-be-stuck)

```bash
$ cat /proc/meminfo | grep HugePages                                                                                                                                                                       
AnonHugePages:         0 kB                                                                                                                                                                                
ShmemHugePages:        0 kB                                                                                                                                                                                
FileHugePages:         0 kB                                                                                                                                                                                
HugePages_Total:    1024                                                                                                                                                                                   
HugePages_Free:     1024                                                                                                                                                                                   
HugePages_Rsvd:        0                                                                                                                                                                                   
HugePages_Surp:        0
```

```bash
$ sudo bash -c 'echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages'
```

```bash
$ cat /proc/meminfo | grep HugePages                                                                 
AnonHugePages:         0 kB                                                                          
ShmemHugePages:        0 kB                                                                          
FileHugePages:         0 kB                                                                          
HugePages_Total:       0                          
HugePages_Free:        0                          
HugePages_Rsvd:        0                          
HugePages_Surp:        0
```