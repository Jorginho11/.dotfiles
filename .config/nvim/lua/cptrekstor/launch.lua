-- lua/launch_config.lua
local M = {}

local dap = require('dap')
local dap_vscode = require('dap.ext.vscode')

-- Function to get the project root by locating the .git directory or falling back to the current directory
local function get_project_root()
    local cwd = vim.fn.getcwd()
    local root = vim.fn.finddir('.git', cwd .. ';')
    if root == '' then
        return cwd -- Fallback to current directory if no .git directory is found
    else
        return vim.fn.fnamemodify(root, ':h')
    end
end

-- Function to get the path to the launch.json file in the .vscode directory
local function get_launch_json_path()
    return get_project_root() .. '/.vscode/launch.json'
end

local function trim_quotes(value)
    -- Remove surrounding quotes if they exist
    return value:gsub('^"(.*)"$', '%1')
               :gsub("^'(.*)'$", '%1')
end

local function load_env_file(filepath)
    local file = io.open(filepath, "r")
    if not file then
        print("Could not open .env file: " .. filepath)
        return
    end

    for line in file:lines() do
        -- Skip comments and empty lines
        if line:match("^%s*#") == nil and line:match("^%s*$") == nil then
            for key, value in string.gmatch(line, "([%w_]+)=([^\n]+)") do
                -- Trim any surrounding quotes from the value
                value = trim_quotes(value)
                vim.fn.setenv(key, value)
            end
        end
    end

    file:close()
end



-- Function to replace variables like ${workspaceFolder} with actual values
local function replace_variables(value, root)
    if type(value) == "string" then
        value = string.gsub(value, "${workspaceFolder}", root)
    elseif type(value) == "table" then
        for k, v in pairs(value) do
            value[k] = replace_variables(v, root)
        end
    end
    return value
end

function M.load_launch_json()
    local path = get_launch_json_path()
    local root = get_project_root()

    -- Load the .env file before setting up the debug session
    local env_file = root .. "/.env"
    load_env_file(env_file)

    if vim.fn.filereadable(path) == 1 then
        local configs = vim.fn.json_decode(vim.fn.readfile(path))

        if configs.configurations then
            for _, configuration in ipairs(configs.configurations) do
                -- Replace variables in the configuration
                configuration.program = replace_variables(configuration.program, root)
                configuration.envFile = replace_variables(configuration.envFile, root)
                configuration.env = replace_variables(configuration.env, root)

                -- Add the configuration to nvim-dap
                dap.configurations[configuration.type] = dap.configurations[configuration.type] or {}
                table.insert(dap.configurations[configuration.type], configuration)
            end
            print('Loaded configurations from ' .. path)
        else
            print('No configurations found in ' .. path)
        end
    else
        print('No launch.json file found at ' .. path)
    end
end

-- Function to open the launch.json file in a vertical split
function M.open_launch_json()
    local path = get_launch_json_path()
    if vim.fn.filereadable(path) == 1 then
        vim.cmd('vsplit ' .. path)
        print('Opened launch.json from ' .. path)
    else
        print('No launch.json file found at ' .. path)
    end
end

-- Automatically load the launch.json when Neovim starts
--M.load_launch_json()

return M
