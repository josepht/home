nnoremap <leader>f :!flake8 %<CR>
nnoremap <leader>R :!python %<CR>
nnoremap <leader>r :!python3 %<CR>
nnoremap <leader>t :!pytest %<CR>

noremap <leader>d <ESC>oprint("JOE: <C-r>": {}".format(<C-r>"))<ESC>

noremap <leader>ld <ESC>ologger.debug("JOE: <C-r>": {}".format(<C-r>"))<ESC>
noremap <leader>ld <ESC>ologger.info("JOE: <C-r>": {}".format(<C-r>"))<ESC>
noremap <leader>lw <ESC>ologger.warning("JOE: <C-r>": {}".format(<C-r>"))<ESC>

noremap <leader>Ld <ESC>ologging.debug("JOE: <C-r>": {}".format(<C-r>"))<ESC>
noremap <leader>Ld <ESC>ologging.info("JOE: <C-r>": {}".format(<C-r>"))<ESC>
noremap <leader>Lw <ESC>ologging.warning("JOE: <C-r>": {}".format(<C-r>"))<ESC>

noremap <leader>c :!python3 -m coverage run --source . -m pytest %<CR> 
noremap <leader>cr :!python3 -m coverage report -m <CR>
