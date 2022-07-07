---
title: draw_io
---

#drawio #神器 #必备

# draw.io

自定义跳转到其他单元：

[Working with custom links : draw.io Helpdesk](https://desk.draw.io/support/solutions/articles/16000080137-working-with-custom-links)

Edit Link: `highlight`动作不错

```c
data:action/json,{"actions":[{"scroll": {"cells": ["D8R-pZAZ5Vba_V8sGs4q-71"]}}]}
```

根据tags跳转：

```python
data:action/json,{"actions":[{"select": {"tags": ["venice_nvm_register()"]}}]}
```

跨页面跳转：

```python
data:action/json,{"actions":[{"open":"data:page/id,aKiQF8UL5MqOaURdysiu"},{"select":{"tags":["venice_nvm_register_tgt_type"]}}]}
```

Edit Data获取ID

[Create Custom Link](https://jgraph.github.io/drawio-tools/tools/link.html)