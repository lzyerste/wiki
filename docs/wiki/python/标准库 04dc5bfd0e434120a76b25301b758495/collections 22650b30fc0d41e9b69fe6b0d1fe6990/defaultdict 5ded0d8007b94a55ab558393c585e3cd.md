---
title: defaultdict_5ded0d8007b94a55ab558393c585e3cd
---

# defaultdict

- 提供默认值的字典（如果key不存在）

```python
from collections import defaultdict

G = defaultdict(lambda: defaultdict(int))  # G[u][v] = weight
for u in G:
    for v in G[u]:
        print(G[u][v])
```