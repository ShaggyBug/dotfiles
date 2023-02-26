local telescope = require('telescope')
local builtin = require('telescope.builtin')
local utils = require('telescope.utils')
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

local lst = require('telescope').extensions.luasnip
local luasnip = require('luasnip')

local SQLiteDBLoc = 'C:/Users/AppData/Local/nvim-data/shada'

--vim.keymap.set('n', '<leader>ff', builtin.find_files({cwd=utils.buffer_dir()}), {desc='Telescope: Find Files'})
vim.keymap.set('n', '<leader>flg', builtin.live_grep, {desc='Telescope: Live Grep'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc='Telescope: Buffers'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc='Telescope: Help Tags'})
vim.keymap.set('n', '<leader>fgs', builtin.grep_string, {desc='Telescope: Grep String'})


telescope.setup({
    defaults = {
        initial_mode = 'normal',
        layout_strategy = 'vertical',
        preview_height = 0.6,
        prompt_prefix = '>> ',
        prompt_position = 'top',
        mappings = {
            n = {
                ['<leader>ff'] = {
                    function() builtin.find_files({
                        cwd = utils.buffer_dir()
                    }) end,
                    desc = "Telescope: Find files in Current Buffer Dir"
                },
                ['<leader>sc'] = { 
                    function () builtin.spell_suggest() end, 
                    desc = "Telescope: List Spelling Suggestions"
                },
            },
            --i = {
            --},
        },
    },
    buffers = {
        theme = 'dropdown',
    },
    pickers = {
        find_files = {
            theme = 'dropdown',
            mappings = {
                n = {
                    ["cd"] = function(prompt_bufnr)
                        local selection = require("telescope.actions.state").get_selected_entry()
                        local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                        require("telescope.actions").close(prompt_bufnr)
                        vim.cmd(string.format("silent cd %s", dir))
                  end
                }
            }
        }
    },
    extensions = {
        frecency = {
            db_root = nil,
            disable_devicons = true,
            workspaces = {
                ["TEST"] = vim.fn.expand('$CAMATEST'),
                ["PROD"] = vim.fn.expand('$CAMAPROD'),
            }
        },
        packer = {
			theme = "ivy",
			layout_config = {
				height = .5
			}
		},
        luasnip = {
            search = function(entry)
                return lst.filter_null(entry.context.trigger) .. " " ..
                       lst.filter_null(entry.context.name) .. " " ..
                       entry.ft .. " " ..
                       lst.filter_description(entry.context.name, entry.context.description) ..
                       lst.get_docstring(luasnip, entry.ft, entry.context)[1]
            end
        },
    },
})

-- Extensions 
telescope.load_extension('frecency') -- A sorter that uses Mozilla's sorting to search
telescope.load_extension('luasnip') -- LuaSnip Integration
telescope.load_extension('packer') -- Integrate Packer!


