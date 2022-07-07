---
title: zsh
---

#zsh #神器 #必备

zsh搭配oh-my-zsh

# zsh, oh-my-zsh

[dracula主题](zsh/dracula主题.md)

[tab自动提示不全](zsh/tab自动提示不全.md)

[Oh My Zsh - a delightful & open source framework for Z-Shell](https://ohmyz.sh/)

Ubuntu下安装：

```bash
sudo apt install zsh
```

设置翻墙代理，照上面网址即可。


```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## autosuggestion

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

```bash
plugins=(git zsh-autosuggestions)
```

## 简单配置

```bash
ZSH_THEME="ys"

plugins=(git zsh-autosuggestions)

# avoid hidding autosuggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
```

```bash
HIST_STAMPS="yyyy-mm-dd"

alias gcs="git commit -s"
alias gft="rm -rf *.patch ; git format-patch -n -1"
alias gc="git commit -s"

PATH=$PATH:$HOME/.local/cquery/bin:$HOME/.cargo/bin
export PATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# common git repo
alias s='~/git/swift-kv'
alias a='~/git/autotest/kv'
alias o='~/git/nvme-cli'
alias l='~/git/storage-system/kv_libc++'
alias r='~/git/KVRocks'

# keymap
xmodmap ~/.Xmodmap

alias rgf="rg --files -L | rg"
alias rm2="rm -rfi"
alias rm="rm -ri"

alias backup='pushd ~ ; cp -r .tmux.conf .Xmodmap .ssh .vimrc.bundles.local .vimrc.local .zshrc .zsh_history backup ; popd'

alias tmux="tmux -2"
```

## git提示错误

```cpp
_git:58: _git_commands: function definition file not found #3996
```

[_git:58: _git_commands: function definition file not found · Issue #3996 · ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh/issues/3996)

删除~/.zcompdump*，然后重新登入。

## 合并history

[https://gist.github.com/calexandre/63547c8dd0e08bf693d298c503e20aab](https://gist.github.com/calexandre/63547c8dd0e08bf693d298c503e20aab)

[https://gist.github.com/calexandre/63547c8dd0e08bf693d298c503e20aab](https://gist.github.com/calexandre/63547c8dd0e08bf693d298c503e20aab)