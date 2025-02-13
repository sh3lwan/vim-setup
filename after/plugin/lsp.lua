local lsp = require("lsp-zero")

lsp.preset("recommended")

--lsp.ensure_installed({
--    'ts_ls',
--    'eslint',
--    'tailwindcss',
--})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)

    -- pause autoformat for now
    vim.keymap.set("n", "<leader><leader>", function()
        vim.lsp.buf.format()
    end, opts)

    vim.keymap.set("n", '<leader>e', function()
        vim.diagnostic.open_float({ scope = "line" });
    end)

    vim.keymap.set("n", "<leader>hd", function()
        vim.diagnostic.config({ virtual_text = false })
    end)

    vim.keymap.set("n", "<leader>sd", function()
        vim.diagnostic.config({ virtual_text = true })
    end)

    --    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    --    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    --    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    --    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    --    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    --    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()



-- Diagnostics Messages Config
vim.diagnostic.config({
    virtual_text = false, -- Hide or show message on line
    signs = true,
    update_in_insert = false,
    underline = true,
})

-- Format Before Save
--vim.api.nvim_create_autocmd("BufWritePre", {
--    callback = function()
--        vim.lsp.buf.format()
--    end,
--})
