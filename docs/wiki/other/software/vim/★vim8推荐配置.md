---
title: ★vim8推荐配置
---

#vim

[vim](../../../bash/vim.md)

2020-12-19

# vim8推荐配置

安装vim-gtk即可，自带clipboard、python3。

---

与终端zsh（Dracula主题）、tmux（Dracula主题）搭配使用。

1. 安装vim8，注意带lua，clipboard，python3
2. 我的.vimrc文件。删除旧的配置，包括~/.vim目录
   
	.vimrc: config/.vimrc
   
3. 安装插件管理`vim-plug`。打开vi，输入命令`:PlugInstall`安装插件，:PlugStatus可查看插件状态。
   
    目前使用的插件有LeaderF，~~SuperTab~~，YouCompleteMe，vim-polyglot。
    
4. ~~vimdiff使用的主题建议github~~

注意：代码自动提示不够智能。

## 常用操作

[快捷键](../../../../personal/other/快捷键.md)

## 安装指南

- 安装vim8，支持lua跟clipboard和python3，没必要源码安装。
  
    如果没有clipboard支持，可能是系统没按照相关依赖库（也可以先apt试下安装`vim-gtk`）。
    
    ```jsx
    sudo apt-get install vim-gtk
    ```
    
    ```jsx
    ./vim --version
    8.2
    +clipboard
    +python3
    +lua
    ```
    
- 安装插件管理器vim-plug
  
    ```jsx
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```
    
- 使用配置文件.vimrc
- 安装插件~~SuperTab~~和LeaderF、YouCompleteMe
  
    打开vi
    
    :PlugInstall
    
    ---
    
    YouCompleteMe需要特别安装（使用特定commit，老版本）：
    
    ```jsx
    d91e0f03e2e88bc563ffe4c8f7901b0beb2a7d4f
    ```
    
    ```jsx
    cd YouCompleteMe
    python3 [install.py](http://install.py/) --clang-completer
    ```
    
- ~~github主题，用于diff~~
  
    ```jsx
    curl -fLo ~/.vim/colors/github.vim --create-dirs https://raw.githubusercontent.com/endel/vim-github-colorscheme/master/colors/github.vim
    ```