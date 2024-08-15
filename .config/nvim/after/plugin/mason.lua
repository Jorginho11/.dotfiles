require('mason-tool-installer').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start
  ensure_installed = {
	  --bash
	  'bash-language-server',
	  -- python
	  'pyright',
	  'pylint',
	  'black',
	  'debugpy',
	  -- go
	  'delve',
	  -- lua
	  'lua-language-server'
	  -- ruby
	  'solargraph'
  },
  auto_update=false,
}
