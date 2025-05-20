local status, masonlsp = pcall(require, "mason-lspconfig")

if not status then
    return
end

masonlsp.setup({
    ['pest_ls'] = function()
        require('pest-vim').setup {}
    end,
    automatic_installation = true,
    ensure_installed = {
        "phpactor",
        "intelephense",
        -- "sqlls",
        -- "volar",
        -- "dockerls",
        -- "cssls",
        --"eslint",
        --"html",
        --"jsonls",
        "tailwindcss",
        "templ",
        "lua_ls",
        "gopls"
    },
})
