
local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true })
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

map("n", "<leader>cp", function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
  print('📋 File path copied to clipboard!')
end)

--vim.keymap.set('n', '<leader>cp', function()
--  vim.fn.setreg('+', vim.fn.expand('%:p'))
--  print('📋 File path copied to clipboard!')
--end, { desc = 'Copy file path to clipboard' })

--vim.keymap.set('n', '<leader>cp', function()
--  vim.fn.setreg('+', vim.fn.expand('%:p'))
--  print('📋 File path copied to clipboard!')
--end, { desc = 'Copy file path to clipboard' })
--map("n", "<C-d>", "<C-d>zz")
--map("n", "<C-u>", "<C-u>zz")
--vim.opt.scrolloff = 8 -- or any value larger than 0
