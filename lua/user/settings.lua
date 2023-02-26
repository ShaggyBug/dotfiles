--[[  File: <$NVIM_HOME>\lua\user\settings.lua
    Purpose: Chase's NVim Settings
    State: Attempting to port everything from init.vim (which was a straight port of .vimrc) to init.lua

    -- Notes:
    Please see |nvim-defaults| as I am not worrying about things that are enabled/disabled by default

    -- API
    vim.o   = General Options
    vim.g   = Global Options
    vim.bo  = Buffer-Scoped Options
    vim.wo  = Window-Scoped Options
    vim.opt = Acts like vim's `:set` command (aliased to "set")

    -- TODOs
    Actually Implement the don't worry about nvim-defaults 
--]]

local set = vim.opt
local api = vim.api
local glo = vim.g

-- Color Theme
require('monokai').setup {}
set.termguicolors = true -- enable "best" version of color scheme

-- Random Settings
set.helpheight = 35 -- TODO IDK what this even does... just copied from old vimrc
set.clipboard = set.clipboard + 'unnamedplus'
set.signcolumn = 'yes'

-- Mouse Settings
set.mouse = 'a' -- |mouse| Enable mouse in all modes (Over Rides Default)
set.mousemodel = 'popup'
--vim.

-- Layout
set.relativenumber = true -- Show relative number on non-selected line:s
set.number = true         -- Show selected line's actual number
set.breakindent = true    -- preserve indention of virtual lines 
set.lazyredraw = true     -- Redraw the screen less, leading to faster response
set.showmatch = true      -- Shows matching bracket when highlighting with cursor
--set.nolinebreak = true    -- I do NOT want my text breaking at 80 columns by default
set.textwidth = 0         -- Allow >80 col text
set.cursorline = true     -- Show a highlighted line where cursor is at
set.linebreak = true      -- Proper "Wrap" of lines of text (with word, not character)

-- Spelling
set.spelllang = en_us     -- If Spell Check is enabled (<leader>ss) then use US English
set.spellsuggest = best   -- Order the suggestions in the best way
set.dictionary = set.dictionary + '~/AppData/Local/nvim/spell'
-- For some reason, the above 3 lines are NOT working.... 
vim.cmd([[
    set spelllang=en_us
    set spellsuggest=best
    set dictionary+='~/AppData/Local/nvim/spell'
]])

-- Menu and Search
set.wildmode = 'list:longest' -- Make 'wildmenu' behave a little nicer TODO: Make this work
set.ignorecase = true       -- Ignores case when searching
set.smartcase = true        -- Even with ignore case, still try to be smart about it

-- Spacing, Tabs, Indention
set.smartindent = true -- Smarter indenting
set.expandtab = true   -- If hard tabs are present, soft convert them to 4 spaces
set.shiftwidth = 4     -- 1 tab = 4 spaces
set.tabstop = 4        -- Backspace over a full tab if tab is expanded to tabstop or expandtab
set.softtabstop = 4    -- Backspace over a full tab if tab is expanded to tabstop or expandtab
set.showtabline = 2    -- Always display the tabline, even if there is only 1 tab

-- New Windows
set.splitright = true -- Open New Window on Right By Default (not left)
set.splitbelow = true -- Open New Window on Bottom by Default (not top)

-- Set the Shell to use Powershell (runs ! command's)
--vim.cmd([[
--	let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
--    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
--    let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
--    let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
--    set shellquote= shellxquote=
--]])

-- Text Documents
api.nvim_create_autocmd( 
    "FileType", { 
        pattern = { 'text' },
        command = "set linewrap | set spell"
    }
)

api.nvim_create_autocmd(
    "FileType", {
        pattern = { 'python' },
        command = "set foldmethod=indent | set foldcolumn=4 | set foldlevel=0"
    }
)

-- Highlight Yanked Text on Yank
local yankGrep = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrep,
})


