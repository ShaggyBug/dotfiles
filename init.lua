--[[
    A major improvement in NVim 0.5+ is that it allows the users to create an `init.lua`
    This is my attempt at doing that, and using all of the advantages of lua :)
]]
--[[ TODO List
   for text documents (.txt), I need to turn on spell check, and what ever grammer tools I have available 
--]]

local cmd = vim.cmd -- Vim Commands
local opt = vim.opt -- Vim Options
local fn = vim.fn   -- Vim Functions
local g = vim.g     -- Vim Globals

-- GUI Settings loaded only if useing a GUI
vim.api.nvim_create_autocmd("UIEnter", {
    once = true,
    callback = function()
        require('user.gui-settings')
        require('user.mouse-settings') 
    end
})
 
-- Other Things of concern
g.python3_host_prog = 'C:/Python/App/Python/python.exe'
g.sqlite_clib_path = 'C:/Users/cama20/Documents/Programs/PATH/sqlite/sqlite3.dll'

-- Custom edit variables (use with: `e: $LUAUSER\`<tab> then type the next files you need)
cmd[[let $LUAUSER = $LOCALAPPDATA .. "\\nvim\\lua\\user\\"]]
cmd[[let $CAMAPROD = "C:\\Users\\CAMA Site\\applications\\CAMA\\"]]
cmd[[let $CAMATEST = "C:\\Users\\CAMA Site\\applications\\TEST\\"]]

-- Stuff that needs to be loaded first
require('user.settings') -- All custom NVim Settings
require('user.keymaps')  -- All custom Key Bindings
require('user.plugins')  -- Packer Stuff (and light plugin configs)

-- All the Mini Configs
require('user.mini.comment')
require('user.mini.completion')
require('user.mini.cursorword')
require('user.mini.fuzzy')
require('user.mini.indentscope')
require('user.mini.sessions')
require('user.mini.starter')
require('user.mini.tabline')
require('user.mini.trailspace')

-- Config For Specifc Plugins
require('user.which-key') -- Easy Which Key Setup
require('user.lspzero') -- LSP Easy Setup
require('user.lspconfig') -- LSP Directly from NVim
require('user.telescope') -- Also all of its extensions
require('user.lualine')
require('user.luasnip')
require('user.nerdtree')
require('user.sqlite')
require('user.treesitter')
require('user.comment') -- Better way to comment stuff out
--require('user.orgmode') -- OrgMode (like Emacs) in NVim
require('user.neorg') -- OrgMode (like Emacs) but made specific for NVim
--require('user.wpm') -- Words Per Minute graph (view in LuaLine)

