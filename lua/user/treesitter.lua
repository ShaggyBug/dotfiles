require('nvim-treesitter.configs').setup({
    ensure_installed = { 'python', 'lua', 'vim', 'help', 'javascript', 'html', 'css', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore', 'http', 'jq', 'json', 'markdown', 'regex', 'sql', 'vue', 'yaml'},
    highlight = {
        enabled = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enabled = true, -- Experimental
    },
})
