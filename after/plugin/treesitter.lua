local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

ts.setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    ensure_installed = {
        "markdown",
        "tsx",
        "typescript",
        "javascript",
        "json",
        "yaml",
        "rust",
        "css",
        "html",
        "lua",
        "vue",
        "php",
        "templ",
        "go"
    },
    rainbow = {
        enable = true,
        --disable = { "html" },
        --extended_mode = false,
        --max_file_lines = nil,
    },
    autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = { "html", "xml", "templ"},
    },
    incremental_selection = { enable = true },
    indent = { enable = true },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }


vim.filetype.add({
    extension = {
        templ = "templ",
    },
})
