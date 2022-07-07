---
title: bash基本语法
---

# bash基本语法

# 语法

## if

[](https://linuxize.com/post/bash-if-else-statement/)

```c
#!/bin/bash

echo -n "Enter a number: "
read VAR

if [ $VAR -gt 10 ](%20$VAR%20-gt%2010%20)
then
  echo "The variable is greater than 10."
elif [ $VAR -eq 10 ](%20$VAR%20-eq%2010%20)
then
  echo "The variable is equal to 10."
else
  echo "The variable is less than 10."
fi
```

### 逻辑or

[In a bash script, using the conditional "or" in an "if" statement](https://unix.stackexchange.com/questions/47584/in-a-bash-script-using-the-conditional-or-in-an-if-statement)

```c
if [ "$fname" = "a.txt" ] || [ "$fname" = "c.txt" ]
```

## case

[](https://linuxize.com/post/bash-case-statement/)

```c
#!/bin/bash

echo -n "Enter the name of a country: "
read COUNTRY

echo -n "The official language of $COUNTRY is "

case $COUNTRY in

  Lithuania)
    echo -n "Lithuanian"
    ;;

  Romania | Moldova)
    echo -n "Romanian"
    ;;

  Italy | "San Marino" | Switzerland | "Vatican City")
    echo -n "Italian"
    ;;

  *)
    echo -n "unknown"
    ;;
esac
```

# 常用功能

## 变量是否存在

[How to check if a variable is set in Bash?](https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash)

```c
if [ -z ${var+x} ]; then echo "var is unset"; else echo "var is set to '$var'"; fi
```

## 字符串大小写替换

[How to convert a string to lower case in Bash?](https://stackoverflow.com/questions/2264428/how-to-convert-a-string-to-lower-case-in-bash)

```c
$ string="A FEW WORDS"
$ echo "${string,}"
a FEW WORDS
$ echo "${string,,}"
a few words
$ echo "${string,,[AEIUO]}"
a FeW WoRDS

$ string="A Few Words"
$ declare -l string
$ string=$string; echo "$string"
a few words
```

## 字符串替换

[Replace one substring for another string in shell script](https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script)

```c
#!/bin/bash
firstString="I love Suzi and Marry"
secondString="Sara"
echo "${firstString/Suzi/$secondString}"    
# prints 'I love Sara and Marry'
```

## 字典定义？

[How to define hash tables in Bash?](https://stackoverflow.com/questions/1494178/how-to-define-hash-tables-in-bash)

```c
declare -A animals=( ["moo"]="cow" ["woof"]="dog")
```

## 字典查找

[Best/optimized way to search/lookup text in a file in BASH scripts](https://stackoverflow.com/questions/55164148/best-optimized-way-to-search-lookup-text-in-a-file-in-bash-scripts)

```c
declare -A lookup=(
   [a]=1
   [b]=2
   [c]=3 # ... and so on
)

myvalue="${lookup[$myvar]}"
```

## 数组是否包含元素

[Check if a Bash array contains a value](https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value)

```c
if [ " ${array[@](%20"%20${array[@); then
    # whatever you want to do when array contains value
fi

if [ ! " ${array[@](%20!%20"%20${array[@); then
    # whatever you want to do when array doesn't contain value
fi
```