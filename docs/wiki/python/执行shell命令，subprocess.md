---
title: 执行shell命令，subprocess
---

# 执行shell命令，subprocess

python要3.5以上

```bash
import subprocess
from datetime import date, datetime

def run_cmd(cmd, echo_cmd=True, echo_stdout=True, timeout=None) -> (int, str):
    if echo_cmd:
        print("[%s] %s" % (datetime.now(), cmd))
    cmpl = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=timeout, encoding="utf-8")
    if cmpl.returncode != 0:
        print("ERROR:")
        print(cmpl)
    else:
        print(cmpl.stdout)
    return cmpl.returncode, str(cmpl.stdout)

def run_cmd_assert(cmd, echo_cmd=True, echo_stdout=True, timeout=None):
    r, s = run_cmd(cmd, echo_cmd, echo_stdout, timeout)
    assert(r == 0)
    return s
```