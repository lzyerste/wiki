---
title: hexdump
---

## hex

[How to Use Linux Hexdump Command with Practical Examples](https://linoxide.com/linux-how-to/linux-hexdump-command-examples/)

注意，hexdump的字节序跟机器相关，比如Intel为小端，如果两个字节一起打印，3733实际代表的是33 37。

```cpp
# hexdump -C Linoxide
00000000  54 68 69 73 20 69 73 20  20 61 20 74 65 73 74 20  |This is  a test |
00000010  4c 69 6e 6f 78 69 64 65  20 46 69 6c 65 0a 55 73  |Linoxide File.Us|
00000020  65 64 20 66 6f 72 20 64  65 6d 6f 6e 73 74 72 61  |ed for demonstra|
00000030  74 69 6f 6e 20 70 75 72  70 6f 73 65 73 0a 0a     |tion purposes..|
0000003f
```