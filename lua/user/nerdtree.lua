
vim.cmd([[
    autocmd BufWinEnter * if getcmdwintype() == '' | silent! NERDTreeMirror | endif
    nnoremap <Leader>NC :NERDTree CAMA<CR>
    nnoremap <Leader>NT :NERDTree TEST<CR>
    let g:NERDTreeShowBookmarks = 1
    let g:NERDTreeShowLineNumbers = 1
    let g:NERDTreeMinimalUI = 1
    if exists("g:loadednerdtree_custom_maps")
    finish
    endif
    let g:loaded_nerdtree_custom_maps = 1
]])
