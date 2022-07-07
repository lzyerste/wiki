---
title: sed
---

#todo 

优先使用perl？

[grep](grep.md)

[awk](awk.md)

[perl](perl.md)

## 替换http标签

```shell
# [http://asdf.html](http://asdf.html) -> [link](http://asdf.html)
sed -i 's/\[http.*\]/\[link\]/g' *
```

## 替换资治通鉴标题，group

```shell
# 原始： **太祖圣神恭肃文孝皇帝上广顺元年（辛亥，公元九五一年）**
# 替换： ## 太祖圣神恭肃文孝皇帝上广顺元年（辛亥，公元九五一年）
sed -i 's/\*\*\(.*年.*（.*）.*\)\*\*/## \1/g' *
```

## 例子：替换`</p><p>`为换行

处理《史记》

```bash
sed -i 's/<\/p><p>/\n\n/g' *.md
```