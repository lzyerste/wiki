" keymap
"imap jj <C-[>
imap jj <Esc>
"imap <C-o> <Esc><C-o>
nmap j gj
nmap k gk
nmap f }zz
nmap F <C-d>zz
nmap b {zz
nmap B <C-u>zz
nmap gb viw
"let @q="c``\<Esc>hp"
"vmap ge @q
"vmap gh @h
"vmap gl @l
" Surround text with [[ ]] to make a wikilink
" NOTE: must use 'map' and not 'nmap'
exmap wiki surround [[ ]]
map [[ :wiki
map gl :wiki
exmap highlight surround == ==
map gh :highlight
exmap quote surround ` `
map ge :quote
exmap mark surround <mark> </mark>
map gm :mark
exmap fontcolor surround <font\ color="FF69B4"> </font>
map gc :fontcolor
"noremap gD <C-]>
exmap newpane obcommand editor:open-link-in-new-leaf
nmap gD :newpane
exmap follow obcommand editor:follow-link
nmap gd :follow
" Yank to system clipboard
set clipboard=unnamed

" unsupport
" set whichwrap+=>,l,<,h
