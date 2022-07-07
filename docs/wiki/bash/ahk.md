---
title: ahk
---

#tool #神器

https://www.autohotkey.com/

## 我的常用改键

Caps映射成右键：

```sh
Capslock::
Send {Right}
return
```

Ctrl+q映射成Alt+F4：

```sh
^q::
Send !{f4}
return
```

Win+h映射成系统休眠：

```sh
#h::
DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)
```

Pause键控制ahk脚本暂停。

## 开机自动启动

https://www.autohotkey.com/docs/FAQ.htm#Startup

```
There are several ways to make a script (or any program) launch automatically every time you start your PC. The easiest is to place a shortcut to the script in the Startup folder:

1. Find the script file, select it, and press Ctrl+C.
2. Press Win+R to open the Run dialog, then enter shell:startup and click OK or Enter. This will open the Startup folder for the current user. To instead open the folder for all users, enter shell:common startup (however, in that case you must be an administrator to proceed).
3. Right click inside the window, and click "Paste Shortcut". The shortcut to the script should now be in the Startup folder.

```