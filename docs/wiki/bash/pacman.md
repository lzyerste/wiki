---
title: pacman
---

## 跳过signature检查

https://unix.stackexchange.com/questions/405599/gpg-error-retrieving-meexample-com-via-wkd

```c
#vi /etc/pacman.conf

# By default, pacman accepts packages signed by keys that its local keyring  
# trusts (see pacman-key and its man page), as well as unsigned packages.  
#SigLevel = Optional TrustedOnly
```

SigLevel改为Never