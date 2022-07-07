---
title: tmux
---

#tmux #神器 #必备

## tmux

.tmux.conf: config/.tmux.conf

```python
# 极速安装法（最好加上科学上网）：
1. 复制`.tmux.conf`文件，放到主目录
2. git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
3. 打开tmux，Ctrl+B, Shift+I，安装插件
4. source配置：Ctrl+B, Shift+:，输入命令source ~/.tmux.conf
```

下面可以不看。

---

推荐主题：Dracula（插件形式）

快速安装：

可命令行直接安装，注意版本。

```cpp
# ubuntu 18.04直接安装，版本为2.6。
# ubuntu 16.04直接安装，版本为2.1。
sudo apt install tmux

# centos 7默认安装的版本比较低
wget http://mirror.ghettoforge.org/distributions/gf/el/7/plus/x86_64/tmux-2.4-2.gf.el7.x86_64.rpm
sudo rpm -ivh --force tmux-2.4-2.gf.el7.x86_64.rpm
```

极简快速配置：

```cpp
vi ~/.tmux.conf

内容为：
set -g mouse on
set -g mode-keys vi
set -g history-limit 50000
```

---

[tmux，我的配置](tmux/tmux，我的配置%2088e04fb489db455da93bcddb8e6c0821.md)

[安装tmux-continuum](tmux/安装tmux-continuum%20fb66ac810d08446f9b32c4e4e1f5cd83.md)

[Tmux Cheat Sheet & Quick Reference](https://tmuxcheatsheet.com/)

[配置参考](tmux/配置参考%2016bd54c9071446e086cc99d400ecd44b.md)

[mac iterm2 tmux鼠标不起作用](tmux/mac%20iterm2%20tmux鼠标不起作用%204a418341012b4d229f44981418e3fcf0.md)

[mac一打开就crash](tmux/mac一打开就crash%204ff156e6d60846b7834b4872028d4f84.md)

## ⭐插件：tmux-logging

[tmux-logging](https://github.com/tmux-plugins/tmux-logging)

目前是针对单个pane。

> [!NOTE]+ 功能一：Logging
> 
> 需要手工开启，攒了一定buffer后，会输入到文件。
> 
> Toggle (start/stop) logging in the current pane.
> 
> -   Key binding: `prefix + shift + p`
> -   File name format: `tmux-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log`
> -   File path: `$HOME` (user home dir)
>     -   Example file: `~/tmux-my-session-0-1-20140527T165614.log`

> [!NOTE]+ 功能二："Screen Capture"
> 
> 类似截屏，获取当前pane的一页内容。
> 
> Save visible text, in the current pane. Equivalent of a "textual screenshot".
> 
> -   Key binding: `prefix + alt + p`
> -   File name format: `tmux-screen-capture-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log`
> -   File path: `$HOME` (user home dir)
>     -   Example file: `tmux-screen-capture-my-session-0-1-20140527T165614.log`

> [!NOTE]+ 功能三：Save complete history
> 
> 保存当前pane的所有历史记录
> 
> Save complete pane history to a file. Convenient if you retroactively remember you need to log/save all the work.
> 
> -   Key binding: `prefix + alt + shift + p`
> -   File name format: `tmux-history-#{session_name}-#{window_index}-#{pane_index}-%Y%m%dT%H%M%S.log`
> -   File path: `$HOME` (user home dir)
>     -   Example file: `tmux-history-my-session-0-1-20140527T165614.log`

## ⭐保存scroll buffer内容到文件，使用插件logging

https://unix.stackexchange.com/a/26568

**可以手工在tmux控制板里敲命令，`<prefix> :`，再敲命令。**

分两步：将当前pane的内容保存到buffer（`capture-pane -S -`）；然后将buffer保存到文件（`save-buffer tmux.buffer`）。

可以绑定到快捷键：

```
# <prefix>+P
bind-key P 'capture-pane -S - ; save-buffer tmux.buffer'
```

但是树莓派上绑定key不成功。

## ⭐自动化脚本

比如创建一个window，自动化布局好，并各自ssh连接到机器。

autotmux: ../../config/tmux/autotmux

可以放到~/.local/bin下，制作成命令。

```bash
#!/bin/bash

tmux new-window -n temp -c "~" 'ssh hjb-pi -t "tmux a -t 0"'

tmux split-window -h -t 0:temp.0 -c "~" 'ssh hjb-test'
tmux split-window -v -t 0:temp.1 -c "~" 'ssh hjb-test'

tmux split-window -v -t 0:temp.0 -c "~" 'ssh hjb-pi'
tmux split-window -v -t 0:temp.1 -c "~" 'ssh hjb-test'

tmux split-window -h -t 0:temp.1 -c "~" 'ssh hjb-pi'
tmux split-window -h -t 0:temp.1 -c "~" 'ssh hjb-pi'
tmux split-window -h -t 0:temp.3 -c "~" 'ssh hjb-pi'

tmux split-window -h -t 0:temp.5 -c "~" 'ssh hjb-test'
tmux split-window -h -t 0:temp.5 -c "~" 'ssh hjb-test'
tmux split-window -h -t 0:temp.7 -c "~" 'ssh hjb-test'
```

效果：

![Pasted image 20220216173617](assets/Pasted%20image%2020220216173617.png)

## 不同屏幕大小

```cpp
# 再次进入时使用 -d 参数：
tmux a -d -t [YOUR TMUX NAME]
```

## scroll buffer里搜索

[How can I search within the output buffer of a tmux shell?](https://superuser.com/questions/231002/how-can-i-search-within-the-output-buffer-of-a-tmux-shell)

使用vi的模式

## 复制粘贴内容

[tmux的复制粘贴 - weiyinfu - 博客园](https://www.cnblogs.com/weiyinfu/p/10462738.html)

```cpp
1. C-b [ 进入复制模式（或者鼠标滚轮
2. 参考上表移动鼠标到要复制的区域，移动鼠标时可用vim的搜索功能"/","?"
3. 按空格键开始选择复制区域
4. 选择完成后安**enter**键退出
5. C-b ] 粘贴
```

```python
linux下按住shift键来选择，然后ctrl+shift+c来拷贝

macos下按住alt键然后选择，cmd+c来拷贝
```

## 清除缓存

C-b :

clear-history