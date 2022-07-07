---
title: 正则表达式，python
---

# 正则表达式，python

search例子：

```bash
def workload_exists(workload):
    cmd = "%s thread_get_stats" % RPC_SCRIPT
    s = run_cmd_assert(cmd, echo_cmd=False, echo_stdout=False)
    pattern = r'"name":\s*"%s"' % workload
    return re.search(pattern, s) is not None
```

```python
def bdev_num_blocks(bdev_name):
    """
    in blocks
    """
    cmd = "%s bdev_get_bdevs" % RPC_SCRIPT
    s = run_cmd_assert(cmd, timeout=5, echo_cmd=False, echo_stdout=False)
    pattern = r'"name":\s*"%s".*"num_blocks":\s*(\d+),' % bdev_name
    group = re.search(pattern, s, re.DOTALL)
    return int(group[1])
```