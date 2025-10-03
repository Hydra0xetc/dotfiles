vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use ({
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  })

  use ({
	  'rose-pine/neovim', as, 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
})
  use ({"folke/tokyonight.nvim", as, "tokyonight",
    config = function ()
        vim.cmd("colorscheme tokyonight")
    end
  })
  use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  -- LSP Config
  use 'neovim/nvim-lspconfig'
  
  -- Completion engine
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- Snippet engine
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- UI improvements
  use 'onsails/lspkind.nvim'
  use { 'akinsho/bufferline.nvim'}
end)
