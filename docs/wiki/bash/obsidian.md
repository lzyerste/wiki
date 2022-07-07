---
aliases:
- ob
title: obsidian
---

#markdown #vim #obsidian #神器 #必备

[obsidian](https://obsidian.md/)：非常优秀。

帮助文档： https://help.obsidian.md/Obsidian/Index

markdown文件管理及浏览使用obsidian，编辑可使用[typora](../other/software/typora.md)，自带的编辑也基本满足需求了，表格弱一点。

- [x] 写个脚本，导出一个md文档，连带它的引用，主要是图片，也可以是其他附件，比如pdf，xlsx。 ⏫ ✅ 2022-02-02

# 快捷键

- Ctrl+P: 快速打开文件。这是修改过的，原来默认是Ctrl+O。
- Ctrl+Shift+P: 快速打开控制面板。原来默认是Ctrl+P。
- Ctrl+T: 使用默认APP打开文件，比如Typora。
- Ctrl+O: 浏览往后退
- Ctrl+I: 浏览往前进，原来是作为斜体效果的。
- gd / Alt+Enter: 链接跳转，vim模式下也有效。
- ge: inline code
- gh: 高亮所选
- gl: 变成wiki链接
- Ctrl+Shift+H: 选择左边的pane
- Ctrl+Shift+L: 选择右边的pane
- Win + '.'是跳出表情包，但只能点击选择，不能搜索？❤🧡💛💚⭕❌❓❎✅

# 优点
- 支持tag
- 支持alias别名
- 支持双链: `[link](link)`，link就是文件名，不用全路径，如果有文件重名它才会全路径区分。文件重命名后（文件夹也可以），会提示更新双链。
- 支持vim模式
- 跨平台完美。包括插件同步，包括当前打开的状态。
- 可以直接粘贴图片。
- 直接内嵌md文件，类似插入图片，会直接显示内容。但是没有outline。而且是固定高度的frame。
- 插件丰富。
- 可以学英语、背单词、背古汉语

# 缺点

- [x] 导出 pdf 时，没有标签，mermaid 没有缩放，超出页面的就截掉了。建议使用 typora 转换。
- [x] 文件内，跳转标题。有插件可以做，但好像也没太大必要。 ✅ 2022-01-21
- [x] 预览模式下没有vim mode，类似chrome浏览器的vimium？可以尽量呆在编辑模式。一直呆在编辑模式，使用vim即可。
- [x] vim模式下，怎么打开链接？ctrl+], ctrl+enter。修改配置，支持`gd`了。
  ```
  exmap follow obcommand editor:follow-link
  nmap gd :follow
  ```
- [x] vim模式下，easymotion？插件，`ctrl+;`
- [x] ~~emoji不支持？`:emoji:`形式。可以使用插件。~~

# 插件

## consistent

它把附件挪到文档本地

![Pasted image 20220502132956](assets/Pasted%20image%2020220502132956.png)

## calendar，3星

日历，适合当天日志，不好任意跳转。

## emoji shortcodes，4星

#emoji

| emoji | unicode name                    |
| ----- | ------------------------------- |
| ✅    | `:white_check_mark:`            |
| ❎    | `:negative_squared_cross_mark:` |
| ⌛    | `:hourglass:`                   |
| ⭐    | `:star:`                        |
| 💡    | `:bulb:`                        |
| ❤     | `:heart:`                       |
| ❌    | `:x:`                           |
| 💖    | `:sparkling_heart:`             |
| ⏫    | `:arrow_double_up`              | 

## kanban，4星

使用一个md文件来做kanban。

![Pasted image 20220117100624](assets/Pasted%20image%2020220117100624.png)

## link-converter，4星

https://github.com/ozntel/obsidian-link-converter

移动文件时，有些url的相对路径其实已经不对了（比如在typora中显示不了图片），但在obsidian中仍能正常显示。这是因为obsidian认为这个文件名唯一？

插件link-converter可以不管三七二十一，直接在文件上右键选择`All Links to Relative Path`，就会把文件内的链接转为相对路径。

但是目前会把文件扩展名给省略掉。

## remember cursor position，4星

记得文档上一次打开的位置。

## ⭐ tasks，5星

https://github.com/schemar/obsidian-tasks

https://schemar.github.io/obsidian-tasks/queries/

## ⭐ templater，5星

模板，比ob自带的要好。

## ⭐ text-snippets-obsidian

snippets展开

## ⭐ timelines，5星

时间轴显示，比如日记。

## ⭐ vimrc-support，5星

https://github.com/esm7/obsidian-vimrc-support

