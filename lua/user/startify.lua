local g = vim.g

g.startify_session_dir = '~/AppData/Local/nvim/session'

g.startify_files_number			= 10
g.startify_session_number		= 10
g.startify_session_sort			= 1
g.startify_session_autoload		= 1
g.startify_session_persistence	= 1
g.startify_fortune_use_unicode	= 1
g.startify_relative_path		= 1
g.startify_change_to_dir		= 1
g.startify_update_old_files		= 1

--g.startify_session_before_save = vim.cmd([[
--  'echo "Cleaning 
--]])

g.startify_lists = {
    { type = 'files', header = { ' Files' } },
    { type = 'dir', header = { ' CWD '..vim.fn.getcwd()..':' } }, 
    --{ type = vim.fn.list_files(10, '~/AppData/Local/nvim/lua/user', '*.lua'), header = { 'User lua' } },
    { type = 'sessions', header = { ' Sessions' } }, 
    { type = 'bookmarks', header = { ' Bookmarks' } }, 
    { type = 'commands', header = { ' Commands' } },
}
g.startify_bookmarks = {
    { eC = '~/AppData/Local/nvim/doc/chasevim.txt' },
    { eL = '~/AppData/Local/nvim/init.lua' },
    { eU = '~/AppData/Local/nvim/lua/user' },
}
g.startify_commands = {
    { hC = { 'Help Chase Vim', 'h chasevim' } },
    { hL = { 'Help VimL', 'h learnviml' } },
    { hS = { 'Help Startify', 'h Startify' } },
    { hN = { 'Help NERDTree', 'h NERDTree' } },
}
--g.startify_skiplist = [
--        \ '\**.vim',
--        \ "$HOME . '/.NERDTreeBookmarks'",
--        \ "$HOME . '/\\AppData\\Local\\nvim\\**'",
--        \]
--


-- usage (add to g:startify_lists): \ { 'type': function('s:list_files', [<number of files to be shown>, '<directory>', '<glob for file type>']),
-- 'header': ['   <Header>']    },
vim.cmd([[
    " List recently modified files in a directory
    function! s:list_files(...) abort
        let l:file_amount=get(a:, 1, s:max_files_amount)
        " Ensure boundries 0 < v <= max
        if l:file_amount > s:max_files_amount
            let l:file_amount=s:max_files_amount
        elseif l:file_amount <= 0
            let l:file_amount=1
        endif
    
        let l:all_files=split(globpath(get(a:, 2), get(a:, 3)), '\n')
    
        " Sort based on modified time
        function! s:sort_by_mtime(foo, bar)
            let foo = getftime(a:foo)
            let bar = getftime(a:bar)
            return foo == bar ? 0 : (foo < bar ? 1 : -1)
        endfunction
        call sort(l:all_files, 's:sort_by_mtime')
        return map(l:all_files[:l:file_amount-1], '{"line": v:val, "cmd": "edit " . v:val }')
    endfunction
    ]])
