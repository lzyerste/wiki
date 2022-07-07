---
title: win11
---

## 虚拟机安装win11

```c
1. 新建虚拟机，命名为Win 11, 此时系统会自动选择Windows 11的配置；
1.1 关闭设置中的EFI启动宣选项
2. 基础配置结束后，点击启动，接下来的过程中选择win11镜像.ios文件;
3. 点击安装 
```

```c
Q1: virtual box检查.iso文件失败，自动进入: shell: 
A： 关闭虚拟机，关闭设置中的EFI启动宣选项

Q2: win11提示系统不符合条件，无法安装？
A2: 
		在 我的安装界面， shift+F10, 进入命令行界面，并输入： regedit
		依次进入-> HKEY_LOCAL_MACHINESYSTEM -> Setup， 新建 LabConfig项, 随后创建4个32位 Dword键值，分为设置为1，以绕过检查：
				BypassTPMCheck
		    BypassCPUCheck
		    BypassRAMCheck
		    BypassSecureBootCheck

Q3 Win11激活：
A3：
			打开系统管理员，输入：
			slmgr -ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
			slmgr -skms kms.0t.net.cn
			slmgr -ato
```

![](assets/Pasted%20image%2020220208195052.png)

## 锁屏不要息屏

https://docs.microsoft.com/en-us/troubleshoot/windows-client/shell-experience/monitor-powers-off-when-pc-locked

一直保留壁纸。

```
powercfg.exe /setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK <time in seconds>

powercfg.exe /setactive SCHEME_CURRENT
```

## 锁屏界面不要有广告

https://superuser.com/questions/1327459/remove-fun-facts-from-spotlight-lock-screen-in-windows-10-home-1803

The existing answers didn't work for me. I'm using 21H1 build 19043.1110.

I have disabled the overlay by changing the security settings of the folder that stores the metadata for the lockscreen. Replace `<USER NAME>` in the path below.

```
C:\Users\<USER NAME>\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\TargetedContentCache\v3\338387
```

Right click the folder to open the properties, the go to the security tab and click Advanced. The click Add, select principal the user "Everyone", select type Disallow, and check only the "Write" permission. Then select OK in each window.

![](assets/Pasted%20image%2020220209203717.png)