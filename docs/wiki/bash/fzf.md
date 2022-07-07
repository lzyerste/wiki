---
aliases:
- fzf
title: fzf
---

#fzf #神器 #必备

# fzf，命令行模糊查询

[junegunn/fzf](https://github.com/junegunn/fzf)

[每天学习一个命令：fzf 使用笔记 | Verne in GitHub](https://einverne.github.io/post/2019/08/fzf-usage.html)

## 源码安装

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
```

```bash
~/.fzf/install
```

安装过程中同意设置快捷键。

在命令行中，仍然使用快捷键Ctrl+R来搜索历史记录，可以提供多个关键字模糊搜索。

## 快捷键

ctrl+j或者ctrl+n，select next

ctrl+k或者ctrl+p，select prev

因为tmux使用了ctrl+j/k，所以建议使用ctrl+p/n

## 修改高亮颜色

[https://github.com/junegunn/fzf/wiki/Color-schemes](https://github.com/junegunn/fzf/wiki/Color-schemes)

One Dark:

```python
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'
```