---
title: 安装vim_8_2
---

# 安装vim 8.2

[How to Install Latest Vim 8.2 on Ubuntu](https://itsfoss.com/vim-8-release-install/)

```bash
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
```

注意：安装完之后，`vim --version`是没有clipboard的，但重新安装vim-gtk后就可以了。