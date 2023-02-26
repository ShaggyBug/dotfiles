-- Mini Starter -- A replacement for Startify
local starter = require('mini.starter')
starter.setup({
    evaluate_single = true,
    items = {
        starter.sections.builtin_actions(),
        starter.sections.recent_files(10, false), -- 10 most recent files
        starter.sections.recent_files(10, true),  -- 10 files in current dir
    },
    content_hooks = {
        starter.gen_hook.adding_bullet(),
        --starter.gen_hook.padding(3, 2),
        starter.gen_hook.aligning('center', 'center')
    },
})

vim.cmd([[
    autocmd TabNewEntered * ++nested lua MiniStarter.open()
    " autocmd BufEnter * if line2byte('.') == -1 && len(tabpagebuflist()) == 1 && empty(bufname()) | Startify | endif
    " autocmd BufEnter * ++nested lua MiniStarter.open()
]])
