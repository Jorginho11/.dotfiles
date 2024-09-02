require('mason-tool-installer').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start
  ensure_installed = {
	  --bash
	  'bashls',
	  -- python
	  'pyright',
	  'pylint',
	  'black',
	  'debugpy',
      -- ansible
      'ansiblels',
      'ansible-lint',
      -- yaml
      'yamllint',
      --hcl
      --'tflint',
      --'terraform',
      --'packer',
      --'terraform_lsp',
      --json
      'jsonls',
      'prettier',
      'jsonlint',
	  -- go
      'gopls',
      --'gofmt',
      'golangci-lint',
	  'delve',
	  -- lua
	  'lua-language-server',
	  -- ruby
	  'solargraph',
      'rubocop'
  },
  auto_update=false,
}

