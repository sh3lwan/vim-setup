return {
    -- Fuzzy Finding
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            --'nvim-lua/popup.nvim', -- creating an issue with telescope
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim'
        }
    },

    -- Color Scehem
    { "catppuccin/nvim", as = "catppuccin" },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },                  -- Required
            { 'hrsh7th/cmp-nvim-lsp' },              -- Required
            { 'L3MON4D3/LuaSnip' },                  -- Required
        }
    },

    -- For JS & TS:
    'jose-elias-alvarez/null-ls.nvim',
    'windwp/nvim-ts-autotag',

    -- Show method params names when writing
    "ray-x/lsp_signature.nvim",

    -- Linter - For errors and bugs detections
    'mfussenegger/nvim-lint',

    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/nvim-nio",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-go",
            "olimorris/neotest-phpunit",
            "V13Axel/neotest-pest",
        },
    },

    -- Terminal
   -- {
   --     "akinsho/toggleterm.nvim",
   --     tag = '*',
   --     config = function()
   --         require("toggleterm").setup()
   --     end
   -- },

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            "meuter/lualine-so-fancy.nvim",
        }
    },


    --Harpoon
    {
        'ThePrimeagen/harpoon',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },

    {
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
    },

    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },


    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",

        }
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },


   -- {
   --     "adalessa/laravel.nvim",
   --     dependencies = {
   --         "nvim-telescope/telescope.nvim",
   --         "tpope/vim-dotenv",
   --         "MunifTanjim/nui.nvim",
   --         "nvimtools/none-ls.nvim",
   --     },
   --     opts = {
   --         features = {
   --             null_ls = {
   --                 enable = true,
   --             },
   --             route_info = {
   --                 enable = true,      --- to enable the laravel.nvim virtual text
   --                 position = 'right', --- where to show the info (available options 'right', 'top')
   --                 middlewares = true, --- wheather to show the middlewares section in the info
   --                 method = true,      --- wheather to show the method section in the info
   --                 uri = true          --- wheather to show the uri section in the info
   --             },
   --         },
   --     },
   -- },

    -- AI Stuff - Avante
    {
        "yetone/avante.nvim",
        event = "VeryLazy", -- Equivalent to lazy loading on certain events
        version = false,    -- Always pull the latest changes
        --opts = {},    -- Add any options you want here
        build = "make",     -- Build command for non-Windows
        -- For Windows, you could use the following:
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
        dependencies = {
            -- Required dependencies
            { "nvim-treesitter/nvim-treesitter" },
            { "stevearc/dressing.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "MunifTanjim/nui.nvim" },
            { "nvim-tree/nvim-web-devicons" }, -- Optional
            { "zbirenbaum/copilot.lua" },      -- Optional, for providers='copilot'

            -- Dependency for image pasting support
            {
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy", -- Lazy loading
                config = function()
                    require('img-clip').setup({
                        default = {
                            embed_image_as_base64 = false,
                            prompt_for_file_name = false,
                            drag_and_drop = {
                                insert_mode = true,
                            },
                            use_absolute_path = true, -- Required for Windows users
                        },
                    })
                end,
            },

            -- Dependency for rendering markdown
            {
                'MeanderingProgrammer/render-markdown.nvim',
                ft = { "markdown", "Avante" }, -- Lazy load based on file types
                opts = function()
                    require('render-markdown').setup({
                        file_types = { "markdown", "Avante" }
                    })
                end,
            },
        },
    },
}
