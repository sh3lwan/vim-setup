local status, masonlsp = pcall(require, "mason-lspconfig")

if not status then
    return
end

masonlsp.setup({
    automatic_installation = true,
    ensure_installed = {
        "phpactor",
        "sqlls",
        "volar",
        "dockerls",
        "cssls",
        "eslint",
        "html",
        "jsonls",
        "tsserver",
        "tailwindcss",
        "rust_analyzer",
    },
})
