function LastGitEditor()
    local line_number = vim.fn.line('.')

    -- Get the full path of the current file
    local file_path = vim.fn.expand('%:p')

    -- Check if the file exists in the Git repository
    local git_ls_files_command = string.format('git ls-files --error-unmatch %s', file_path)
    local file_exists = vim.fn.system(git_ls_files_command)

    -- If the file does not exist, return an empty string
    if string.find(file_exists, 'error') then
        return ''
    end

    -- If the file exists, proceed with the Git blame command
    local git_blame_command = string.format('git blame -L %d,%d -p %s', line_number, line_number, file_path)
    local git_blame_output = vim.fn.system(git_blame_command)

    -- Parse the Git blame output to extract the information you need
    -- For example, you can use string.match or other string manipulation functions
    -- to extract the relevant information from git_blame_output.

    return git_blame_output
end

print(LastGitEditor());
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
    lualine_d = {'{luaeval("git_blame()")}'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
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
