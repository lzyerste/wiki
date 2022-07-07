---
title: 调试Python的时候，报错add_command
---

# 调试Python的时候，报错add_command

```python
pydevd_comm.py", line 353, in add_command self.cmdQueue.put(cmd)
```

解决办法：删除自定义的PYTHONPATH，在~/.zshrc，然后就好了

[PyCharm debugger fails with AttributeError](https://stackoverflow.com/questions/37181768/pycharm-debugger-fails-with-attributeerror)