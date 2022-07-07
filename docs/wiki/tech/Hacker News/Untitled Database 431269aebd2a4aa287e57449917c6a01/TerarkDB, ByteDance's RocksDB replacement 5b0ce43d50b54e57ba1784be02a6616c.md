---
title: TerarkDB,_ByteDance's_RocksDB_replacement_5b0ce43d50b54e57ba1784be02a6616c
---

# TerarkDB, ByteDance's RocksDB replacement

Date: December 23, 2020
Url: https://news.ycombinator.com/item?id=25514419
阅读: Yes

字节跳动从RocksDB fork出来的TerarkDB.

[](https://bytedance.feishu.cn/docs/doccnZmYFqHBm06BbvYgjsHHcKc)

1.  We changed the source code too much that we are not able to merge it back to RocksDB easily (This project started at 2016 as an close-source project)
2. We have different road path with RocksDB (e.g. We will remove a lot of un-used code to make TerarkDB much more light-weight than current version in the future) 
3. We have lots of third-party partners (e.g. Intel, on `Opatane` SSD/Memory and others with `ZNS`...) may participant in this project so we want to handle all commits ourself to make sure everything is under control.