vim.g.mapleader = " "

local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Telescope
local status, telescope = pcall(require, "telescope.builtin")
if status then
    map("n", "<leader>ff", telescope.find_files)
    map("n", "<leader>fg", telescope.live_grep)
    map("n", "<leader>fb", telescope.buffers)
    map("n", "<leader>fh", telescope.help_tags)
    map("n", "<leader>fs", telescope.git_status)
    map("n", "<leader>fc", telescope.git_commits)
    --map("n", "<leader>hh", telescope.file_history)
    vim.api.nvim_set_keymap('n', '<leader>FG',
        [[:lua vim.cmd("Telescope live_grep default_text=" .. vim.fn.expand("<cword>"))<CR>]],
        { noremap = true, silent = true })

    vim.api.nvim_set_keymap('n', '<leader>FF',
        [[:lua vim.cmd("Telescope find_files default_text=" .. vim.fn.expand("<cword>"), {insert = false})<CR>]],
        { noremap = true, silent = true })
else
    print("Telescope not found")
end

-- Buffer
map("n", "<TAB>", "<CMD>bnext<CR>")
map("n", "<S-TAB>", "<CMD>bprevious<CR>")

-- Terminal
map("n", "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>")
map("n", "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<leader>pv", "<CMD>Oil<CR>")

--map("n", "<C-d>", "<C-d>zz")
--map("n", "<C-u>", "<C-u>zz")
--vim.opt.scrolloff = 8 -- or any value larger than 0
