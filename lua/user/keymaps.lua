-- vim.keymap.set({mode}, {binding key}, {action/key}, {desc(str), remap(bool), buffer(bool), silent(bool), expr(bool)})
-- You can check keybindings anywhere by typeing `:map <keybinding>` and it will return its value

-- TODO: Make option to hide other splits (full screen current split) Needs to be reversable though
-- TODO: ^o allows you to enter command mode from insert mode, esc returns you to insert mode

local bind = vim.keymap.set

-- KeyMaps
vim.g.mapleader = ',' --Leader is comma

-- Normal and Insert Mode
bind('n', '<C-S>', ':write<CR>', {silent=true, desc='Save on Ctrl-S'}) 
bind('i', '<C-S>', '<C-o>:write<CR>', {silent=true, desc='Save on Ctrl-S'})

-- Normal Mode
bind('n', '<Space>', ':nohlsearch<CR>', {silent=true, desc='Stop Highlighting Things!'})
bind('n', '<C-z>', 'u', {desc='^z to Undo'})
bind('n', 'U', '<C-r>', {desc="Create an easy ReDo"})
bind('n', '<Leader>z', 'U', {remap=true, desc=',z to Redo'})
bind('n', 'p', '"*p', {desc='Paste from Universal Buffer'})

bind('n', '<Leader>lua', ':luafile %', {desc="ReSource init.lua"})
bind('n', '<Leader>a', ':keepjumps normal! ggVG<CR>', {desc="Select All Text"})
bind('n', '<Leader>n', ':set invnumber<CR> :set invrelativenumber<CR>', {silent=true, desc='Toggle Line Numbers'})

-- Spelling
bind('n', '<Leader>ss', ':setlocal invspell<CR>', {desc='Toggle spell check'})
bind('n', '<Leader>sa', 'zg', {desc='ADD the word under the cursor to the spell file'})
bind('n', '<Leader>sd', 'zW', {desc='DELETE that was previously marked as good'})
bind('n', '<Leader>sc', 'z=', {desc='CHANGE the word under the cursor (pulls up list)'})
bind('n', '<Leader>sz', ':spellrepall<CR>', {desc='Repeat the replacement of z= for all matches in the current window'})
bind('n', '<Leader>sC', '1z=', {desc='CHANGE the word under the cursor to first suggestion'})
bind('n', '<Leader>sG', 'zG', {desc='IGNORE the word under the cursor - temporary only '})
bind('n', '<Leader>sf', ']s', {desc='Search Forwards for a misspelled word'})
bind('n', '<Leader>sF', '[s', {desc='Search Backwards for a misspelled word'})
bind('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files({cwd=utils.buffer_dir()})<CR>", {desc='Search for Files'})
bind('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>", {desc='Search Live Grep(?)'})
bind('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<CR>", {desc='Search Buffers'})
bind('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<CR>", {desc='Search HelpTags'})

-- Normal and Exec Mode
bind({'n', 'x'}, 'cp', '"+y', {desc="Copy to Clipboard"})
bind({'n', 'x'}, 'cv', '"+p', {desc="Paste from clipboard"})
bind({'n', 'x'}, 'd', '"_d', {desc="Don't write deleted text to clipboard"})
bind({'n', 'x'}, 'c', '"_c', {desc="Don't write changed text to clipboard"})

-- Normal and Visual Mode
bind({'n', 'v'}, '<Leader>d', '"_d', {desc="Delete till end of line"})
bind({'n', 'v'}, '<Leader>U', '<Esc>viwUea', {desc="Change word under cursor to UPPERCASE"})
--bind({'n', 'v'}, '<RightMouse>', ':call GuiShowContextMenu()<CR>', {desc=''})

-- Insert Mode
--bind('i', '<RightMouse>', '<Esc>:call GuiShowContextMenu()<CR>a', {desc=''})
bind('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { noremap = true, expr = true })
bind('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

-- Visual Mode
bind('v', 'j', 'gj', {desc='Allow `j` to work with visual lines'})
bind('v', 'k', 'gk', {desc='Allow `k` to work with visual lines'})

-- Everywhere
bind({'n', 'v', 'x', 'i', 's'}, '<F1>', '<Esc>', {desc="Sometimes you hit F1 by accident, so escape!"})

-- Python Specific
bind('n', '<Leader>Rp', ':update<CR>:exec "!python" shellescape(@%, 1)<CR>', {desc='Run current file in Python'})
bind('n', '<Leader>RP', ':update<CR>:exec "r !python" shellescape(@%, 1)<CR>', {desc='Send output to cursor'})

-- Folding Stuff
bind('n', '<Leader><Space>', 'zx', {desc='Toggle existing fold'})
bind('n', 'z0', ':set foldlevel=0<CR>', {desc='Set Fold Level to 0'})
bind('n', 'z1', ':set foldlevel=1<CR>', {desc='Set Fold Level to 1'})
bind('n', 'z2', ':set foldlevel=2<CR>', {desc='Set Fold Level to 2'})
bind('n', 'z3', ':set foldlevel=3<CR>', {desc='Set Fold Level to 3'})
bind('i', 'z0', '<C-o>:set foldlevel=0<CR>', {desc='Set Fold Level to 0'})
bind('i', 'z1', '<C-o>:set foldlevel=1<CR>', {desc='Set Fold Level to 1'})
bind('i', 'z2', '<C-o>:set foldlevel=2<CR>', {desc='Set Fold Level to 2'})
bind('i', 'z3', '<C-o>:set foldlevel=3<CR>', {desc='Set Fold Level to 3'})

-- NERD Specific KeyMaps
bind('n', '<Leader>Nt', ':NERDTreeToggle<CR>', {desc='Toggle NERDTree'})
bind('n', '<Leader>NC', ':NERDTree CAMA<CR>', {desc='Activate NERDTree CAMA Branch'})
bind('n', '<Leader>NT', ':NERDTree TEST<CR>', {desc='Activate NERDTree TEST Branch'})

-- MiniCompletion <CR> reconfig/helper
-- Copied from |MiniCompletion| #Helpful key mappings
local keys = {
    ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
    ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
    ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
}

_G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
      -- If popup is visible, confirm selected item or add new line otherwise
      local item_selected = vim.fn.complete_info()['selected'] ~= -1
      return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
    else
      -- If popup is not visible, use plain `<CR>`. You might want to customize
      -- according to other plugins. For example, to use 'mini.pairs', replace
      -- next line with `return require('mini.pairs').cr()`
      return keys['cr']
    end
end

bind('i', '<CR>', 'v:lua._G.cr_action()', { noremap = true, expr = true })


-- " I freaking love the ^q so I want to have it back as <leader>q
-- noremap <Leader>q :NERDCommenterInvert
-- " Create Space above or below current line! (Shift above Ctrl)
-- nmap gO O<ESC>j
-- nmap g<C-O> o<ESC>k
-- " Make g{ and g} move paragraphs with text instead of to blank lines
-- nnoremap <expr> g{ len(getline(line('.')-1)) > 0 ? '{+' : '{-'
-- nnoremap <expr> g} len(getline(line('.')+1)) > 0 ? '}-' : '}+'
-- " Highlights last inserted text from insert mode in visual mode
-- nnoremap gV `[v`]
-- " Remove the extra ^M that windows creates at the end of lines
-- noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
-- " Run the entire file through the indent filter with <Leader>=
-- noremap <silent> <Leader>= :call Preserve("normal gg=G")<CR>
