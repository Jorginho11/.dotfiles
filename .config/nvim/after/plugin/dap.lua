-- Load the required plugins
local dap = require('dap')
local dapui = require('dapui')
local dap_vscode = require('dap.ext.vscode')


-- Keybindings
vim.api.nvim_set_keymap('n', '<Leader>ol', '<Cmd>lua require("cptrekstor.launch").open_launch_json()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ll', '<Cmd>lua require("cptrekstor.launch").load_launch_json()<CR>', { noremap = true, silent = true })


-- Call the function to load the launch.json file
-- load_launch_json()

local function get_python_path()
  -- Check for pyenv's python3 and use the active virtualenv if available
  local pyenv_python = vim.fn.system('pyenv which python3'):gsub('%s+', '')
  if vim.fn.executable(pyenv_python) == 1 then
    return pyenv_python
  else
    return 'python3'  -- Fallback to system Python 3
  end
end

dap.adapters.python = {
  type = 'executable',
  command = get_python_path(),
  args = { '-m', 'debugpy.adapter' },
}

-- Load launch.json
--require('dap.ext.vscode').load_launchjs(nil, { python = { 'python' } })

-- nvim-dap-ui configuration
dapui.setup()

-- Open dapui automatically when debugging starts
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- Close dapui automatically when debugging stops
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

vim.api.nvim_set_keymap('n', '<F5>', ':lua require("dap").continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require("dap").step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require("dap").step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require("dap").step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>B', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dr', ':lua require("dap").repl.open()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dl', ':lua require("dap").run_last()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dui', ':lua require("dapui").toggle()<CR>', { noremap = true, silent = true })

--debugging
vim.api.nvim_set_keymap('n', '<Leader>dv', ':lua require("dapui").eval()<CR>', { noremap = true, silent = true })
