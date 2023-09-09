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

    use ({
        'rose-pine/neovim',
        as = 'rose-pine',
        config= function()
            vim.cmd("colorscheme rose-pine")
        end
    })

	--use ({
	--	'catppuccin/nvim',
	--	as = "catppuccin",

	--})

    use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }

    -- Terminal
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}

    -- Git related plugins
    use {'tpope/vim-fugitive'}
    use {'tpope/vim-rhubarb'}

    use {
        'nvim-lualine/lualine.nvim',
        --requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    -- Airline Bar
    --	use 'vim-airline/vim-airline'
    --	use 'vim-airline/vim-airline-themes'

end)
