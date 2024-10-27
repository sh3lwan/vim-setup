-- after/plugin/avante.lua

-- Load and setup Avante with the required options
local status, avante = pcall(require, 'avante')
if not status then
    return
end

avante.setup({
    provider = "copilot",                  -- Recommend using Claude
    auto_suggestions_provider = "copilot", -- Use copilot for inexpensive auto-suggestions
    vendors = {

    --
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-sonnet",
            temperature = 0,
            max_tokens = 4096,
        },
        ollama = {
            ["local"] = true,
            endpoint = "127.0.0.1:11434/v1",
            model = "llama3.2",
            parse_curl_args = function(opts, code_opts)
                return {
                    url = opts.endpoint .. "/chat/completions",
                    headers = {
                        ["Accept"] = "application/json",
                        ["Content-Type"] = "application/json",
                    },
                    body = {
                        model = opts.model,
                        messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
                        max_tokens = 2048,
                        stream = true,
                    },
                }
            end,
            parse_response_data = function(data_stream, event_state, opts)
                require("avante.providers").openai.parse_response(data_stream, event_state, opts)
            end,
        },
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
        position = "right",   -- Sidebar position
        wrap = true,          -- Enable wrap
        width = 30,           -- Sidebar width
        sidebar_header = {
            enabled = true,   -- Enable/disable header
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
            floating = false,    -- AvanteAsk prompt floating window
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