文件名为`.obsidian.vimrc`。

```sh
" keymap
"imap jj <C-[>
imap jj <Esc>
"imap <C-o> <Esc><C-o>
nmap f }zz
nmap F <C-d>zz
nmap b {zz
nmap B <C-u>zz
"noremap gD <C-]>
exmap follow obcommand editor:follow-link
nmap gd :follow
" Yank to system clipboard
set clipboard=unnamed
```

## excalidraw

![](assets/obsidian%202022-05-10%2009.29.45.excalidraw.md)

# TIPS

## 代码块里换行

插件spaced repetition，浏览的时候，代码块里没有换行。

解决：增加自定义CSS

https://stackoverflow.com/questions/248011/how-do-i-wrap-text-in-a-pre-tag

```
pre {
    white-space: pre-wrap;       /* Since CSS 2.1 */
}
```

## callout

https://help.obsidian.md/How+to/Use+callouts

> [!NOTE]+ note
> Contents

> [!abstract]+ abstract
> Contents

> [!info]+ info
> Contents

> [!todo]+ todo
> Contents

> [!tip]+ tip, hint, important
> Contents

> [!success]+ success, check, done
> Contents

> [!faq]+ faq, help, question
> Contents

> [!warning]+ warning, caution, attention
> Contents

> [!failure]+ fail, failure, missing
> Contents

> [!error]+ error, danger
> Contents

> [!bug]+ bug
> Contents

> [!example]+ example
> Contents

> [!quote]+ quote, cite
> Contents

## 高亮

https://stackoverflow.com/a/63851626/1148981

```
==高亮文字==
```

效果：

==高亮文字==

用作一问一答不错，高亮表示问题。

## 图片大小

显示400宽度的图片：

```
![400](image%20file)
```

## 块引用

比如引用另一个页面里的某个heading，甚至某个block。

标题引用： https://help.obsidian.md/How+to/Internal+link#Link+to+headings

`[[`选择页面之后敲`#`来搜索。

块引用： https://help.obsidian.md/How+to/Link+to+blocks

`[[`选择页面之后敲`^`来搜索。

## ubuntu安装没有图标

直接运行appimage，没有图标。

先安装[AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher)，然后打开appimage，会提示安装。再次打开就正常了（Win搜索）。

## alias文件别名

https://help.obsidian.md/How+to/Add+aliases+to+note

比如给文件`btn_cmd_t`加个别名`bcmd`：

```
---
aliases: [bcmd]
---
```

这一段代码要放到文件最开头。

## 代码块中高亮，使用pre标签

高亮文本颜色选用粉色（hotpink）：`FF69B4`，<font color="FF69B4"> 效果 </font>

<pre>
<mark style="background: #FF5582A6;">for i in range(10):</mark> 
	print(i)
</pre>

```
cpu1: Zone 1581: IMP_OPEN spb=1866, spb_ec=6, spb_sn=8901
cpu1: actv_ctx=2 wp=C5A00070 dtag_cnt=0 receive_index=0 program_index=0, seq:0x19A95CC2
cpu1: Zone 1584: FULL spb=1685, spb_ec=6, spb_sn=8876
cpu1: Zone 1593: FULL spb=1818, spb_ec=6, spb_sn=8897
```

