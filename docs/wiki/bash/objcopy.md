---
title: objcopy
---

#gcc 

https://ftp.gnu.org/old-gnu/Manuals/binutils-2.12/html_node/binutils_5.html

## 例子

修改fw中的main1的ATCM从地址0x0（私有地址）搬到0x100000（公共地址）。

通过全局地址访问跟局部地址访问速度有差异么？

```bash
arm-none-eabi-objcopy main1 --change-section-lma .ATCM=0x100000
```

比如ATCM段往后偏移1MB（统一用偏移的原因是为了方便处理atcm_free，我们知道ATCM的起始，但atcm_free却不知道具体位置）：

```c
arm-none-eabi-objcopy ${TACOMA_BIN}/main1 --change-section-lma .ATCM+0x100000                         
arm-none-eabi-objcopy ${TACOMA_BIN}/main1 --change-section-lma .atcm_free+0x100000
```