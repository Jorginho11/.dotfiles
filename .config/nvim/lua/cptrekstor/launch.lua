-- lua/launch_config.lua
local M = {}

local dap = require('dap')
local dap_vscode = require('dap.ext.vscode')

local function get_project_root()
    local cwd = vim.fn.getcwd()
    local root = vim.fn.finddir('.git', cwd .. ';')
    if root == '' then
        return cwd  -- Fallback to current directory if no .git directory is found
    else
        return vim.fn.fnamemodify(root, ':h')
    end
end

local function get_launch_json_path()
    return get_project_root() .. '/.vscode/launch.json'
end

function M.open_launch_json()
    local path = get_launch_json_path()
    if vim.fn.filereadable(path) == 1 then
        vim.cmd('vsplit ' .. path)
        print('Opened launch.json from ' .. path)
    else
        print('No launch.json file found at ' .. path)
    end
end

function M.load_launch_json()
    local path = get_launch_json_path()
    if vim.fn.filereadable(path) == 1 then
        dap_vscode.load_launchjs(path)
        print('Loaded configurations from ' .. path)
    else
        print('No launch.json file found at ' .. path)
    end
end

return M

