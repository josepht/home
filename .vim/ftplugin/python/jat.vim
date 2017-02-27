" Joe Talbott <joetalbott@gmail.com>
"
set ai sw=4 ts=4 expandtab softtabstop=4 smarttab


highlight OverLength ctermbg=red ctermfg=white guibg=#592929
highlight TailSpace ctermbg=red ctermfg=white guibg=#592929
highlight ColorColumn ctermbg=red ctermfg=white guibg=red

match OverLength /\%81v.\+/
match TailSpace /\ \+$/

set colorcolumn=81
let python_highlight_all=1
let python_highlight_space_errors=1
let python_slow_sync=1

" Assumes 'filetype indent on'
abbreviate pyd def blah():<CR>pass<CR><Esc>?def blah?s4<CR>

abbreviate ll logging.info(("JAT"))<Left><Left>
abbreviate pd print("DEBUG: JAT: {}".format())<Left><Left>

map <leader>r <Esc>:!python %<CR>
map <leader>n <Esc>:!nosetests %<CR>
map <leader>f <Esc>:!flake8 %<CR>
"map <leader>i <Esc>:!make itest ITEST_INITIAL_TESTS="" ITEST_PATH=% NOSE_OPTS="--pdb --pdb-failures -x --nologcapture"<CR>
"map <leader>I <Esc>:!make itest ITEST_PATH=% NOSE_OPTS="--pdb --pdb-failures -x --nologcapture"<CR>
"map <leader>f <Esc>:!make ftest FTEST_PATH=% NOSE_OPTS=--pdb<CR>
map <leader>gc <Esc>?^\s*class\s?e<CR>w
map <leader>gd <Esc>?^\s*def\s?e<CR>w
"map <leader>gi <Esc>mZ<leader>gd"zyiw?^\s*class\s?e<CR>w"xyw`Z:exe "! ITEST_TIMEOUT=60000 make itest ITEST_PATH=%:".@x.".".@z." DEBUG=1"<CR>
