---
title: Chung_et_al_,_“A_Survey_of_Flash_Translation_Layer
---

# Chung et al., “A Survey of Flash Translation Layer.”

![Chung et al , “A Survey of Flash Translation Layer/Untitled.png](Chung et al , “A Survey of Flash Translation Layer/2022-05-02_11-19-47.png)

- FTL职责
    - Logical-to-physical address mapping
    - Power-off recovery
    - Wear-leveling
- 地址映射分类
    - `sector mapping (page mapping)`
        - 粒度最细，需要RAM最多
    - `block mapping`
        - The basic idea of block mapping is that the logical sector offset within a logical block is identical to the physical sector offset within the physical block.
        - 逻辑地址分为两部分：块地址与块内偏移
            - 块地址可以随意映射，块内偏移保持一致
        - 优点是所需RAM较少，但因为块内偏移要一致，那么往一个地址重复写的时候，整个块都要迁移，代价很大。
    - `hybrid mapping`
        - 结合了块映射与页映射
        - 块内偏移不需要一致，而是可以不一致存放（需要额外的记录信息，比如放到page的spare area里），比如从前往后寻找空闲的sector
        - 查找开销比较大？要遍历block？