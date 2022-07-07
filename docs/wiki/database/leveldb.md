---
title: leveldb_b168a67c21714ba48f6b7eb463719671
---

# leveldb

- The implementation of leveldb is similar in spirit to the representation of a single [`Bigtable` tablet section 5.3](http://research.google.com/archive/bigtable.html).
- log files, memtable
- sorted tables, sstable
- MANIFEST
- compact

---

[leveldb日知录](leveldb%20b168a67c21714ba48f6b7eb463719671/leveldb日知录%20394050c9e1e24a62b5cbe25ed3df8f6a.md)

# 架构

关注点：

- 并行性
- Snapshot机制
    - 序列号。每个操作都带有序列号，搜索的时候，找key相等的，而且序列号不大于的，且最接近的。
- 迭代器Iterator实现
- 内存占用

---

整体架构参考网上博客资料。

读写流程参考源码。

---

[leveldb-handbook博客](leveldb%20b168a67c21714ba48f6b7eb463719671/leveldb-handbook博客%202c22f1e6bab543f799df15b19fcc64e7.md)

# APIs

## Open

## Put

```cpp
DBImpl::Put(const WriteOptions&, const Slice& key, const Slice& value)
	// 封装成WriteBatch
	WriteBatch batch;
	batch.Put(key, value);
	return Write(opt, &batch);
```

## Delete

跟Put接口类似，封装成批量写操作。

```cpp
Status DBImpl::Delete(const WriteOptions& options, const Slice& key)
	// 封装成WriteBatch
	WriteBatch batch;
	batch.Delete(key);
	return Write(opt, &batch);
```

## Get

```cpp
Status DBImpl::Get(const ReadOptions& options, const Slice& key, std::string* value)
	// First look in the memtable, then in the immutable memtable (if any).
	LookupKey lkey(key, snapshot);
	if (mem->Get(lkey, value, &s)) {
		// Done
	} else if (imm != nullptr && imm->Get(lkey, value, &s)) {
		// Done
	} else {
		s = current->Get(options, lkey, value, &stats);
		have_stat_update = true;
	}
```

```cpp

```

## Write

# 博客

[Leveldb源码解析第一篇【Data Block】 - xuxuan_csd的专栏 - CSDN博客](https://blog.csdn.net/xuxuan_csd/article/details/72965459)

[LevelDB 实现分析 - weixin_37871174的博客 - CSDN博客](https://blog.csdn.net/weixin_37871174/article/details/79424573)

[数据分析与处理之二（Leveldb 实现原理） - Haippy - 博客园](https://www.cnblogs.com/haippy/archive/2011/12/04/2276064.html)

[LevelDB Source Reading 4: Concurrent Access](http://tonyz93.blogspot.com/2016/11/leveldb-source-reading-4-concurrent.html)

[leveldb-handbook - leveldb-handbook 文档](https://leveldb-handbook.readthedocs.io/zh/latest/)

[](http://cighao.com/2016/08/23/paper-reading-04-buffer-management-algorithm-for-flash-memory/)

[庖丁解LevelDB之版本控制](https://www.jianshu.com/p/9bd10f32e38c)

[经典开源代码分析――Leveldb高效存储实现 - 51CTO.COM](http://stor.51cto.com/art/201903/593197.htm)