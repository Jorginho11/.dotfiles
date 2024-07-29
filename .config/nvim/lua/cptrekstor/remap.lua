vim.g.mapleader = " "
-- Set the leader key to space

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- <leader>pv: Opens the file explorer (Ex command)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- In visual mode, move the selected lines down and reselect them
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- In visual mode, move the selected lines up and reselect them

vim.keymap.set("n", "J", "mzJ`z")
-- Join the next line to the current line, keeping the cursor in place
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Scroll down half a page and center the cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Scroll up half a page and center the cursor
vim.keymap.set("n", "n", "nzzzv")
-- Move to the next search result and center the cursor
vim.keymap.set("n", "N", "Nzzzv")
-- Move to the previous search result and center the cursor

vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")
-- <leader>zig: Restart the LSP server

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
-- <leader>vwm: Start Vim With Me (collaborative editing)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)
-- <leader>svwm: Stop Vim With Me

vim.keymap.set("x", "<leader>p", [["_dP]])
-- In visual mode, paste over selection without affecting the unnamed register

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- <leader>y: Yank to system clipboard in normal and visual modes
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- <leader>Y: Yank the current line to system clipboard

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
-- <leader>d: Delete without affecting the unnamed register in normal and visual modes

vim.keymap.set("i", "<C-c>", "<Esc>")
-- <C-c>: Map Ctrl+C to Esc in insert mode

vim.keymap.set("n", "Q", "<nop>")
-- Disable the Q command in normal mode

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- <C-f>: Open a new tmux window with tmux-sessionizer

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- <leader>f: Format the current buffer using LSP

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- <C-k>: Move to the next item in the quickfix list and center the cursor
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- <C-j>: Move to the previous item in the quickfix list and center the cursor
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- <leader>k: Move to the next item in the location list and center the cursor
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- <leader>j: Move to the previous item in the location list and center the cursor

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- <leader>s: Replace the word under the cursor in the whole file (case-insensitive)

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- <leader>x: Make the current file executable

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")
-- <leader>ee: Insert a Go error handling snippet

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>")
-- <leader>vpp: Open the Neovim packer configuration file

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")
-- <leader>mr: Execute the CellularAutomaton make_it_rain command

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
-- <leader><leader>: Source the current Neovim configuration file

