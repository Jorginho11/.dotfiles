local builtin = require('telescope.builtin')

-- Function to get the root directory of the project
local function get_project_root()
    local cwd = vim.fn.getcwd()
    local root = vim.fn.finddir('.git', cwd .. ';')
    if root == '' then
        return cwd  -- Fallback to current directory if no .git directory is found
    else
        return vim.fn.fnamemodify(root, ':h')
    end
end


vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({
        search = vim.fn.input("Grep > "),
        cwd = get_project_root(),  -- Use the root directory for the search
    })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
