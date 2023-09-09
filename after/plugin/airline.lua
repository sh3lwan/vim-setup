local function humanize_time(seconds)
    local minute = 60
    local hour = 60 * minute
    local day = 24 * hour
    local week = 7 * day
    local month = 30.44 * day
    local year = 365.25 * day

    if seconds < minute then
        return seconds .. "s"
    elseif seconds < hour then
        return math.floor(seconds / minute) .. "m"
    elseif seconds < day then
        return math.floor(seconds / hour) .. "h"
    elseif seconds < week then
        return math.floor(seconds / day) .. "d"
    elseif seconds < month then
        return math.floor(seconds / week) .. "w"
    elseif seconds < year then
        return math.floor(seconds / month) .. "mo"
    else
        return math.floor(seconds / year) .. "y"
    end
end

local function LastGitEditor()
    local line_number = vim.fn.line('.')

    -- Get the full path of the current file
    local file_path = vim.fn.expand('%:p')

    -- If the file exists, proceed with the Git blame command
    local git_blame_command = string.format('git blame -L %d,%d -p %s', line_number, line_number, file_path)
    local git_blame_output = vim.fn.system(git_blame_command)

    if string.find(git_blame_output, 'fatal: no such path') then
        return ''
    end

    -- Parse the Git blame output to extract the author's name from the most recent commit
    local recent_author = nil
    local time_ago = nil
    for line in string.gmatch(git_blame_output, "[^\r\n]+") do
        local author = string.match(line, '^author (.+)$')
        local timestamp = string.match(line, '^author%-time (%d+)')

        if author and author ~= 'Not Committed Yet' then
            recent_author = author
        end

        if timestamp then
            local time_numeric = os.time() - tonumber(timestamp)
            time_ago = string.format('(%s ago)', humanize_time(time_numeric))
        end
    end

    if recent_author and time_ago then
        return recent_author .. ' ' .. time_ago
    else
        return 'Not Committed Yet'
    end
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},

        lualine_x = {LastGitEditor},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