<pre style="font-family: Source Code Pro, Cascadia Code, monospace; font-size: 14px;">
cpu1: Zone 1581: IMP_OPEN spb=1866, spb_ec=6, spb_sn=8901
cpu1: actv_ctx=2 wp=C5A00070 dtag_cnt=0 receive_index=0 program_index=0, seq:0x19A95CC2
cpu1: Zone 1584: FULL spb=1685, spb_ec=6, spb_sn=8876
cpu1: Zone 1593: FULL spb=1818, spb_ec=6, spb_sn=8897
cpu1: Zone 1602: FULL spb=1843, spb_ec=5, spb_sn=8848
cpu1: Zone 1617: FULL spb=1697, spb_ec=6, spb_sn=8877
cpu1: Zone 1640: FULL spb=1602, spb_ec=5, spb_sn=8820
cpu1: Zone 1662: FULL spb=1684, spb_ec=6, spb_sn=8875
cpu1: Zone 1673: IMP_OPEN spb=1835, spb_ec=6, spb_sn=8899
<font color="FF69B4">cpu1: actv_ctx=0 wp=D12000D2 dtag_cnt=100 receive_index=0 program_index=0, seq:0x19A95CC0</font>
cpu1: Zone 1697: FULL spb=1620, spb_ec=5, spb_sn=8822
cpu1: Zone 1702: FULL spb=1498, spb_ec=4, spb_sn=8776
cpu1: Zone 1703: FULL spb=1842, spb_ec=5, spb_sn=8847
cpu1: Zone 1707: FULL spb=1605, spb_ec=5, spb_sn=8821
cpu1: Zone 1757: FULL spb=1865, spb_ec=5, spb_sn=8850
cpu1: Zone 1761: IMP_OPEN spb=1854, spb_ec=6, spb_sn=8900
<mark>cpu1: actv_ctx=1 wp=DC2000A6 <font color="FF69B4">dtag_cnt</font>=54 receive_index=0 program_index=0, seq:0x19A95CC1</mark>
<font color="FF1493">cpu1: Zone 1787: FULL spb=1527, spb_ec=4, spb_sn=8777</font>
<font color="FF5582A6">cpu1: Zone 1793: FULL spb=1572, spb_ec=5, spb_sn=8819</font>
<font color="FF69B4">cpu1: Zone 1813: IMP_OPEN spb=1867, spb_ec=6, spb_sn=8902</font>
cpu1: actv_ctx=3 <font color="FF69B4">wp=E2A0003C</font> <font color="FF1493">dtag_cnt=0</font> receive_index=0 <font color="00FF7F">program_index=0</font>, seq:0x19A95CC3
cpu1: Zone 1817: FULL spb=1844, spb_ec=5, spb_sn=8849
cpu1: Zone 1849: FULL spb=1819, spb_ec=6, spb_sn=8898
cpu1: Active zones=4 others=1511 capacity=0011B800 size=00200000 dtags=154
</pre>

> [!tip]+ 太亮了
> 
> 比如引用另一个页面里的某个<font color="FF1493">heading</font>，甚至某个block。
> 
> <mark>比如引用另一个页面里的某个<font color="FF1493">heading</font>，甚至某个block。</mark>
> 
> <font color="FF1493">比如引用另一个页面里的某个<font color="FF1493">heading</font>，甚至某个block。</font>

> [!tip]+ 当前
> 
> 比如引用另一个页面里的某个<font color="FF69B4">heading</font>，甚至某个block。
> 
> <mark>比如引用另一个页面里的某个<font color="FF69B4">heading</font>，甚至某个block。</mark>
> 
> <font color="FF69B4">比如引用另一个页面里的某个<font color="FF69B4">heading</font>，甚至某个block。</font>

> [!tip]+ highlight red
> 
> 比如引用另一个页面里的某个<font color="#FF5582A6">heading</font>，甚至某个block。
> 
> <font color="FF5582A6">比如引用另一个页面里的某个<font color="#FF5582A6">heading</font>，甚至某个block。</font>
> 
> <mark>比如引用另一个页面里的某个<font color="#FF5582A6">heading</font>，甚至某个block。</mark>

> [!tip]+ highlight pink
> 
> 比如引用另一个页面里的某个<font color="#FFB8EBA6">heading</font>，甚至某个block。
> 
> <font color="FFB8EBA6">比如引用另一个页面里的某个<font color="#FFB8EBA6">heading</font>，甚至某个block。</font>
> 
> <mark>比如引用另一个页面里的某个<font color="#FFB8EBA6">heading</font>，甚至某个block。</mark>

深色主题效果：

![Pasted image 20220424175829](assets/Pasted%20image%2020220424175829.png)

![Pasted image 20220424175921](assets/Pasted%20image%2020220424175921.png)

---

<mark style="background: #FF5582A6;">highlight red</mark> 

<mark style="background: #FFB8EBA6;">highlight pink</mark> 

# 发布？

Hugo，Zola，Quartz，Netlify

wikmd?

mkdocs? https://github.com/mkdocs/mkdocs/

## Hugo

可以本地托管。

## ⭐Quartz

托管在github pages

## 添加hugo front matter

yaml格式，需要提供title字段。

https://www.sametbh.com/docs/64-programming/static-site-generators/hugo/frontmatter-tools/

> [!NOTE]+ Python Frontmatter
> https://python-frontmatter.readthedocs.io/en/latest/index.html
> 这个Python库不错，可以解析文本的metadata跟content，那就自己编程来统一改。
>
> ```bash
> find . -name "*.md" -print0 | xargs -0 -I file python3 hugo_frontmatter.py file
> ```

# 资源

https://github.com/kmaasrud/awesome-obsidian

> [!NOTE]+ [Markdownload](https://github.com/deathau/markdown-clipper)
> 
> A Firefox and Google Chrome extension to clip websites and download them into a readable markdown file.
