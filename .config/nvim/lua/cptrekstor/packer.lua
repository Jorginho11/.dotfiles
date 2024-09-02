-- Only required if you have packer configured as `opt`
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })
    use 'ThePrimeagen/vim-be-good'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
    use("nvim-treesitter/nvim-treesitter-context");
    use("nvim-treesitter/playground")
    use"mbbill/undotree"
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    }
    use"tpope/vim-fugitive"
    use"nvim-tree/nvim-tree.lua"
    use"nvim-tree/nvim-web-devicons"
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'jose-elias-alvarez/null-ls.nvim'},
            {'jayp0521/mason-null-ls.nvim'},
            {'jay-babu/mason-nvim-dap.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'WhoIsSethDaniel/mason-tool-installer.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }
  use"ahmedkhalf/project.nvim"
  use("github/copilot.vim")
  use {
      "nvim-neotest/neotest",
      requires = {
          "nvim-neotest/nvim-nio",
          "nvim-lua/plenary.nvim",
          "antoinemadec/FixCursorHold.nvim",
          "nvim-treesitter/nvim-treesitter"
      }
  }
  -- Testing and debugging setup
  use"nvim-neotest/neotest-python"
  use"mfussenegger/nvim-dap"
  use"mfussenegger/nvim-dap-python"
  use"leoluz/nvim-dap-go"
  use"rcarriga/nvim-dap-ui"
  use'theHamsta/nvim-dap-virtual-text'
  use"folke/lazydev.nvim"
  use"nvim-telescope/telescope-dap.nvim"
  -- airline config
  use"vim-airline/vim-airline"
  use"vim-airline/vim-airline-themes"
  -- Golang config
  use "fatih/vim-go"
  -- Ruby config
  use "vim-ruby/vim-ruby"
  if packer_bootstrap then
    require('packer').sync()
  end
end)
