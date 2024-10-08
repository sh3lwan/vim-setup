vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile",
})

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Fuzzy Finding
    use {
        'nvim-telescope/telescope.nvim',
        --'dawsers/telescope-file-history.nvim',
        tag = '0.1.2',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }
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
