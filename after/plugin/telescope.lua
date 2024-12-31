local status, telescope = pcall(require, 'telescope')

if not status then
    return
end

local action_state = require('telescope.actions.state')

local function filter_conflict_files(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local entries = {}

    -- Iterate over entries in the manager
    for entry in picker.manager:iter() do
        if entry.value:match("UU") then -- Filter files with conflicts ('UU' indicates conflict)
            table.insert(entries, entry)
        end
    end

    -- Refresh picker with filtered entries
    picker:reset_selection()
    picker:refresh(function() return entries end, { reset_prompt = true })
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
           prompt_position = "top",
           --mirror = true,
           --preview_cutoff = 100,
           --preview_height = 0.8,
        }
        --layout_config = {
            --preview_cutoff = 100,
            --     preview_width = 0.6, -- Adjust this value to increase the preview width
        --},
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
            --hidden = true,
            previewer = true,
            theme = "dropdown",
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
        },
       -- git_status = {
       --     initial_mode = "normal",
       --     mappings = {
       --        -- i = {
       --        --     ["<C-s>"] = filter_conflict_files,
       --        -- },
       --        -- n = {
       --        --     ["<C-s>"] = filter_conflict_files,
       --        -- }
       --     }
       -- }
    }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Telescope resume search' })
vim.keymap.set('n', '<leader>fm', function()
  builtin.treesitter {
    prompt_title = "Search Functions",
    symbols = { 'function', 'method' } -- Search functions and methods
  }
end, { desc = "Find Functions using Telescope" })

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


if builtin.git_branches then
    vim.keymap.set('n', '<leader>fB', builtin.git_branches, { desc = 'Telescope git branches' })
else
    print("git_branches is not available in telescope.builtin")
end


-- Safely expand <cword> and handle potential nil/false values
vim.api.nvim_set_keymap('n', '<leader>FG',
    [[:lua vim.cmd("Telescope live_grep default_text=" .. (vim.fn.expand("<cword>") or "") .. "")<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap('v', '<leader>FG',
    [[:<C-U>lua local text = vim.fn.escape(vim.fn.getreg('\"'), ' '); vim.cmd('Telescope live_grep default_text=' .. text)<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap('n', '<leader>FF',
    [[:lua vim.cmd("Telescope find_files default_text=" .. (vim.fn.expand("<cword>") or "") .. "")<CR>]],
    { noremap = true, silent = true })
