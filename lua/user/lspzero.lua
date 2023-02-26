local lsp = require('lsp-zero')

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = bufnr})

lsp.preset('recommended')

lsp.nvim_workspace()

lsp.setup()
