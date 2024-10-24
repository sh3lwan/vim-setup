-- Configure TypeScript/JavaScript server
require('lspconfig').ts_ls.setup({
    on_attach = function(client)
        --client.resolved_capabilities.document_formatting = false
    end,
})

local null_ls = require('null-ls')
-- Setup null-ls with eslint and prettier
null_ls.setup {
    sources = {
        --null_ls.builtins.diagnostics.eslint_d, -- ESLint diagnostics
        null_ls.builtins.formatting.prettier, -- Prettier for formatting
    },
}
