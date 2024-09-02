require("neotest").setup({

adapters = {
    require("neotest-python")({
        -- Extra arguments for nvim-dap configuration
        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
        dap = { justMyCode = true } ,
        -- Command line arguments for runner
        -- Can also be a function to return dynamic values
        args = {"--log-level", "DEBUG"},
        -- Runner to use. Will use pytest if available by default.
        -- Can be a function to return dynamic value.
        runner = "pytest",
        -- Custom python path for the runner.
        -- Can be a string or a list of strings.
        -- Can also be a function to return dynamic value.
        -- If not provided, the path will be inferred by checking for 
        -- virtual envs in the local directory and for Pipenev/Poetry configs
        python = vim.fn.system('pyenv which python3'):gsub('%s+', ''),
        -- Returns if a given file path is a test file.
        -- NB: This function is called a lot so don't perform any heavy tasks within it.
        --is_test_file = function(file_path)
        --  ...
        --end,
        -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
        -- instances for files containing a parametrize mark (default: false)
        pytest_discover_instances = true,
    })
  }
})

-- Set up key mappings
vim.api.nvim_set_keymap('n', '<leader>tt', ':lua require("neotest").run.run()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ta', ':lua require("neotest").run.run_all()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>td', ':lua require("neotest").run.run({strategy = "dap"})<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>to', ':lua require("neotest").output.open({ enter = true })<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tp', ':lua require("neotest").summary.toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tq', ':lua require("neotest").output_panel.toggle()<CR>', { noremap = true, silent = true })

