---
title: wget
---

## 下载一个目录

https://stackoverflow.com/questions/273743/using-wget-to-recursively-fetch-a-directory-with-arbitrary-files-in-it

```sh
wget -r -nH --cut-dirs=1 --no-parent --reject="index.html*" http://gitlab.innogrit.com:9000/tmp/config-tacoma/
```