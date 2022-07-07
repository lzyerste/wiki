---
title: clangd
---

# clangd

tag: 神器

## Ubuntu

导入源然后apt安装不成功。

直接下载源码也行。[https://github.com/clangd/clangd/releases/tag/11.0.0](https://github.com/clangd/clangd/releases/tag/11.0.0)

解压后，将路径加入到PATH即可。

## Mac

安装：

```python
brew install llvm
```

## sublime text

如果找不到clangd的话，直接在LSP的设置里指定clangd路径即可。

[tomv564/LSP](https://github.com/tomv564/LSP) works with clangd out of the box.

Select **Tools**–>**Install Package Control** (if you haven’t installed it yet).

Press `Ctrl-Shift-P` and select **Package Control: Install Package**. Select **LSP**.

Press `Ctrl-Shift-P` and select **LSP: Enable Language Server Globally**. Select **clangd**.

Open a C++ file, and you should see diagnostics and completion:

![https://clangd.llvm.org/screenshots/sublime_completion.png](https://clangd.llvm.org/screenshots/sublime_completion.png)

The LSP package has excellent support for all most clangd features, including:

- code completion (a bit noisy due to how snippets are presented)
- diagnostics and fixes
- find definition and references
- hover and highlights
- code actions

### Under the hood

Settings can be tweaked under **Preferences**–>**Package Settings**–>**LSP**.

- **Debug logs**: add `"log_stderr": true`
- **Command-line flags and alternate clangd binary**: inside the `"clients": {"clangd": { ... } }` section, add `"command": ["/path/to/clangd", "-log=verbose"]` etc.

## youcompleteme

```python

```

[YouCompleteMe](https://valloric.github.io/YouCompleteMe/) can be installed with clangd support. **This is not on by default**, you must install it with `install.py --clangd-completer`.

We recommend changing a couple of YCM’s default settings. In `.vimrc` add:

```python
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
```

You should see errors highlighted and completions as you type.

![https://clangd.llvm.org/screenshots/ycm_completion.png](https://clangd.llvm.org/screenshots/ycm_completion.png)

YouCompleteMe supports many of clangd’s features:

- code completion
- diagnostics and fixes (`:YcmCompleter FixIt`)
- find declarations, references, and definitions (`:YcmCompleter GoTo` etc)
- rename symbol (`:YcmCompleter RefactorRename`)

### Under the hood

- **Debug logs**: run `:YcmDebugInfo` to see clangd status, and `:YcmToggleLogs` to view clangd’s debug logs.
- **Command-line flags**: Set `g:ycm_clangd_args` in `.vimrc`, e.g.:
    
    `let g:ycm_clangd_args = ['-log=verbose', '-pretty']`
    
- **Alternate clangd binary**: set `g:ycm_clangd_binary_path` in `.vimrc`.

---

[LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim) also has [instructions for using clangd](https://github.com/autozimu/LanguageClient-neovim/wiki/Clangd), and **may** be easier to install.

## coc.nvim

## compile_commans.json示例

比如spdk是个make项目，使用bear来记录make生成的编译命令。

```python
bear make
或者
bear -- make
```

## linux示例

自带的脚本，make编译过一次后，运行该脚本。

```python
scripts/clang-tools/gen_compile_commands.py
```

## tacoma呢

tacoma里有好几个独立项目，如何设置呢？