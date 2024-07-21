local ftMap = {
    vim = 'indent',
    python = { 'indent' },
    git = ''
}
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"

vim.opt.foldmethod = "indent"

-- :h vim.treesitter.foldexpr()
--vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- ref: https://github.com/neovim/neovim/pull/20750
vim.opt.foldtext = ""
vim.opt.fillchars:append("fold: ")

-- Open all folds by default, zm is not available
vim.opt.foldlevelstart = 99
--require('ufo').setup({
--    open_fold_hl_timeout = 0,
--    close_fold_kinds_for_ft = {
--        default = { {} },
--        json = { 'array' },
--        c = { 'comment', 'region' }
--    },
--    preview = {
--        win_config = {
--            border = { '', '─', '', '', '', '─', '', '' },
--            winhighlight = 'Normal:Normal',
--            winblend = 0
--        },
--        mappings = {
--            scrollU = '<C-u>',
--            scrollD = '<C-d>',
--            jumpTop = '[',
--            jumpBot = ']'
--        },
--        maxheight =  {
--            default = 50,
--        }
--    },
--    provider_selector = function(bufnr, filetype, buftype)
--        -- if you prefer treesitter provider rather than lsp,
--        -- return ftMap[filetype] or {'treesitter', 'indent'}
--        return ftMap[filetype]
--
--        -- refer to ./doc/example.lua for detail
--    end
--})
--vim.keymap.set('n', 'zO', require('ufo').openAllFolds)
--vim.keymap.set('n', 'zC', require('ufo').closeAllFolds)
--vim.keymap.set('n', 'zo', require('ufo').openFoldsExceptKinds)
--vim.keymap.set('n', 'zc', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
--vim.keymap.set('n', 'K', function()
--    local winid = require('ufo').peekFoldedLinesUnderCursor()
--    if not winid then
--        -- choose one of coc.nvim and nvim lsp
--        vim.fn.CocActionAsync('definitionHover') -- coc.nvim
--        vim.lsp.buf.hover()
--    end
--end)
