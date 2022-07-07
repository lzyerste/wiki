---
title: fio
---

# fio

https://fio.readthedocs.io/en/latest/

## 参数详解

### offset_increment

> [!tip]+ `offset_increment``=int`[](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-offset-increment "Permalink to this definition")
> If this is provided, then the real offset becomes _offset + offset_increment * thread_number_, where the thread number is a counter that starts at 0 and is incremented for each sub-job (i.e. when [`numjobs`](https://fio.readthedocs.io/en/latest/fio_man.html#cmdoption-arg-numjobs) option is specified). This option is useful if there are several jobs which are intended to operate on a file in parallel disjoint segments, with even spacing between the starting points. Percentages can be used for this option. If a percentage is given, the generated offset will be aligned to the minimum `blocksize` or to the value of `offset_align` if provided. In ZBD mode, value can also be set as number of zones using ‘z’.
>
> fio 测试多 job（numjobs），应该考虑使用参数**offset_increment**，让各个 job 从不同的 offset 开始，彼此错开；否则所有 job 行为都一样，都从同一个 offset 开始。
>
> 为了防止各job测试范围重叠，参数offset_increment大小可设置为与参数size大小一致；另外，多job下的size应该是单job的size除以numjobs（均分）。比如测试总范围是100z，当numjobs为4时，offset_increment和size可设置为25z。

## old

仓库：

[axboe/fio](https://github.com/axboe/fio)

文档：

[fio](https://fio.readthedocs.io/en/latest/fio_doc.html)

fio重要参数：

- 重要概念：IO type，Block size，IO size，IO engine，IO depth，Target file/device，Threads/Jobs
- 调试帮助信息
    
    ```jsx
    --debug=type
    --cmdhelp=command
    --enghelp=[ioengine]
    --showcmd=jobfile
    ```
    
- `name=str`, ASCII name of the job
- `filename=str`, 比如/dev/sda
- `readwrite=str, rw=str`, 读写类型
- `rwmixread=int`, `rwmixwrite=int`，读写混合比例
- `offset=int`，测试起始地址
- `size=int`, 测试文件大小
- `blocksize=int[,int][,int], bs=int[,int][,int]`, IO请求大小
- `iodepth=int`
- `numjobs=int`, 并行任务数量
- `loops=int`, 循环次数
- `runtime=time`, `time_based`, 控制运行时间
- `number_ios=int`，运行多少次IO为止
- `io_size=int, io_limit=int`，测试跑多少量为止，默认大小为size
- `ioengine=str`，比如libaio
- `ioscheduler=str`
- `direct=bool`
- `filesize=irange(int)`
- `cpus_allowed=str`
- `verify=str`
- `zonemode=str`, 比如zbd
    - `zonesize=int`, `zonecapacity=int`, `read_beyond_wp=bool`, `max_open_zones=int`,  `zonerange=int`
    - 如果设备是zbd类型，会自动获取zonesize和zonecapacity

## 例子

写：

```
sudo fio -filename=/dev/nvme0n1 -ioengine=libaio -direct=1 -iodepth=4 -thread -name=fio_name -numjobs=1 -group_reporting -rw=write -zonemode=zbd -significant_figures=10 -offset=0 -size=200G -iodepth_batch_complete=1 -bs=1m
```

读：

```
sudo fio -filename=/dev/nvme0n1 -ioengine=libaio -direct=1 -thread -name=fio_name -group_reporting -zonemode=zbd -significant_figures=10 -offset=0 -size=200G -iodepth_batch_complete=1 -bs=16k -rw=read -iodepth=1 -numjobs=1 -runtime=60 -time_based
```

## verify_header

fio校验的头部元数据结构（40字节）：

```c
/*
 * A header structure associated with each checksummed data block. It is
 * followed by a checksum specific header that contains the verification
 * data.
 */
struct verify_header {
	uint16_t magic;		// 0:
	uint16_t verify_type;	// 2:
	uint32_t len;		// 4:
	uint64_t rand_seed;	// 8:
	uint64_t offset;	// 16:
	uint32_t time_sec;	// 24:
	uint32_t time_nsec;	// 28:
	uint16_t thread;	// 32:
	uint16_t numberio;	// 34:
	uint32_t crc32;		// 36:
};
```

magic一般是CA AC

例子：

```
0000000400000000: CA AC 05 00 00 00 02 00-80 A9 63 E6 CF 96 B0 2E  ..........c.....
0000000400000010: 00 00 00 00 04 00 00 00-03 00 00 00 4D 44 91 0F  ............MD..
0000000400000020: 01 00 80 1B DE D7 85 B6-0D AE 77 0F 78 41 77 0E  ..........w.xAw.
```

比如上面的offset（也就是LBA）是0x4_00000000，它对应的是字节偏移，换成block的话，就是0x400000，也就是zone2的起始地址。