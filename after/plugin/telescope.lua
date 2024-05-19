require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "vendor",
            ".git",
            ".templ.go"
        }
    },
    path_display = {
        "filename_first",
    },
    mappings = {
        n = {
            ["d"] = "delete_buffer",
        },
        i = {
            ["<c-d>"] = "delete_buffer",
        }
    },
    sorting_strategy = "ascending",
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
            },
        }
    }
}
