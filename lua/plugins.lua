local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_installed = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Automatically sync Packer if it's a fresh install
    if packer_installed then
        require('packer').sync()
    end


    -- Fuzzy Finding
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        requires = {
            --'nvim-lua/popup.nvim', -- creating an issue with telescope
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim'
        }
    }

    -- Color Scehem
    use { "catppuccin/nvim", as = "catppuccin" }

    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required



        }
    }

    -- For JS & TS:
    use { 'jose-elias-alvarez/null-ls.nvim', 'windwp/nvim-ts-autotag' }

    -- Show method params names when writing
    use {
        "ray-x/lsp_signature.nvim",
    }

    -- Linter - For errors and bugs detections
    use 'mfussenegger/nvim-lint'

    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/nvim-nio",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-go",
            "olimorris/neotest-phpunit",
            "V13Axel/neotest-pest",
        },
    }

    -- Terminal
    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end }

    -- Git related plugins
    use { 'tpope/vim-fugitive' }
    use { 'tpope/vim-rhubarb' }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'nvim-tree/nvim-web-devicons',
            "meuter/lualine-so-fancy.nvim",
        }
    }


    --Harpoon
    use {
        'ThePrimeagen/harpoon',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    use {
        "windwp/nvim-autopairs",
        opts = {
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)

            -- setup cmp for autopairs
            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    }

    use {
        "stevearc/oil.nvim",
        requires = { "nvim-tree/nvim-web-devicons" },
        opts = {}
    }


    use {
        "nvim-neo-tree/neo-tree.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",

        }
    }

    use {
        "folke/todo-comments.nvim",

        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    }


    --use("lukas-reineke/indent-blankline.nvim")

    --
    -- use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

    -- Disabled Because it created errors - Used for html cmp
    -- use {
    --     'hrsh7th/vim-vsnip',
    --     'hrsh7th/vim-vsnip-integ',
    --     "saadparwaiz1/cmp_luasnip",
    --     "rafamadriz/friendly-snippets",
    -- }

    -- Airline Bar
    --	use 'vim-airline/vim-airline'
    --	use 'vim-airline/vim-airline-themes'
end)
