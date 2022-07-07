---
title: kill_-9_杀不死的进程处理办法_一只叫做Unix的猫-CSDN博客_kill_-s_term__2fe33ad6658d462996c68b55caede9e7
---

# kill -9 杀不死的进程处理办法_一只叫做Unix的猫-CSDN博客_kill -s term 杀不死怎么办

[https://blog.csdn.net/u012349696/article/details/52250640?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase](https://blog.csdn.net/u012349696/article/details/52250640?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase)

kill -9发送SIGKILL信号将其终止，但是以下两种情况不起作用：

a、该进程处于"Zombie"状态（使用ps命令返回defunct的进程）。此时进程已经释放所有资源，但还未得到其父进程的确认。"Zombie"进程要等到下次重启时才会消失，但它的存在不会影响系统性能。

b、 该进程处于"kernel mode"（核心态）且在等待不可获得的资源。处于核心态的进程忽略所有信号处理，因此对于这些一直处于核心态的进程只能通过重启系统实现。进程在AIX 中会处于两种状态，即用户态和核心态。只有处于用户态的进程才可以用“kill”命令将其终止

无论是kill -9还是kill -15，还是其它信号量都kill不掉, 这些进程是Nagios检查进程. 难不成和我刚做的Oracle主备切换有关系? 如下:

# ps -ef | grep find | grep -v grep

nagios 4507 1 0 Mar22 ? 00:00:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

nagios 5940 1 0 Mar22 ? 00:00:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

nagios 7470 1 0 Mar22 ? 00:00:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

root 8880 1 0 Mar22 ? 00:00:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

root 9003 1 0 Mar22 ? 00:00:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

root 9150 1 0 Mar22 ? 00:00:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

nagios 16276 1 0 Mar22 ? 00:00:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

nagios 25925 1 0 Mar22 ? 00:00:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

nagios 27372 1 0 Mar22 ? 00:00:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

可以看出父进程是1，即init进程.

# ps aux | grep find | grep -v grep

nagios 4507 0.0 0.0 5328 644 ? D Mar22 0:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

nagios 5940 0.0 0.0 3816 556 ? D Mar22 0:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

nagios 7470 0.0 0.0 5412 640 ? D Mar22 0:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

root 8880 0.0 0.0 5516 496 ? D Mar22 0:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

root 9003 0.0 0.0 4268 572 ? D Mar22 0:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

root 9150 0.0 0.0 3860 572 ? D Mar22 0:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

nagios 16276 0.0 0.0 5604 640 ? D Mar22 0:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

nagios 25925 0.0 0.0 4504 644 ? D Mar22 0:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

nagios 27372 0.0 0.0 4992 644 ? D Mar22 0:00 /usr/bin/find / -maxdepth 2 -type f -mmin -61 -ls

可以看出这些进程的状态是D. 我们知道D(disk)状态的进程是硬件资源不满足而处于深度休眠状态, 一般是等待磁盘. 这种进程用kill -9杀不掉, 要么继续等, 要么重启. 难道只能重启服务器才能解决么???

$ cat /proc/21520/status

Cpus_allowed: 00000000,00000000,00000000,00000000,00000000,00000000,00000000,ffffffff

**ps -ef | grep ocs | grep -v grep | cut -c 9-15 | xargs kill -s 9
kill -kill pid**