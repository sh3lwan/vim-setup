require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "vendor",
            ".git"
        }
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
                n = {
                    ["d"] = "delete_buffer",
                },
                i = {
                    ["<c-d>"] = "delete_buffer",
                }
            }
        }
    }
}
