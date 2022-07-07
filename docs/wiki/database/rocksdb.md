---
title: rocksdb_68b1dab41ab64562b92908e1d0005141
---

# rocksdb

[RocksDB | A persistent key-value store](https://rocksdb.org/)

[facebook/rocksdb](https://github.com/facebook/rocksdb/wiki)

- [Architecture Guide](https://github.com/facebook/rocksdb/wiki/Rocksdb-Architecture-Guide)
- [Format of an immutable Table file](https://github.com/facebook/rocksdb/wiki/Rocksdb-Table-Format)
- [Format of a log file](https://github.com/facebook/rocksdb/wiki/Write-Ahead-Log-File-Format)

# Features

- **High Performance**
    - log structured database engine
    - written in C++
    - Keys and values are just arbitrarily-sized byte streams.
- **Optimized for Fast Storage**
    - optimized for fast, low latency storage such as flash drives and high-speed disk drives
    - exploits the full potential of high read/write rates offered by flash or RAM.
- **Adaptable**
    - adaptable to different workloads
    - 作为database storage engine
    - 或者嵌入到应用作为data cache
- **Basic and Advanced Database Operations**
    - basic operations such as opening and closing a database
    - reading and writing to more advanced operations such as merging and compaction filters

# Wiki

- The keys are ordered within the key value store according to a user-specified comparator function.
- It was developed at Facebook based on LevelDB and provides backwards-compatible support for LevelDB APIs.
- RocksDB can adapt to a variety of production environments, including pure memory, Flash, hard disks or remote storage.
- It supports various compression algorithms and good tools for production support and debugging.
- 针对TB级别数据
- Optimized for storing small to medium size key-values on fast storage -- flash devices or in-memory
- It works well on processors with many cores
- It supports both point lookups and `range scans`, and provides different types of ACID guarantees.
- RocksDB borrows significant code from the open source leveldb project as well as ideas from Apache HBase.
- It should be configurable to support high random-read workloads, high update workloads or a combination of both.
- Newer versions of this software should be backward compatible, so that existing applications do not need to change when upgrading to newer releases of RocksDB.
- RocksDB organizes all data in sorted order and the common operations are `Get(key)`, `NewIterator()`, `Put(key, val)`, `Delete(key)`, and `SingleDelete(key)`.
- The three basic constructs of RocksDB are memtable, sstfile and logfile.
    - The `memtable` is an in-memory data structure - new writes are inserted into the memtable and are optionally written to the logfile.
    - The `logfile` is a sequentially-written file on storage.
    - When the memtable fills up, it is flushed to a `sstfile` on storage and the corresponding logfile can be safely deleted.
    - The data in an sstfile is sorted to facilitate easy lookup of keys.
    - The format of a default sstfile is described in more details [here](https://github.com/facebook/rocksdb/wiki/Rocksdb-BlockBasedTable-Format).
- Column Families
    - RocksDB supports partitioning a database instance into multiple `column families`. All databases are created with a column family named "default", which is used for operations where column family is unspecified.
    - RocksDB guarantees users a consistent view across column families
    - It also supports atomic cross-column family operations via the WriteBatch API.
- Updates
    - Put: 单个键值对
    - Write: 多个键值对，原子性
    - Range Delete
- Gets, Iterators, Snapshots
    - Keys and values are treated as pure byte streams. There is no limit to the size of a key or a value.
    - Get: 获取单个键值对
    - MultiGet: 返回一组键值对
    - All data in the database is logically arranged in sorted order.
    - Iterator可双向移动
    - A consistent-point-in-time view of the database is created when the Iterator is created.
    - A Snapshot API allows an application to create a point-in-time view of a database.
    - Short-lived/foreground scans are best done via an iterator while long-running/background scans are better done via a snapshot.
    - An iterator keeps a reference count on all underlying files that correspond to that point-in-time-view of the database - these files are not deleted until the Iterator is released.
    - A snapshot, on the other hand, does not prevent file deletions; instead the compaction process understands the existence of snapshots and promises never to delete a key that is visible in any existing snapshot.
    - Snapshots are not persisted across database restarts: a reload of the RocksDB library (via a server restart) releases all pre-existing snapshots.
- **Transactions**
    - RocksDB supports multi-operational transactions. It supports both of optimistic and pessimistic mode.
- Prefix Iterators
    - instead applications typically scan within a key-prefix
- Persistence
    - RocksDB has a Write Ahead Log (WAL). All Puts are stored in an in-memory buffer called the memtable as well as optionally inserted into WAL. On restart, it re-processes all the transactions that were recorded in the log.
    - Each Put has a flag, set via WriteOptions, which specifies whether or not the Put should be inserted into the transaction log. The WriteOptions may also specify whether or not a sync call is issued to the transaction log before a Put is declared to be committed.
    - Internally, RocksDB uses a batch-commit mechanism to batch transactions into the log so that it can potentially commit multiple transactions using a single sync call.
- Data Checksuming
    - RocksDB uses a checksum to detect corruptions in storage. These checksums are for each SST file block (typically between 4K to 128K in size). A block, once written to storage, is never modified.
-