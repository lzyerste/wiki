---
title: Chapter_7_Scheduling_54ae0c7b27d64d2db6342086e634849b
---

# Chapter 7: Scheduling

queuing theory未细看。

## 7.1 Uniprocessor Scheduling

### FIFO: First In First Out

- throughput不错，一直保持processor处于忙状态，且switch次数少。
- 平均响应时间差

## SJF: Shortest Job First

- 平均响应时间最佳
- 需要预先知道任务执行时长，所以不够实际。
- 也叫SRTF，挑选剩余时间最少的任务
- 显然，会造成快者更快、慢者更慢，可能会造成饥饿。

### Round Robin

- 公平
- 不会饥饿
- switch overhead，processor cache
- 时间片选择，内核一般使用10~100ms
-