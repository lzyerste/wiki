---
title: Java_Collections_Framework_b62c8efc4fcc482faebfc49b6908c89b
---

# Java Collections Framework

代码路径：github/jdk-9.0.4

常用接口有：

- List
    - ArrayList
    - LinkedList
- Deque，Queue
    - ArrayDeque
    - LinkedList
    - Stack可以直接使用Deque的接口
- Set
    - SortedSet
- Map
    - SortedMap

如果要求Sorted，那么一般是基于Tree的实现；否则可使用Hash。

如果需要线程安全，可以在外面套一层Collections.synchronized...

---

[ArrayList](Java%20Collections%20Framework%20b62c8efc4fcc482faebfc49b6908c89b/ArrayList%207c012d68198b4f3e9573358e308a5548.md)

[LinkedList](Java%20Collections%20Framework%20b62c8efc4fcc482faebfc49b6908c89b/LinkedList%20c98cf0f0c1b341b4827813a724cfce45.md)

[ArrayDeque](Java%20Collections%20Framework%20b62c8efc4fcc482faebfc49b6908c89b/ArrayDeque%208d60470c6dcc41c0a3f5cea461ab1212.md)

---

## Set

## Map

- @see HashMap
- @see TreeMap
- @see Hashtable
- @see SortedMap