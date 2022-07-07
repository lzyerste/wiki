---
title: 安装tmux-continuum_fb66ac810d08446f9b32c4e4e1f5cd83
---

# 安装tmux-continuum

机器重启后可恢复最后的session。

```jsx
tmux
C-b C-r
```

## tmux-continuum

[tmux-plugins/tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)

先安装Tmux Plugin Manager：

[tmux-plugins/tpm](https://github.com/tmux-plugins/tpm)

Requirements: tmux version 1.9 (or higher), git, bash.

```jsx
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Put this at the bottom of `~/.tmux.conf` (`$XDG_CONFIG_HOME/tmux/tmux.conf` works too):

```jsx
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com/user/plugin'
# set -g @plugin 'git@bitbucket.com/user/plugin'
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run -b '~/.tmux/plugins/tpm/tpm'
```

Reload TMUX environment so TPM is sourced:

```jsx
# type this in terminal if tmux is already running
$ tmux source ~/.tmux.conf
```

That's it!

---

Add plugin to the list of TPM plugins in `.tmux.conf`:

```
set -g @plugin 'tmux-plugins/tmux-resurrect'
```

Hit `prefix + I` to fetch the plugin and source it. You should now be able to use the plugin.