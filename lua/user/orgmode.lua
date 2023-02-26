require('orgmode').setup_ts_grammar()
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = {'org'},
    },
    ensure_installed = {'org'},
})

require('cmp').setup({
    sources = {
        { name = 'orgmode' }
    }
})

require('orgmode').setup({
    org_agenda_files = {vim.fn.expand('$LOCALAPPDATA') .. '/nvim/org/*'},
    org_default_notes_file = vim.fn.expand('$LOCALAPPDATA') .. '/nvim/org/random_notes.org',
})
