---
title: script
---

[bash](bash.md)

例子：

```sh
script -c <PROGRAM> -f OUTPUT.txt
```

上面-f指定了总是flush。

上面运行的时候，程序一方面正常输出到终端，另一方面也会输出到OUTPUT.txt文件。

---

命令帮助：

```sh
$ script --help

Usage:
 script [options] [file]

Make a typescript of a terminal session.

Options:
 -a, --append                  append the output
 -c, --command <command>       run command rather than interactive shell
 -e, --return                  return exit code of the child process
 -f, --flush                   run flush after each write
     --force                   use output file even when it is a link
 -o, --output-limit <size>     terminate if output files exceed size
 -q, --quiet                   be quiet
 -t[<file>], --timing[=<file>] output timing data to stderr or to FILE
 -h, --help                    display this help
 -V, --version                 display version

For more details see script(1).
```