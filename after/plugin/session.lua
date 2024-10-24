local function refreshBuffer()
    -- Refresh the current file with :e!
    vim.defer_fn(function()
        local status, err = pcall(function() vim.cmd('e!') end)

        if err or not status then
            -- Get the current working directory
            local cwd = vim.loop.cwd()

            status, _ = pcall(require, 'oil')

            if not status then
                print("Failed to load 'oil'. Please ensure it is installed.")
                return
            end

            require('oil').open(cwd)
        end
    end, 50)
end

-- Function to load a project-specific session
function load_project_session()
    -- Get the current project directory
    local current_directory = vim.fn.getcwd()

    -- Split the current directory path into parts based on the directory separator ("/" or "\")
    local parts = vim.fn.split(current_directory, '/')

    if #parts < 2 then
        print("Path is too short, cannot construct session name.")
        return
    end

    -- Get the last two parts of the directory
    local last_two_parts = parts[#parts - 1] .. '-' .. parts[#parts] .. '-session'

    -- If a project directory is found, construct the session file path
    if last_two_parts ~= '' then

        local sessions_directory = vim.fn.stdpath('config') .. '/.sessions/'

        -- if sessions directory is not found -> create
        if vim.fn.isdirectory(sessions_directory) == 0 then
            vim.fn.mkdir(sessions_directory, "p")
        end

        local session_file = sessions_directory .. last_two_parts .. '.vim'

        -- Check if the session file exists and load it
        if vim.fn.filereadable(session_file) == 1 then
            local status, err = pcall(function()
                vim.cmd('source ' .. session_file)
                refreshBuffer()
            end)

            if not status then
                print("Error loading session: " .. err)
            end
        else
            print("No Session Found.")
        end
    end
end

-- Function to save a project-specific session
function save_project_session()
    -- Get the current project directory
    local current_directory = vim.fn.getcwd()

    -- Split the current directory path into parts based on the directory separator ("/" or "\")
    local parts = vim.fn.split(current_directory, '/')

    -- Get the last two parts of the directory
    local last_two_parts = parts[#parts - 1] .. '-' .. parts[#parts] .. '-session'

    if last_two_parts ~= '' then
        local sessions_directory = vim.fn.stdpath('config') .. '/.sessions/'
        local session_file = sessions_directory .. last_two_parts .. '.vim'
        -- Save the session to ~/.config/nvim/.sessions/{session}.vim
        vim.cmd('mksession! ' .. session_file)
    else
        print("Project not detected. Session not saved.")
    end
end

--Automatically load the project-specific session on startup
vim.cmd([[
    autocmd VimEnter * lua load_project_session()
]])

-- Automatically save the project-specific session when quitting Neovim
vim.cmd([[
  autocmd VimLeave * lua save_project_session()
]])
