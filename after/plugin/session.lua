-- Helper to refresh the current buffer (and re-trigger highlighting/colors)
local function refreshBuffer()
    vim.defer_fn(function()
        local bufname = vim.api.nvim_buf_get_name(0)

        if bufname ~= '' and vim.bo.modifiable and vim.fn.filereadable(bufname) == 1 then
            -- Safe refresh: recheck file and force redraw
            vim.cmd('checktime')
            vim.cmd('silent! edit!')
        end
    end, 50)
end

-- Helper to build a session filename from the last 2 directory parts
local function get_session_filename()
    local parts = vim.fn.split(vim.fn.getcwd(), '/')
    if #parts < 2 then return nil end
    return parts[#parts - 1] .. '-' .. parts[#parts] .. '-session'
end

-- Load a project-specific session
function load_project_session()
    local session_name = get_session_filename()
    if not session_name then
        print("Path is too short, cannot construct session name.")
        return
    end

    local sessions_directory = vim.fn.stdpath('config') .. '/.sessions/'

    if vim.fn.isdirectory(sessions_directory) == 0 then
        vim.fn.mkdir(sessions_directory, "p")
    end

    local session_file = sessions_directory .. session_name .. '.nvim'

    if vim.fn.filereadable(session_file) == 1 then
        local ok, err = pcall(function()
            vim.cmd('source ' .. vim.fn.fnameescape(session_file))
            refreshBuffer()
        end)
        if not ok then
            print("Error loading session: " .. err)
        end
    else
        print("No Session Found.")
    end
end

-- Save a project-specific session
function save_project_session()
    local session_name = get_session_filename()
    if not session_name then
        print("Project not detected. Session not saved.")
        return
    end

    local sessions_directory = vim.fn.stdpath('config') .. '/.sessions/'

    if vim.fn.isdirectory(sessions_directory) == 0 then
        vim.fn.mkdir(sessions_directory, "p")
    end

    local session_file = sessions_directory .. session_name .. '.nvim'
    vim.cmd('mksession! ' .. vim.fn.fnameescape(session_file))
end

-- Auto-load session only if no files were passed (e.g. plain `nvim`)
vim.cmd([[
  autocmd VimEnter * lua if vim.fn.argc() == 0 then load_project_session() end
]])

-- Auto-save the session on exit
vim.cmd([[
  autocmd VimLeave * lua save_project_session()
]])

