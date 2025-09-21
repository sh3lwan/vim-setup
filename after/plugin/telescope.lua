local ok, telescope = pcall(require, "telescope")
if not ok then return end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")

-- Helpers
local function in_git_repo()
    return vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):find("true") ~= nil
end

local function project_files()
    if in_git_repo() then
        builtin.git_files({ show_untracked = true })
    else
        builtin.find_files()
    end
end

-- Conflicts-only picker (fast + robust)
local function git_conflicts_picker()
    local cmd = { "bash", "-lc", "git diff --name-only --diff-filter=U" }
    builtin.find_files({
        prompt_title = "Git Conflicts",
        find_command = cmd, -- feed file list via stdin? Simpler: use `fd` fallback
    })
end

-- Or: filter inside git_status by entry.status
local function filter_conflict_files_in_status(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local filtered = {}

    for entry in picker.manager:iter() do
        -- entry.value.status exists in git_status; 'UU', 'AA', 'DD', etc.
        local st = (entry.value.status or entry.status or "")
        if st:find("U") then
            table.insert(filtered, entry)
        end
    end
    picker:reset_selection()
    picker:refresh(function() return filtered end, { reset_prompt = true })
end

telescope.setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob", "!.git/",
        },
        file_ignore_patterns = {
            "node_modules", "vendor", "%.lock", "%.cache", "%.min%.js",
            ".git/", ".next/", "dist/", "build/", "%.templ%.go",
        },
        sorting_strategy = "ascending",
        layout_config = {
            prompt_position = "top",
            -- flex layout auto-switches column/row, nice defaults:
            -- width/height scale well without hand-tuning
        },
        path_display = { "filename_first", "truncate" }, -- short & readable
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<C-d>"] = actions.delete_buffer,
                -- ["<Esc>"] = actions.close,
            },
            n = {
                ["q"]     = actions.close,
                ["d"]     = actions.delete_buffer,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                --["Esc"]  = function () return false end,
            },
        },
        dynamic_preview_title = true,
        -- preview = { filesize_limit = 1 }, -- uncomment if big files stall preview
    },

    pickers = {
        find_files = {
            theme = "dropdown",
            previewer = true,
            initial_mode = "insert",
            hidden = true,
            find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
        },
        buffers = {
            theme = "dropdown",
            previewer = true,
            initial_mode = "normal",
            sort_lastused = true,
            mappings = {
                i = { ["<C-d>"] = actions.delete_buffer },
                n = { ["d"] = actions.delete_buffer },
            },
        },
        git_status = {
            initial_mode = "normal",
            mappings = {
                n = {
                    ["<C-s>"] = filter_conflict_files_in_status,
                },
                i = {
                    ["<C-s>"] = filter_conflict_files_in_status,
                },
            },
        },
    },

    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        ["live_grep_args"] = {
            auto_quoting = true, -- makes adding -F/-w/etc easier
            mappings = {
                i = {
                    ["<C-f>"] = require("telescope-live-grep-args.actions").quote_prompt(),                    -- literal
                    ["<C-w>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -w" }), -- whole word
                },
            },
        },
        ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
    },
})

-- Load extensions
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "live_grep_args")
pcall(telescope.load_extension, "ui-select")

-- Keymaps
vim.keymap.set("n", "<leader>ff", project_files, { desc = "Find files (smart git)" })
vim.keymap.set("n", "<leader>fF", builtin.find_files, { desc = "Find files (all)" })
vim.keymap.set("n", "<leader>fg", telescope.extensions.live_grep_args.live_grep_args, { desc = "Live grep (args)" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume" })
vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Git status" })
vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "Git commits" })
vim.keymap.set("n", "<leader>fb", builtin.git_branches, { desc = "Git branches" })

-- Grep word under cursor (regex-capable)
vim.keymap.set("n", "<leader>FG", function()
    builtin.live_grep({ default_text = vim.fn.expand("<cword>") })
end, { desc = "Grep <cword>" })

-- Grep visual selection (regex-capable)
vim.keymap.set("v", "<leader>FG", function()
    local text = vim.fn.escape(vim.fn.getreg('v'), "\\/.*$^~[]") -- conservative escape for safety
    builtin.live_grep({ default_text = text })
end, { desc = "Grep selection" })

-- Find files with <cword> prefilled
vim.keymap.set("n", "<leader>FF", function()
    builtin.find_files({ default_text = vim.fn.expand("<cword>") })
end, { desc = "Find files with <cword>" })

-- Conflicts fast pick
vim.keymap.set("n", "<leader>fU", git_conflicts_picker, { desc = "Git conflicts" })
