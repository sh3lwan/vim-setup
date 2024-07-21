local status, neotest = pcall(require, 'neotest')

if status then
    neotest.setup({
        adapters = {
            require('neotest-pest'),
            require('neotest-phpunit'),
        }
    })
    vim.keymap.set('n', '<leader>rr', function() require('neotest').run.run() end)
    vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end)
    vim.keymap.set('n', '<leader>ta', function() require('neotest').run.run({ suite = true }) end)
end
