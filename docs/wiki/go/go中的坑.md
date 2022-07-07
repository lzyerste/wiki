---
title: go中的坑
---

# go中的坑

- slice扩展后可能会丢失原来的引用，最好将slice作为返回值。
- for循环作用域（匿名函数），遍历项是指向同一个引用。
    
    ![046524154f26e4d26545dd88fa4a2ab3](assets/046524154f26e4d26545dd88fa4a2ab3.png)
    
    Above, the single variable f is share d by all the anonymous function values and updated by successive loop iterations.
    
    要使用explicit parameter
    
    ![8497dee7c0e2046ed8df12c562eabcbb](assets/8497dee7c0e2046ed8df12c562eabcbb.png)
    
- goroutine有时候需要类似barrier的操作，等待所有其他goroutine完成后，main routine才退出。