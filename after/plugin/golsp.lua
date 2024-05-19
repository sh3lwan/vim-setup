require('lspconfig').gopls.setup({
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
})

-- Example configuration for lspconfig
--require('lspconfig').cssls.setup{}
--require('lspconfig').tsserver.setup{}

