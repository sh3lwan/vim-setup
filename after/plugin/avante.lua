-- after/plugin/avante.lua

-- Load and setup Avante with the required options
local status, avante = pcall(require, 'avante')
if not status then
    return
end
-- Function to get project-specific history file path
local function get_history_file_path()
    local project_root = vim.fn.getcwd()
    local project_name = vim.fn.fnamemodify(project_root, ':t')
    local history_dir = vim.fn.stdpath("data") .. "/avante_history"
    -- Create history directory if it doesn't exist
    vim.fn.mkdir(history_dir, "p")
    return history_dir .. "/" .. project_name .. "_history.md"
end

-- Function to save history to .md file with timestamp
local function save_to_md_file(question, answer)
  local history_file_path = get_history_file_path()
  local file = io.open(history_file_path, "a") -- Open in append mode
  if file then
      local timestamp = os.date("%Y-%m-%d %H:%M:%S")
      file:write("## " .. timestamp .. "\n\n")
      file:write("### Question\n")
      file:write(question .. "\n\n")
      file:write("### Answer\n")
      file:write(answer .. "\n\n")
      file:write("---\n\n")
      file:close()
  else
      vim.notify("Error: Unable to write to history file: " .. history_file_path, vim.log.levels.ERROR)
  end
end
  
  -- Function to load and display history
local function load_history()
  local history_file_path = get_history_file_path()
  local file = io.open(history_file_path, "r")
  if file then
      local content = file:read("*all")
      file:close()
      -- Create a new buffer for history
      vim.cmd('new')
      vim.cmd('setlocal buftype=nofile')
      vim.cmd('setlocal bufhidden=hide')
      vim.cmd('setlocal noswapfile')
      vim.api.nvim_buf_set_name(0, 'Avante History')
      -- Set buffer content
      local lines = vim.split(content, '\n')
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      -- Set buffer options
      vim.cmd('setlocal readonly')
      vim.cmd('setlocal filetype=markdown')
  else
      vim.notify("No history file found for current project", vim.log.levels.INFO)
  end
end

-- Create vim command to view history
vim.api.nvim_create_user_command('AvanteHistory', load_history, {})

avante.setup({
    on_result = function(question, answer)
            vim.notify("Question: " .. question, vim.log.levels.INFO)
            vim.notify("Answer: " .. answer, vim.log.levels.INFO)
            save_to_md_file(question, answer)
    end,
    provider = "claude",                  -- Recommend using Claude
    auto_suggestions_provider = "claude", -- Use copilot for inexpensive auto-suggestions
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
