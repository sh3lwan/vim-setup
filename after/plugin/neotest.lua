local status, neotest = pcall(require, 'neotest')

if status then
    require("neotest").setup({
        adapters = {
            require('neotest-pest')
        }
    })
    vim.keymap.set('n', '<leader>tt', function() require('neotest').run.run() end)
    vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end)
    vim.keymap.set('n', '<leader>ta', function() require('neotest').run.run({ suite = true }) end)
end
