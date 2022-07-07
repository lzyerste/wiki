---
title: Chapter_15_Interprocess_Communication
---

# Chapter 15: Interprocess Communication

## 15.2 Pipes

- half duplex
- Pipes can be used only between processes that have a common ancestor. 比如父子进程
- int pipe(int fd[2]);
    - fd[1] → fd[0]，半双工，fd[0]用于读，fd[1]用于写。
    
    ![Chapter%2015%20Interprocess%20Communication/untitled](assets/47a8bdb2ed347808fee303ee9b53459d.png)
    
    ![Chapter%2015%20Interprocess%20Communication/untitled%201](assets/2811ed20fdbbb31c9119a5e8c06e2524.png)
    
    fd[0]和fd[1]在父子进程都是打开的，如果要保持父进程向子进程单方向写，那么，只需要在父进程关闭读fd[0]、子进程关闭写fd[1]即可。
    
    ![Chapter%2015%20Interprocess%20Communication/untitled%202](assets/286d3950bc24eaf74a86fafb626b4d27.png)
    

## 15.3 popen and pclose Functions

- 

## FIFOs

named pipes

## Message Queues

## Semaphores

## Shared Memory