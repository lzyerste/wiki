---
title: onedrive
---

Linux客户端使用源码编译的（~/git/onedrive），不要直接apt安装的。

配置文件在`wiki/config/onedrive`。

```
$ ls ~/Nutstore/wiki/config/onedrive 
business_shared_folders  config  sync_list
```

- business_shared_folders: ../../config/onedrive/business_shared_folders
- config: ../../config/onedrive/config
- sync_list: ../../config/onedrive/sync_list

[Engineering](https://innogrit.sharepoint.com/Shared%20Documents/Forms/AllItems.aspx?id=%2FShared%20Documents%2FEngineering&viewid=0c1b468e%2D6e4e%2D486b%2D8644%2Da6c9704b601e)

## linux客户端

https://github.com/abraunegg/onedrive

https://launchpad.net/~yann1ck/+archive/ubuntu/onedrive

```shell
sudo add-apt-repository ppa:yann1ck/onedrive
sudo apt-get update
sudo apt install onedrive

# 卸载
sudo apt remove onedrive
```

- 首先是授权：浏览器打开链接，授权，然后把URL复制过来就可以了。

```
[user@hostname ~]$ onedrive
Authorize this app visiting:

https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=22c49a0d-d21c-4792-aed1-8f163c982546&scope=Files.ReadWrite%20Files.ReadWrite.all%20Sites.ReadWrite.All%20offline_access&response_type=code&redirect_uri=https://login.microsoftonline.com/common/oauth2/nativeclient

Enter the response uri: https://login.microsoftonline.com/common/oauth2/nativeclient?code=<redacted>

Application has been successfully authorised, however no additional command switches were provided.

Please use --help for further assistance in regards to running this application.
```

- 单向下载：会自动下载到目录~/OneDrive

```shell
onedrive --synchronize --download-only
```

### 源码编译

https://github.com/abraunegg/onedrive/blob/master/docs/INSTALL.md#dependencies-ubuntu-18x-ubuntu-19x-ubuntu-20x--debian-9-debian-10---x86_64

依赖项：

```
sudo apt install build-essential
sudo apt install libcurl4-openssl-dev
sudo apt install libsqlite3-dev
sudo apt install pkg-config
sudo apt install git
sudo apt install curl
curl -fsS https://dlang.org/install.sh | bash -s dmd
```

编译：

Before cloning and compiling, if you have installed DMD via curl for your OS, you will need to activate DMD as per example below:

```
Run `source ~/dlang/dmd-2.087.0/activate` in your shell to use dmd-2.087.0.
This will setup PATH, LIBRARY_PATH, LD_LIBRARY_PATH, DMD, DC, and PS1.
Run `deactivate` later on to restore your environment.
```

Without performing this step, the compilation process will fail.

Note: Depending on your DMD version, substitute 2.087.0 above with your DMD version that is installed.

```
git clone https://github.com/abraunegg/onedrive.git
cd onedrive
./configure
make clean; make;
sudo make install
```

### shared folder

https://github.com/abraunegg/onedrive/blob/master/docs/BusinessSharedFolders.md

需要另外配置。需要新版的ondrive，可以自己源码编译。

可以配合选择性同步，只下载个别文件夹。

列出共享目录：比如Engineering

```
onedrive --list-shared-folders
```

添加要同步的共享目录：

```
[alex@centos7full onedrive]$ cat ~/.config/onedrive/business_shared_folders
Engineering
```

显示当前配置：

```
onedrive --display-config
```

下载：使用自己编译的版本

```
./onedrive --synchronize --download-only --sync-shared-folders --verbose
```

### 配置文件

路径是`~/.config/onedrive/config`。

### 选择性下载

```shell
$ vi ~/.config/onedrive/sync_list

Engineering/Architecture Development
Engineering/Firmware/training
Engineering/Rainier
Engineering/Storage Standards
Engineering/Tacoma12
```

### skip_dir

Example:

```
# When changing a config option below, remove the '#' from the start of the line
# For explanations of all config options below see docs/USAGE.md or the man page.
#
# sync_dir = "~/OneDrive"
# skip_file = "~*|.~*|*.tmp"
# monitor_interval = "300"
skip_dir = "Desktop|Documents/IISExpress|Documents/SQL Server Management Studio|Documents/Visual Studio*|Documents/WindowsPowerShell"
# log_dir = "/var/log/onedrive/"
```

Patterns are case insensitive. `*` and `?` [wildcards characters](https://technet.microsoft.com/en-us/library/bb490639.aspx) are supported. Use `|` to separate multiple patterns.

**Important:** Entries under `skip_dir` are relative to your `sync_dir` path.

**Note:** The `skip_dir` can be specified multiple times, for example:

```
skip_dir = "SomeDir|OtherDir|ThisDir|ThatDir"
skip_dir = "/Path/To/A/Directory"
skip_dir = "/Another/Path/To/Different/Directory"
```

This will be interpreted the same as:

```
skip_dir = "SomeDir|OtherDir|ThisDir|ThatDir|/Path/To/A/Directory|/Another/Path/To/Different/Directory"
```

**Note:** After changing `skip_dir`, you must perform a full re-synchronization by adding `--resync` to your existing command line - for example: `onedrive --synchronize --resync`

## 链接任意文件夹到onedrive

https://www.tenforums.com/tutorials/92892-sync-any-folder-onedrive-windows-10-a.html

```sh
mklink /j "%UserProfile%\OneDrive\Folder Name" "Full path of source folder"
```