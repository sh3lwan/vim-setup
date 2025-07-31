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
        --"intelephense",
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


require("lspconfig").dartls.setup({
    cmd = { "dart", "language-server", "--protocol=lsp" },
    filetypes = { "dart" },
    init_options = {
        closingLabels = true,
        flutterOutline = true,
        onlyAnalyzeProjectsWithOpenFiles = true,
        outline = true,
        suggestFromUnimportedLibraries = true,
    },
    -- root_dir = root_pattern("pubspec.yaml"),
    settings = {
        dart = {
            completeFunctionCalls = true,
            showTodos = true,
        },
    },
    on_attach = function(client, bufnr)
    end,
})
