---
title: 给root用户添加密码，允许ssh以root连接
---

# 给root用户添加密码，允许ssh以root连接

- ubuntu 20.04默认不给root密码，先设置密码

    ```python
    sudo passwd

    # 设置为1

    # su - root成功
    ```

- ssh默认不给root登录
    - [https://linuxconfig.org/allow-ssh-root-login-on-ubuntu-20-04-focal-fossa-linux](https://linuxconfig.org/allow-ssh-root-login-on-ubuntu-20-04-focal-fossa-linux)
    - vi /etc/ssh/sshd_config

	```python
	FROM:
	#PermitRootLogin prohibit-password
	TO:
	PermitRootLogin yes
	```

    - systemctl restart ssh