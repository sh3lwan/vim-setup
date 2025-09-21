local status, neotest = pcall(require, 'neotest')
require("neotest").setup({
    adapters = {
        require('neotest-pest'),
    },
    quickfix = {
        enabled = false, -- if you want to use neotest's own output window instead of quickfix
    },
    output = {
        enabled = true,
        open_on_run = true, -- <-- auto open output window on test run or failure
    },
    summary = {
        open = "botright vsplit", -- open summary in a vertical split at the bottom right
    },
})

vim.keymap.set('n', '<leader>tt', function()
  require('neotest').run.run()
  vim.defer_fn(function()
    require('neotest').output.open({ enter = true })
  end, 100) -- 100ms delay to let the test finish and output generate
end)
--vim.keymap.set('n', '<leader>tt', function() require('neotest').run.run() end)
vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end)
vim.keymap.set('n', '<leader>ta', function() require('neotest').run.run({ suite = true }) end)
vim.keymap.set('n', '<leader>to', function()
    require('neotest').output.open({ enter = true })
end)
--if status then
--    neotest.setup({
--        adapters = {
--            require('neotest-pest'),
--            require('neotest-phpunit'),
--            require("neotest-go"),
--        }
--    })
--    vim.keymap.set('n', '<leader>tt', function() require('neotest').run.run() end)
--    vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end)
--    vim.keymap.set('n', '<leader>ta', function() require('neotest').run.run({ suite = true }) end)
--end
