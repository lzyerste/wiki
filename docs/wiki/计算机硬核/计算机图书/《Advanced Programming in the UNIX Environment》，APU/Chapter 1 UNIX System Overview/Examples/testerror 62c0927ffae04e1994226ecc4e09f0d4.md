---
title: testerror_62c0927ffae04e1994226ecc4e09f0d4
---

# testerror

Desc: 打印错误信息
Figure: 1.8
File: testerror.c
备注: stderror, perror

![testerror%2062c0927ffae04e1994226ecc4e09f0d4/untitled](assets/b0adf5383dbd126d1a5941be035aa593.png)

```c
#include "apue.h"
#include <errno.h>

int
main(int argc, char *argv[])
{
    fprintf(stderr, "EACCES: %s\n", strerror(EACCES));
    errno = ENOENT;
    perror(argv[0]);
    exit(0);
}
```