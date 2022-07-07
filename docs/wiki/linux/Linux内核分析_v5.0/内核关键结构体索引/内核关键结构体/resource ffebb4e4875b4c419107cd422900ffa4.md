---
title: resource_ffebb4e4875b4c419107cd422900ffa4
---

# resource

url: https://elixir.bootlin.com/linux/v5.0/source/include/linux/ioport.h#L19
说明: IO resource表示，树形结构

- 根节点为struct resource ioport_resource和struct resource iomem_resource
    
    ```python
    // https://elixir.bootlin.com/linux/v5.0/source/kernel/resource.c#L29
    
    struct resource ioport_resource = {
    	.name	= "PCI IO",
    	.start	= 0,
    	.end	= IO_SPACE_LIMIT,
    	.flags	= IORESOURCE_IO,
    };
    EXPORT_SYMBOL(ioport_resource);
    
    struct resource iomem_resource = {
    	.name	= "PCI mem",
    	.start	= 0,
    	.end	= -1,
    	.flags	= IORESOURCE_MEM,
    };
    EXPORT_SYMBOL(iomem_resource);
    ```