local status, telescope = pcall(require, 'telescope')

if not status then
    return
end

telescope.setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "vendor",
            ".git",
            ".templ.go"
        },
        layout_config = {
            ---preview_cutoff = 100,
            preview_width = 0.6, -- Adjust this value to increase the preview width
        },
        --layout_strategy = 'horizontal',
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

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })

if builtin.file_history then
    vim.keymap.set('n', '<leader>fh', builtin.file_history, { desc = 'Telescope file history' })
else
    print("file_history is not available in telescope.builtin")
end

if builtin.git_status then
    vim.keymap.set('n', '<leader>fs', builtin.git_status, { desc = 'Telescope git status' })
else
    print("git_status is not available in telescope.builtin")
end

if builtin.git_commits then
    vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = 'Telescope git commits' })
else
    print("git_commits is not available in telescope.builtin")
end

-- Safely expand <cword> and handle potential nil/false values
vim.api.nvim_set_keymap('n', '<leader>FG',
    [[:lua vim.cmd("Telescope live_grep default_text=" .. (vim.fn.expand("<cword>") or "") .. "")<CR>]],
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>FF',
    [[:lua vim.cmd("Telescope find_files default_text=" .. (vim.fn.expand("<cword>") or "") .. "")<CR>]],
    { noremap = true, silent = true })
