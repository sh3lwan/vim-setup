vim.cmd([[imap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)': '<C-j>']])
vim.cmd([[smap <expr> <C-j> vsnip#expandable() ? '<Plug>(vsnip-expand)': '<C-j>']])

vim.cmd([[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])
vim.cmd([[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])


vim.cmd([[imap <expr> <Tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<Tab>']])
vim.cmd([[smap <expr> <Tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<Tab>']])
vim.cmd([[imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']])
vim.cmd([[smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']])

-- If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
vim.g.vsnip_filetypes = {
    javascriptreact = { 'javascript' },
    typescriptreact = { 'typescript' }
}
