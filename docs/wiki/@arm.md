---
title: _arm
---

[arm-assembly-cheatsheet.pdf](assets/arm-assembly-cheatsheet.pdf)

## 资源

[INTRODUCTION TO ARM ASSEMBLY BASICS](https://azeria-labs.com/writing-arm-assembly-part-1/)

[Code in Assembly for Apple Silicon with the AsmAttic app](https://eclecticlight.co/2021/06/07/code-in-assembly-for-apple-silicon-with-the-asmattic-app/)

[Code in ARM Assembly: Registers explained](https://eclecticlight.co/2021/06/16/code-in-arm-assembly-registers-explained/)

[Apple Developer Documentation](https://developer.apple.com/documentation/xcode/writing-arm64-code-for-apple-platforms)

## 如何打印stack trace

[Debugging ARM without a Debugger 3: Printing Stack Trace - Woongbin's blog](https://wbk.one/article/6/debugging-arm-without-a-debugger-3-printing-stack-trace)

## 使用__FILE__

[https://mcuoneclipse.com/2021/01/23/assert-__file__-path-and-other-cool-gnu-gcc-tricks-to-be-aware-of/](https://mcuoneclipse.com/2021/01/23/assert-__file__-path-and-other-cool-gnu-gcc-tricks-to-be-aware-of/)

相对路径还是绝对路径？

## 64 位除法

https://github.com/ARM-software/arm-trusted-firmware/blob/master/lib/compiler-rt/builtins/udivmoddi4.c

udivmoddi4

https://stackoverflow.com/questions/51457851/building-coreboot-undefined-reference-udivmoddi4

```c
`__udivmoddi4` is a function in libgcc which is used to implement a combined unsigned division/modulo operation for what GCC calls DI mode (doubled-up integers, 64-bit on i686)
```