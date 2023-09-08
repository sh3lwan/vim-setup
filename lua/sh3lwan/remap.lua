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
else
    print("Telescope not found")
end

-- Buffer
map("n", "<TAB>", "<CMD>bnext<CR>")
map("n", "<S-TAB>", "<CMD>bprevious<CR>")

-- Terminal
map("n", "<leader>tt", "<CMD>ToggleTerm size=10<CR>")
map("n", "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>")
map("n", "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>")


vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
