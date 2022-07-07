---
title: mac_doc栏反应慢
---

# mac doc栏反应慢

有些朋友会用到DOCK的自动隐藏功能，但是在其自动隐藏和显示的时候难免会有延迟，下面告诉大家怎样能消除这个延迟。

打开“终端”（“应用程序”文件夹->“实用工具”文件夹->“终端”），输入以下命令：

```bash
defaults write com.apple.Dock autohide-delay -float 0 && killall Dock
```

很简单吧，现在你去看看还有延迟吗？

如果想恢复默认设置，打开“终端”（“应用程序”文件夹->“实用工具”文件夹->“终端”），输入以下命令：

```bash
defaults delete com.apple.Dock autohide-delay && killall Dock
```