---
title: gollum
---

#gollum #markdown #wiki #ruby

https://github.com/gollum/gollum

[TOC]

运行支持emoji：

```sh
gollum --emoji
```

## 安装

```sh
[sudo] gem install gollum
```

如果安装遇到如下问题：

```md
Building native extensions. This could take a while...
ERROR:  Error installing gollum:
        ERROR: Failed to build gem native extension.

    current directory: /var/lib/gems/2.7.0/gems/rugged-1.1.0/ext/rugged
/usr/bin/ruby2.7 -I /usr/lib/ruby/2.7.0 -r ./siteconf20210628-795161-171k3cl.rb extconf.rb
mkmf.rb can't find header files for ruby at /usr/lib/ruby/include/ruby.h

You might have to install separate package for the ruby development
environment, ruby-dev or ruby-devel for example.

extconf failed, exit code 1
```

安装ruby-dev：

```sh
sudo apt-get install ruby-dev
```

## 运行

```sh
$ cd wiki
$ gollum
[2021-06-28 17:10:18] INFO  WEBrick 1.7.0
[2021-06-28 17:10:18] INFO  ruby 2.7.0 (2019-12-25) [x86_64-linux-gnu]
== Sinatra (v2.1.0) has taken the stage on 4567 for production with backup from WEBrick
[2021-06-28 17:10:18] INFO  WEBrick::HTTPServer#start: pid=1029472 port=4567
```

## WSL里安装

从零开始安装ruby：

https://rvm.io/

```sh
$ sudo apt install gpgv2
$ gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
$ curl -sSL https://get.rvm.io | bash -s stable --rails
$ source ~/.rvm/scripts/rvm
```

直接安装：

```sh
$ gem install gollum
```

运行：

```sh
gollum
```

在外面的win10浏览器打开[http://localhost:4567](http://localhost:4567)就可以直接访问了。

但WSL不支持systemd？

有时候却访问不了，wsl --shutdown，关了重启wsl，又可以了。

https://github.com/microsoft/WSL/discussions/2471

## mac安装

更新ruby源：

```sh
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
$ gem sources -l
https://gems.ruby-china.com
# 确保只有 gems.ruby-china.com
```

安装：

https://github.com/gollum/gollum/wiki/Installation#os-x

```sh
brew install icu4c
sudo gem install charlock_holmes -- --with-icu-dir=/usr/local/opt/icu4c
sudo gem install gollum
```

## 使用service

https://github.com/gollum/gollum/wiki/Gollum-as-a-service

示例：`gollum@.service`表示支持以user来使用。

```
$ sudo cat /etc/systemd/system/gollum@.service
[Unit]
Description=Gollum wiki server

[Service]
Type=simple
User=%i
ExecStart=-/usr/local/bin/gollum --allow-uploads dir "/home/lzy/Nutstore Files/Nutstore/wiki"
Restart=on-abort

[Install]
WantedBy=multi-user.target
```

```sh
sudo systemctl start gollum@lzy.service
sudo systemctl enable gollum@lzy.service
```

## 注意

仓库的.git目录必须在当前repo下，不能在外部（separate dir）。要不然image的路径解析有问题，导致不显示。

gollum还不支持直接粘贴截图。

---

TOC使用：https://github.com/gollum/gollum/wiki#table-of-contents-toc-tag

```
[ [_TOC_]]
```

注：括号间没有空格。奇怪的是，TOC在代码块里也会自动展开。

这个typora也能识别。

---

链接：

```
[link](link)
```

typora仍会显示中括号。

---

直接嵌入其他页面：https://github.com/gollum/gollum/wiki#include-tag

```
[include:path-to-page](include:path-to-page)
```

中间不要有空格。

---

Preview的时候图片显示是坏的？

## 图标

页面tab里的图标显示，找一张图片放到根目录，命名为favicon.ico，然后git commit加入仓库就可以了。

## Sidebar，边栏

边栏常驻右边，可将常用的链接放到里面。

参考仓库里的`_Sidebar.md`。

## 自定义css

参考仓库里的`custom.css`。

https://github.com/gollum/gollum/wiki/Custom-Styling-and-Views