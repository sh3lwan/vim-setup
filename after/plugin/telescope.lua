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
            initial_mode = "insert",
            hidden = true,
        },
        buffers = {
            initial_mode = "normal",
            show_all_buffers = true,
            sort_lastused = true,
            theme = "dropdown",
            previewer = true,
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
