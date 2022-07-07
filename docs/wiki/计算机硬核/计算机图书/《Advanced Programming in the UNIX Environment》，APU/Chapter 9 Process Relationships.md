---
title: Chapter_9_Process_Relationships
---

# Chapter 9: Process Relationships

看的有点蒙

- process groups
- sessions
- login shell
- signals
- process group leader
    - The process group still exists, as long as at least one process is in the group, regardless of whether the group leader terminates.
    - The last remaining process in the process group can either terminate or enter some other process group.
    - A process can set the process group ID of only itself or any of its children.
- sessions
    - The process groups within a session can be divided into a single foreground process group and one or more background process groups.

## 例子

[Examples](assets/Examples.csv)