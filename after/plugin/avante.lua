-- after/plugin/avante.lua

-- Load and setup Avante with the required options
local status, avante = pcall(require, 'avante')
if true then
    return
end

avante.setup({
    provider = "claude",                -- Recommend using Claude
    auto_suggestions_provider = "claude", -- Use copilot for inexpensive auto-suggestions
    claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        temperature = 0,
        max_tokens = 4096,
    },
    behaviour = {
        auto_suggestions = false, -- Experimental
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
    },
    mappings = {
        diff = {
            ours = "co",
            theirs = "ct",
            all_theirs = "ca",
            both = "cb",
            cursor = "cc",
            next = "]x",
            prev = "[x",
        },
        suggestion = {
            accept = "<M-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
        jump = {
            next = "]]",
            prev = "[[",
        },
        submit = {
            normal = "<CR>",
            insert = "<C-s>",
        },
        sidebar = {
            apply_all = "A",
            apply_cursor = "a",
            switch_windows = "<Tab>",
            reverse_switch_windows = "<S-Tab>",
        },
    },
    hints = { enabled = true },
    windows = {
        position = "right", -- Sidebar position
        wrap = true,    -- Enable wrap
        width = 30,     -- Sidebar width
        sidebar_header = {
            enabled = true, -- Enable/disable header
            align = "center", -- Title alignment
            rounded = true,
        },
        input = {
            prefix = "> ",
        },
        edit = {
            border = "rounded",
            start_insert = true, -- Start in insert mode when editing
        },
        ask = {
            floating = false, -- AvanteAsk prompt floating window
            start_insert = true, -- Insert mode on floating window open
            border = "rounded",
        },
    },
    highlights = {
        diff = {
            current = "DiffText",
            incoming = "DiffAdd",
        },
    },
    diff = {
        autojump = true,
        list_opener = "copen", -- Command for opening diff list
    },
})
