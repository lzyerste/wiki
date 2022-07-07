---
title: page_zone_cba8b0f849944fc09be1ba0b7d69cb67
---

# page_zone

url: https://elixir.bootlin.com/linux/v5.0/source/include/linux/mm.h#L1160
说明: 通过page描述符找到所属的zone

```python
static inline struct zone *page_zone(const struct page *page)
{
	return &NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)];
}
```