-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
--vim.cmd.packadd('packer.nvim')
-- Automatically run: PackerCompile
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile",
})

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' }
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
    })

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

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
    -- Snippet engine
    use('hrsh7th/vim-vsnip')
    -- Adds extra functionality over rust analyzer
    use("simrat39/rust-tools.nvim")

    -- Terminal
    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end }

    -- Git related plugins
    use { 'tpope/vim-fugitive' }
    use { 'tpope/vim-rhubarb' }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
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

    -- Airline Bar
    --	use 'vim-airline/vim-airline'
    --	use 'vim-airline/vim-airline-themes'
end)
