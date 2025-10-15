local M = {}

local comment_patterns = {
    ts_ls = "// %s",
    tsserver = "// %s",
    eslint = "// %s",
    javascript = "// %s",
    typescript = "// %s",
    pyright = "# %s",
    pylsp = "# %s",
    python = "# %s",
    gopls = "// %s",
    go = "// %s",
    lua_ls = "-- %s",
    lua = "-- %s",
    phpactor = "// %s",
    intelephense = "// %s",
    php = "// %s",
    rust_analyzer = "// %s",
    rust = "// %s",
    cssls = "/* %s */",
    css = "/* %s */",
    html = "<!-- %s -->",
    jsonls = "",
    bashls = "# %s",
    bash = "# %s",
    sh = "# %s",
    zsh = "# %s",
    vimls = '" %s',
    vim = '" %s',
    yamlls = "# %s",
    yaml = "# %s",
    clangd = "// %s",
    c = "// %s",
    cpp = "// %s",
}

local function get_comment_pattern()
    local clients = {}
    
    if vim.lsp.get_clients then
        clients = vim.lsp.get_clients({ bufnr = 0 })
    elseif vim.lsp.get_active_clients then
        clients = vim.lsp.get_active_clients({ bufnr = 0 })
    end
    
    if #clients > 0 then
        for _, client in ipairs(clients) do
            local pattern = comment_patterns[client.name]
            if pattern and pattern ~= "" then
                return pattern
            end
        end
    end
    
    local filetype = vim.bo.filetype
    local pattern = comment_patterns[filetype]
    if pattern and pattern ~= "" then
        return pattern
    end
    
    local commentstring = vim.bo.commentstring
    if commentstring and commentstring ~= "" then
        return commentstring
    end
    
    return "# %s"
end

local function trim_whitespace(str)
    return str:match("^%s*(.-)%s*$")
end

local function is_line_commented(line, comment_start, comment_end)
    local trimmed = trim_whitespace(line)
    
    if trimmed == "" then
        return false
    end
    
    -- Remove trailing whitespace from comment_start for flexible matching
    local comment_prefix = comment_start:match("^(.-)%s*$")
    
    if comment_end and comment_end ~= "" then
        local escaped_start = vim.pesc(comment_prefix)
        local escaped_end = vim.pesc(comment_end)
        return trimmed:match("^" .. escaped_start) ~= nil and trimmed:match(escaped_end .. "$") ~= nil
    else
        local escaped_start = vim.pesc(comment_prefix)
        return trimmed:match("^" .. escaped_start) ~= nil
    end
end

local function comment_line(line, pattern)
    if line:match("^%s*$") then
        return line
    end
    
    local comment_start, comment_end = pattern:match("^(.-)%%s(.*)$")
    comment_start = comment_start or pattern
    comment_end = comment_end or ""
    
    local indent = line:match("^(%s*)")
    local content = line:match("^%s*(.-)$")
    
    if content == "" then
        return line
    end
    
    if comment_end and comment_end ~= "" then
        return indent .. comment_start .. content .. comment_end
    else
        return indent .. comment_start .. content
    end
end

local function uncomment_line(line, pattern)
    local comment_start, comment_end = pattern:match("^(.-)%%s(.*)$")
    comment_start = comment_start or pattern
    comment_end = comment_end or ""
    
    local indent = line:match("^(%s*)")
    local rest = line:sub(#indent + 1)
    
    -- Try with original comment_start first (with space)
    if comment_end and comment_end ~= "" then
        local escaped_start = vim.pesc(comment_start)
        local escaped_end = vim.pesc(comment_end)
        local content = rest:match("^" .. escaped_start .. "(.-)" .. escaped_end .. "$")
        if content then
            return indent .. content
        end
    else
        local escaped_start = vim.pesc(comment_start)
        local content = rest:match("^" .. escaped_start .. "(.*)")
        if content then
            return indent .. content
        end
        
        -- If that fails, try with just the prefix (without trailing whitespace)
        local comment_prefix = comment_start:match("^(.-)%s*$")
        if comment_prefix ~= comment_start then
            local escaped_prefix = vim.pesc(comment_prefix)
            content = rest:match("^" .. escaped_prefix .. "(.*)")
            if content then
                return indent .. content
            end
        end
    end
    
    return line
end

function M.toggle_comment(start_line, end_line)
    local pattern = get_comment_pattern()
    local comment_start, comment_end = pattern:match("^(.-)%%s(.*)$")
    comment_start = comment_start or pattern
    comment_end = comment_end or ""
    
    if not start_line then
        start_line = vim.fn.line('.')
        end_line = start_line
    end
    
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    
    local non_empty_lines = {}
    for i, line in ipairs(lines) do
        if not line:match("^%s*$") then
            table.insert(non_empty_lines, {i, line})
        end
    end
    
    if #non_empty_lines == 0 then
        return
    end
    
    local all_commented = true
    for _, line_data in ipairs(non_empty_lines) do
        local line = line_data[2]
        if not is_line_commented(line, comment_start, comment_end) then
            all_commented = false
            break
        end
    end
    
    local new_lines = {}
    for i, line in ipairs(lines) do
        if line:match("^%s*$") then
            new_lines[i] = line
        elseif all_commented then
            new_lines[i] = uncomment_line(line, pattern)
        else
            new_lines[i] = comment_line(line, pattern)
        end
    end
    
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
end

vim.keymap.set('n', '<C-/>', function()
    M.toggle_comment()
end, { desc = 'Toggle comment on current line' })

vim.keymap.set('v', '<C-/>', function()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', false)
    M.toggle_comment(start_line, end_line)
end, { desc = 'Toggle comment on selection' })

vim.keymap.set('n', '<C-_>', function()
    M.toggle_comment()
end, { desc = 'Toggle comment on current line (alternative)' })

vim.keymap.set('v', '<C-_>', function()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', false)
    M.toggle_comment(start_line, end_line)
end, { desc = 'Toggle comment on selection (alternative)' })

vim.keymap.set('n', '<leader>/', function()
    M.toggle_comment()
end, { desc = 'Toggle comment on current line (leader)' })

vim.keymap.set('v', '<leader>/', function()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', false)
    M.toggle_comment(start_line, end_line)
end, { desc = 'Toggle comment on selection (leader)' })

vim.api.nvim_create_user_command('ToggleComment', function()
    M.toggle_comment()
end, { desc = 'Toggle comment on line or selection' })

return M