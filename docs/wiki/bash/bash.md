---
title: bash
---

#bash

[TOC]

[bash语法检查](bash语法检查.md)

[bash基本语法](bash基本语法.md)


## 资源

[Bash Scripting Tutorial for Beginners](https://linuxconfig.org/bash-scripting-tutorial-for-beginners)

https://github.com/Idnan/bash-guide

[Linux命令搜索引擎 命令，Linux Linux命令搜索引擎 命令详解：最专业的Linux命令大全，内容包含Linux命令手册、详解、学习，值得收藏的Linux命令速查手册。 - Linux 命令搜索引擎](https://wangchujiang.com/linux-command/)

[Idnan/bash-guide](https://github.com/Idnan/bash-guide)

[Bash 脚本教程](https://wangdoc.com/bash/)

[dylanaraps/pure-bash-bible](https://github.com/dylanaraps/pure-bash-bible)


## if

```
if [ <some test> ]; then
	<commands>
elif [ <some test> ]; then
	<different commands>
else
	<other commands>
fi
```

## for

[Bash For Loop](https://linuxize.com/post/bash-for-loop/)

```bash
for i in {0..3}
do
  echo "Number: $i"
done
```

```cpp
BOOKS=('In Search of Lost Time' 'Don Quixote' 'Ulysses' 'The Great Gatsby')

for book in "${BOOKS[@]}"; do
  echo "Book: $book"
done
```

## 不报错误

https://serverfault.com/questions/153875/how-to-let-cp-command-dont-fire-an-error-when-source-file-does-not-exist

`set -e`情况下，有时候想忽略一些错误。

```sh
cp ./src/*/*.h ./aaa 2>/dev/null || :
```

也就是`|| :`。

## 字符串替换

https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script

```sh
#!/bin/bash
firstString="I love Suzi and Marry"
secondString="Sara"
echo "${firstString/Suzi/$secondString}"    
# prints 'I love Sara and Marry'
```

## 输出重定向，stdout，stderr

```sh
redirect stderr to stdout ( 2>&1 )
```

重定向输出时，stdout可能有buffer，所以不一定会立马输出，可以使用[script](script.md)命令来执行程序，强行输出。

## 统计文件数量

[统计文件数量](统计文件数量.md)

## 其他，TODO

- `删除文件：模式匹配`
    
    ```bash
    find . -name '*.orig' #-delete
    ```
    
    确定要删除时将注释符号`#`删掉
    
    [How do I remove all files that match a pattern?](https://askubuntu.com/questions/43709/how-do-i-remove-all-files-that-match-a-pattern)
    
- `history`，查看历史命令记录
    
    显示时间：
    
    ```bash
    HISTTIMEFORMAT="%d/%m/%y %T "
    history
    ```
    
    [How to see time stamps in bash history?](https://askubuntu.com/questions/391082/how-to-see-time-stamps-in-bash-history)
    
- 批量`替换TAB`为4个空格
    - macOS，比如所有txt文件
        
        ```python
        sed -i '' $'s/\t/    /g' *.txt
        ```
        
        [How can I convert tabs to spaces in every file of a directory?](https://stackoverflow.com/questions/11094383/how-can-i-convert-tabs-to-spaces-in-every-file-of-a-directory)