---
title: httpd快速搭建web服务
---

#apache #httpd #fileserver #server

# httpd快速搭建web服务

1. 安装httpd
    
    ```cpp
    sudo yum install -y httpd
    ```
    
2. 编辑配置文件
    
    ```cpp
    sudo vi /etc/httpd/conf/httpd.conf
    
    # 一般默认，修改下端口，使用具体的IP比较靠谱
    Listen 172.17.41.27:8085
    ```
    
3. 修改/var/www/html权限
    
    ```cpp
    sudo chown stanley -R /var/www/html
    ```
    
4. 启动httpd服务
    
    ```cpp
    sudo systemctl restart httpd
    ```
    
    可能因为SELinux关系，不允许端口绑定（比如8085）：
    
    ```cpp
    sudo semanage port -a -t http_port_t -p tcp 8085
    sudo iptables -I INPUT -p tcp --dport 8085 -j ACCEPT
    ```
    
5. 应该可以访问了
6. 去掉默认的欢迎页
    
    ```c
    sudo mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.bak
    sudo systemctl restart httpd
    ```
	
## 文件不能下载？

zip文件能够下载，sh文件不能下载。

---

zip文件太大了也不能下载（大于10M？）。

https://serverfault.com/questions/309233/apache-serves-some-files-others-get-403

```
chcon -R -t httpd_sys_content_t /var/www/webdocs
```

---