require('telescope').setup{
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "vendor",
            ".git/*",
        }
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
}