---
title: wsl2
---

[gwsl](gwsl.md)

# WSL 2

[wsl安装](WSL 2 7e30758ca8f044d08016c0451e67f49b/wsl安装.md)

[解决ssh](WSL 2 7e30758ca8f044d08016c0451e67f49b/解决ssh 2aa860c5a77f4db3806729380a832928.md)

[解决代理](WSL 2 7e30758ca8f044d08016c0451e67f49b/解决代理 bdd1c464031d413a84f8ba1671f99c60.md)

- 安装zsh，顺畅
- 安装fzf，顺畅
- 安装tmux，顺畅

[安装vim](WSL 2 7e30758ca8f044d08016c0451e67f49b/安装vim d95847566977403e94eb0366430cf166.md)

[windows10下wsl系统权限问题及带来的影响 - 简书](WSL 2 7e30758ca8f044d08016c0451e67f49b/windows10下wsl系统权限问题及带来的影响 - 简书 da02367a9e7745a2ae33a1776970a4e7.md)

## 启动失败：参考的对象类型不支持

[https://github.com/microsoft/WSL/issues/4194](https://github.com/microsoft/WSL/issues/4194)

管理员身份打开命令行终端：

```jsx
netsh winsock reset
```

## wsl关机

```bash
wsl --shutdown
```

## ssh自动启动

https://gist.github.com/dentechy/de2be62b55cfd234681921d5a8b6be11?permalink_comment_id=3036911#gistcomment-3036911

```c
Another way without Task Scheduler:

1.  On the WSL put to the end of the `/etc/sudoers` file the following line:  
    `%sudo ALL=NOPASSWD: /etc/init.d/ssh start`
    
2.  Put to the `shell:Startup` folder `bat` file with the content:  
    `powershell.exe "& 'C:\Windows\System32\bash.exe' -c 'sudo /etc/init.d/ssh start'"`
    

That's it!
```