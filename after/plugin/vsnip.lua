vim.cmd([[imap <expr> <Tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<Tab>']])
vim.cmd([[smap <expr> <Tab> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<Tab>']])
vim.cmd([[imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']])
vim.cmd([[smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']])
