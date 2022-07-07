---
title: vim
---

#vim #神器 #必备

[vim_old](vim_old.md)

.vimrc位置: config/.vimrc

[★vim8推荐配置](../other/software/vim/★vim8推荐配置.md)

https://learnbyexample.github.io/vim_reference/

# vim new

## macro

q号macro，先将选中的复制，然后两边加引用符号：

`@q`触发，可以再映射成快捷键ge。

```
qqc``<ESC>hpq
```

h号macro，先将选中的复制，然后两边加高亮符号`==`：

`@h`触发，可以再映射成快捷键gh。

```
qhc====<ESC>hhpq
```

---

日记模板替换标题：

```
qt/''<ENTER>pq
```

日记模板替换图片路径：

```
qp/timeline.png<ENTER>vt'pq
```

## 搜索&替换

https://vim.fandom.com/wiki/Search_and_replace

`/`触发搜索。

替换所有行：

```
:%s/foo/bar/g
```

替换当前行：

```
:s/foo/bar/g
```

## 二进制文件查看及编辑

[How can I use Vim as a hex editor?](https://vi.stackexchange.com/questions/2232/how-can-i-use-vim-as-a-hex-editor)

打开的时候加上参数`-b`，要不然文件末尾会多个换行符。

```c
vim -b <filename>
```

二进制转可视化文本：

```bash
:%!xxd
```

样式：

```bash
0000000: 5468 6973 2069 7320 6120 7465 7374 0a41  This is a test.A
0000010: 6e6f 7468 6572 206c 696e 650a 416e 6420  nother line.And 
0000020: 7965 7420 616e 6f74 6865 720a            yet another.
```

文本转回二进制（显示乱码不用管）：

```bash
:%!xxd -r
```

---

如果要修改二进制文件的话，比如删除中间的某几行，可以使用如下方式编辑：

```c
:%!xxd -p -c 32
```

这样打开的话，只显示二进制文本，之前的第一列跟最后列的信息就不显示了。

`-c 32`表明一行显示32个字节，方便计算。

修改完之后，使用如下命令保存：

```c
:%!xxd -p -r
```

## tips

### 左右两个窗口一起滚动

```
:windo set scrollbind
```

### vib: 选中括号里内容

https://stackoverflow.com/questions/1061933/how-to-select-between-brackets-or-quotes-or-in-vim

如果有多层级嵌套，vib选中之后，继续按`ib`就会选中下一级。

### vim启动时hang住

> [!faq]+ wsl中vim启动时hang住
> 使用`strace vim`跟踪hang在哪里，跟X11有关，是不是跟之前的gwsl有关？
> 开着gwsl恢复正常了，跟windows间的复制粘贴也都正常。
> 如果`vi -X <file>`的话，能正常编辑，但复制粘贴有问题。