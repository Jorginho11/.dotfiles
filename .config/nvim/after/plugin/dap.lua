-- Load the required plugins
local dap = require('dap')
local dapui = require('dapui')
local opts = { noremap = true, silent = true }


-- Keybindings
vim.api.nvim_set_keymap('n', '<Leader>ol', '<Cmd>lua require("cptrekstor.launch").open_launch_json()<CR>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ll', '<Cmd>lua require("cptrekstor.launch").load_launch_json()<CR>',
    { noremap = true, silent = true })

-- Golang setup
require('dap-go').setup()
dap.adapters.go = function(callback, config)
    local handle
    local pid_or_err
    local port = 38697
    handle, pid_or_err = vim.loop.spawn('dlv', {
      args = { 'dap', '-l', '127.0.0.1:' .. port },
      detached = true
    }, function(code)
      handle:close()
      print('Delve exited with exit code: ' .. code)
    end)
    -- Wait 100ms for delve to start
    vim.defer_fn(function()
      -- Tell nvim-dap the connection information
      callback({ type = 'server', host = '127.0.0.1', port = port })
    end, 100)
end

-- dapi configuration
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

-- dap.listeners.before.event_terminated["dapui_config"] = function()
--     dapui.close()
-- end
--
-- dap.listeners.before.event_exited["dapui_config"] = function()
--     dapui.close()
-- end

dap.listeners.after.event_stopped["dapui_config"] = function()
    dapui.open()
end

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

vim.api.nvim_set_keymap('n', '<F5>', ':lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require("dap").step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require("dap").step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':lua require("dap").toggle_breakpoint()<CR>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>B',
    ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>lp',
    ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dr', ':lua require("dap").repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', ':lua require("dap").run_last()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dui', ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })

--debugging
vim.api.nvim_set_keymap('n', '<Leader>dv', ':lua require("dapui").eval()<CR>', { noremap = true, silent = true })
