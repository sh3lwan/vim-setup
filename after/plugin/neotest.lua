local status, _ = pcall(require, 'neotest')

if status then
    require("neotest").setup({
        adapter = {
            require('neotest-pest')({
                ignore_dirs = { "vendor", "node_modules" },
                root_ignore_files = { "phpunit-only.tests" },
                test_file_suffixes = { "Test.php", "_test.php", "PestTest.php" },
                sail_enabled = function() return false end,
                sail_executable = "vendor/bin/sail",
                sail_project_path = "/var/www/html",
                pest_cmd = "vendor/bin/pest",
                parallel = 16,
                compact = false,
            }),

        },
    })

    vim.keymap.set('n', '<leader>tt', function() require('neotest').run.run() end)
    vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end)
    vim.keymap.set('n', '<leader>ta', function() require('neotest').run.run({ suite = true }) end)
end
