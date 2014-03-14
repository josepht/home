filetype plugin indent on

colorscheme slate

set exrc
set secure
set modeline
set showmode
set cedit=
set ai
"set textwidth=70
set ts=4
set sw=4
set sts=4
"set expandtab
set backspace=indent,eol,start

set pastetoggle=<leader>p
set splitbelow

map <leader>fj <Esc>:%!python -m json.tool<CR>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"set tags=/usr/src/sys/platform/pc32/tags
"cs add /home/josepht/cscope.out
if has("cscope")
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
        else
        cs add /home/josepht/cscope.out
    endif
    set csverb
endif

if &t_Co > 2 || has("qui_running")
    syntax on
endif

set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif

  	autocmd BufWritePost ~/.vimrc source ~/.vimrc
    autocmd FileType make setlocal noexpandtab
    "autocmd FileType python set ai sw=4 ts=4 expandtab softtabstop=4 smarttab
    "autocmd BufEnter *.py set ai sw=4 ts=4 expandtab softtabstop=4 smarttab
    autocmd BufEnter *.html set ai sw=2 ts=2 expandtab softtabstop=2 smarttab

    "autocmd BufEnter *.py map <leader>gg <Esc>:echo python<CR>
	"autocmd BufEnter *.py map <F8> <Esc>:!python %<CR>
	"autocmd BufEnter *.py map <leader>i <Esc>:!make itest ITEST_INITIAL_TESTS="" ITEST_PATH=% NOSE_OPTS="--pdb --pdb-failures -x --nologcapture"<CR>
	"autocmd BufEnter *.py map <leader>I <Esc>:!make itest ITEST_PATH=% NOSE_OPTS="--pdb --pdb-failures -x --nologcapture"<CR>
	"autocmd BufEnter *.py map <leader>f <Esc>:!make ftest FTEST_PATH=% NOSE_OPTS=--pdb<CR>
	"autocmd BufEnter *.py map <leader>gc <Esc>?^\s*class\s?e<CR>w
	"autocmd BufEnter *.py map <leader>gd <Esc>?^\s*def\s?e<CR>w
	"autocmd BufEnter *.py map <leader>gi <Esc>mZ<leader>gd"zyiw?^\s*class\s?e<CR>w"xyw`Z:exe "!make itest ITEST_PATH=%:".@x.".".@z." DEBUG=1"<CR>
	autocmd BufNewFile,BufRead *.run,t[cs]_control set filetype=yaml
endif

"abbreviate ll logging.info(("JAT"))<Left><Left>
"abbreviate cl window.console and console.log and console.log 
"abbreviate dl <Esc>O# <Esc>:r!date<CR>kJA - Joe Talbott <joe.talbott@canonical.com>
iabbr dl # <C-R>=strftime("%c")<CR> Joe Talbott <joe.talbott@canonical.com>

map <leader>v :edit ~/.vimrc<CR>
map <leader>s :source ~/.vimrc<CR>

nmap <M-Left> :bprev<CR>
nmap <M-Right> :bnext<CR>

"function! Lw(str)
"	let str=a:str
"	:normal i logging.warn("<str>: %s", <str>)
"endfunction
"command! -nargs=1 Lw call Lw(<f-args>)
"command! -nargs=1 Lw :normal i logging.warn("<args>: %s", <args>)<Esc>

"iabbr dw logging.warn(": %s", )<Esc>7hi
iabbr dw logging.warn("<C-R>": %s", <C-R>")

highlight Comment ctermfg=2
