-- This file is loaded by $LOCALAPPDATA\nvim\init.lua by calling `require('user.plugins')`

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'    -- Packer can manage itself

    -- Testing These: Sort Later
    use { 'numToStr/Comment.nvim' }
    --use { 'nvim-orgmode/orgmode' }
    use { 'nvim-neorg/neorg',
        run = ':Neorg sync-parsers',
        requires = 'nvim-lua/plenary.nvim',
    }

    -- Games
    use { 'seandewar/nvimesweeper', opt = true} -- :Nvimesweeper
    use { 'seandewar/killersheep.nvim', opt = true } -- :KillKillKill
    use { 'rktjmp/shenzhen-solitaire.nvim', opt = true } -- :ShenzenSolitaireNewGame

    -- LSP (Language Server Protocol)
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},
        -- Snippet Collection (Optional)
        {'rafamadriz/friendly-snippets'},
      }
    }

    -- Tree Sitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- Needs to be updated often

    -- Mini NVim Plugins (a bunch of mini plugins)
    use 'echasnovski/mini.nvim'

    -- Environment
        -- General
    use 'tpope/vim-surround'        -- TODO: Lua
    use 'easymotion/vim-easymotion' -- TODO: Lua
    use 'godlygeek/tabular'         -- TODO: Lua
    use { 'folke/which-key.nvim',      -- Hit a keybinding, and pause, a nice menu appears
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require('which-key').setup {}
        end
    }

        -- NERDTree
    use 'preservim/nerdtree' -- TODO: Lua
    use { 'PhilRunninger/nerdtree-buffer-ops', requires = 'preservim/nerdtree' } -- TODO: Lua -- Highlight Open Files in Buffers
    use { 'PhilRunninger/nerdtree-visual-selection', requires = 'preservim/nerdtree' } -- TODO: -- Delete, Move, Copy visual selections in NERDTree

        -- Color Stuff    
    use 'tanvirtin/monokai.nvim'    -- Molokai in Lua

        -- Status Line (TODO Configure this better OR replace with custom Line)
    use 'nvim-lualine/lualine.nvim'
        
        -- Snippets
    use({ "L3MON4D3/LuaSnip", tag = "v1.*" })
    use "rafamadriz/friendly-snippets" -- A ton of snippets for LuaSnip

        -- Clipboard Management
    use { "AckslD/nvim-neoclip.lua",
        requires = {
            {'nvim-telescope/telescope.nvim'},         -- Searchable via Telescope
            {'kkharji/sqlite.lua', module = 'sqlite'}, -- Persistant Clipboard
        },
        config = function()
            require('neoclip').setup()
        end,
    }

    -- Python
    use { 'davidhalter/jedi-vim', ft = {'py'} } -- TODO: Lua
    use { 'tmhedberg/SimplyIFold', ft = {'py'}, requires = {'Konfekt/FastFold'} } -- Makes folding in Python easier

    -- WebStuff - HTML/CSS/JS/JSON
    use { 'tpope/vim-characterize', opt = true }    -- TODO: Lua & only on HTML 
    use { 'tpope/vim-jdaddy', opt = true }          -- TODO: Lua & only JSON

    -- Lua
    use 'nvim-lua/plenary.nvim'      -- TODO: Lua

    -- DB (SQLite Specific for me)
    use { 'tpope/vim-dadbod', opt = true, ft = {'sqlite'} }          -- TODO: Lua & only on sqlite
    use { "kkharji/sqlite.lua" }

    -- Connect to Chrome/FF (requires extension) and edit text areas
    use { 'glacambre/firenvim', 
        run = function() 
            vim.fn['firenvim#install'](0) 
        end 
    }

    -- Telescope
    use { 'nvim-telescope/telescope.nvim', 
        tag = '0.1.0', 
        requires = { 
            {'nvim-lua/plenary.nvim'} 
        } 
    }
    -- Extensions for Telescope
    use {'sudormrfbin/cheatsheet.nvim', -- TODO: Configure and get extra cheatsheets!
        requires = {
            {'nvim-telescope/telescope.nvim'},
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
        }
    }

    use { 'nvim-telescope/telescope-file-browser.nvim' } -- Easy Integration of Files and Telescope
    use { 'nvim-telescope/telescope-frecency.nvim', 
        config = function()
            require('telescope').load_extension('frecency')
        end,
        requires = {"kkharji/sqlite.lua"} 
    }
    use { "benfowler/telescope-luasnip.nvim", -- LuaSnip Intergration
        config = function()
            require('telescope').load_extension('luasnip')
        end,
    }
    use { 'nvim-telescope/telescope-packer.nvim' } -- Integration with Packer
end)
