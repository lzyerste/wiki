---
title: cmake_[wiki]
---

# cmake [wiki]

[CMake](https://cmake.org/)

- 生成compile_commands.json，也就是编译每个文件的具体命令。这样vim看代码时寻找定义准确。
    - [https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html](https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html)
    - 如果生成的json文件在外面目录，那么只需要建立一个软链接即可，因为json文件里的文件都是使用绝对路径，所以软链接没有障碍。
    - 另一种生成方式是使用bear make，效果一样。
    
    ```python
    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ../$cwd $arg
    
    bear make -j16
    ```