---
title: exiftool
---

#todo 

[坚果云，jgy](../../personal/nutstore.md)

批量修改图片的exif信息，比如根据文件名来修改exif，或者根据exif信息重命名文件。



## 检查图片是否有exif信息

```
exiftool -if '$datetimeoriginal' 2022-01-31_13-26-29_one.jpg
```