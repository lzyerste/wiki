---
title: mac下安装hg（mercurial）
---

# mac下安装hg（mercurial）

命令：brew install hg

遇到问题：

```python
Error: An unexpected error occurred during the `brew link` step
The formula built, but is not symlinked into /usr/local
Permission denied @ dir_s_mkdir - /usr/local/Frameworks
Error: Permission denied @ dir_s_mkdir - /usr/local/Frameworks
```

解决办法：这把/usr/local的权限都给了自己，会不会有安全问题？

```python
brew doctor

sudo chown -R $(whoami) $(brew --prefix)/*

sudo install -d -o $(whoami) -g admin /usr/local/Frameworks
```

[Error: An unexpected error occurred during the `brew link` step · Issue #645 · jakubroztocil/httpie](https://github.com/jakubroztocil/httpie/issues/645)