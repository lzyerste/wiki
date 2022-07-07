---
title: crontab
---

https://crontab.guru/

[Linux Crontab 定时任务，菜鸟教程](https://www.runoob.com/w3cnote/linux-crontab-tasks.html)

```sh
# 查看任务列表
crontab -l
```

```sh
# 编辑任务
crontab -e
```

```sh
# 任务执行日志
/var/log/cron
# ubuntu下在/var/log/syslog, grep下CRON
# https://askubuntu.com/questions/56683/where-is-the-cron-crontab-log
```

```sh
# 每个小时备份
$ crontab -l
0 * * * * cd /home/lzy/backup ; ./sync.sh
```

## 每小时汇报IP

```sh
0 * * * * cd /home/lzy/bakcup ; python3 get_ip.py > lzy-test-ip.txt ; scp lzy-test-ip.txt ci@ci: ; scp lzy-test-ip.txt lzy@lzy:~/Nutstore\\\ Files/Nutstore
```

## 开机自动执行脚本

- 设置ssh支持root登录，/etc/ssh/sshd_config

- root用户自动登录
    
    ```c
    执行sudo vim /etc/pam.d/gdm-autologin 注释掉auth required pam_succeed_if.so user != root quiet_success这一行(第三行左右)
    
    执行sudo vim /etc/pam.d/gdm-password注释掉 auth required pam_succeed_if.so user != root quiet_success这一行(第三行左右)
    ```
    
    ```c
    mkdir -p /root/.config/autostart/
    ```
    
- crontab
    
    ```c
    @reboot export PATH=/usr/sbin:$PATH ; cd /root ; date >> a.txt ; cd /root/ait/white_box_test/test_case/zns/warm_reboot ; python zns_warm_reboot_during_fio_test.py
    ```

## WSL里crontab没执行？

https://stackoverflow.com/questions/60256901/crontab-never-executes-in-windows-subsystem-linux

https://serverfault.com/questions/136461/how-to-check-cron-logs-in-ubuntu/470938#470938

先使能crontab日志：

```c
1.  modify `rsyslog` config: open `/etc/rsyslog.d/50-default.conf`, remove `#` before `cron.*`
2.  restart rsyslog service: `sudo service rsyslog restart`
3.  restart cron service: `service cron restart`

now you can check cron log from file `/var/log/cron.log`
```
