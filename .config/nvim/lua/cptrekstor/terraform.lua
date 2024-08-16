vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

vim.cmd([[let g:terraform_fmt_on_save=1]])
vim.cmd([[let g:terraform_align=1]])

-- Define key mappings without `opts` using `vim.keymap.set`
vim.keymap.set('n', '<leader>tfi', ':!terraform init<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tfv', ':!terraform validate<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tfp', ':!terraform plan<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>taa', ':!terraform apply -auto-approve<CR>', { noremap = true, silent = true })

