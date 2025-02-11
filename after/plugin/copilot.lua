local status, copilot = pcall(require, 'copilot')

if not status then
    return
end

-- Function to toggle Copilot
local function toggle_copilot()
    local enabled = require("copilot.client").is_disabled()
    if enabled then
        vim.cmd("Copilot enable")
        vim.notify("Copilot enabled", vim.log.levels.INFO)
    else
        vim.cmd("Copilot disable")
        vim.notify("Copilot disabled", vim.log.levels.INFO)
    end
end

-- Add keybinding for toggle
vim.keymap.set("n", "<leader>cp", toggle_copilot, { noremap = true, silent = true, desc = "Toggle Copilot" })

require('copilot').setup({
    panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
        },
        layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
    },
    filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },
    copilot_node_command = 'node', -- Node.js version must be > 18.x
    server_opts_overrides = {},
})
