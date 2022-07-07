---
title: vscode
---

#vscode #神器 #必备 

# vscode

- 配置同步：使用Settings Sync插件（不使用vscode自带sync）
    - [https://gist.github.com/lzyerste/444ea2413fcc574ae506f55467d938e2](https://www.notion.so/444ea2413fcc574ae506f55467d938e2)
    - 主要同步系统设置及快捷键习惯。
    - 支持多个平台，Ubuntu及Mac，以Ubuntu习惯为准。Ubuntu跟Mac有各自的快捷键文件，注意同步。
    - 不同机器使用的插件不一样，所以可以不强制同步。

[远程开发，支持跳板机](../vscode/远程开发，支持跳板机.md)

[隐藏文件](../vscode/隐藏文件.md)

[搜索私有函数](../vscode/搜索私有函数.md)

[Ubuntu下终端不显示下划线](../vscode/Ubuntu下终端不显示下划线.md)

[调试Python的时候，报错add_command](../vscode/调试Python的时候，报错add_command.md)

[头文件搜索](../vscode/头文件搜索.md)

[占用磁盘空间，缓存](../vscode/占用磁盘空间，缓存.md)

[代码提示出问题](../vscode/代码提示出问题.md)

# 插件推荐

## One Dark Pro，主题

❤❤❤❤❤

## Vim

❤❤❤❤❤

使用vim模式。

## GitLens

❤❤❤❤❤

每行显示git信息。可能会比较耗资源，可以进入Zen模式。

## C/C++相关插件

- C++ Intellisense：依赖gtags
- C/C++ for Visual Studio Code
- Fuzzy Tag For C/C++：模糊搜索，ctags，F10
- Doxygen Documentation Generator：生成注释文档模板
- ~~C/C++ GNU Global~~

需要搭配好c++配置文件，选好include路径。

## Settings Sync，同步配置

使用gist。

## Bracket Pair Colorizer，括号颜色高亮

比较耗资源。

## TabNine，AI代码提示

比较耗资源。

## Git Graph

在vscode里较好地图形化显示git信息，与remote ssh集成较好，勉强替换下sublime merge。

---

升级vscode后，git graph界面不显示，报错webview相关。

解决：退出vscode，然后搜索vscode进程，彻底杀掉，重新进入vscode。

```c
$ ps -ef | grep code/code

lzy        13292    2195  0 Jul12 ?        00:22:56 /usr/share/code/code --no-sandbox --unity-launch

$ sudo kill -9 13292
```

# Tips

## ssh不能保存

检查下目录的权限，用户名是否是自己，有可能变为root了。