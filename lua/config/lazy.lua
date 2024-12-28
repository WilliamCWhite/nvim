-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import plugins here 
    --{ 
      --"folke/tokyonight.nvim",
      --lazy = false,
      --priority = 1000,
      --config = function()
        --vim.cmd([[colorscheme tokyonight]])
      --end,
    --},
    {
      "navarasu/onedark.nvim",
      lazy = false,
      priority = 1000,
      config = function()
				require("onedark").setup(
					{
						style = 'deep',
	  			}
				)
				require("onedark").load()
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        local configs = require("nvim-treesitter.configs")

				configs.setup({
	  			ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
	  			sync_install = false,
	  			highlight = { enable = true },
	  			indent = { enable = true },
				})
      end,
    },
		{
			"williamboman/mason.nvim",
			lazy = false,
			priority = 103, --afraid of lazy loading, since LSP must happen in specific order
			config = function()
				require("mason").setup()
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			lazy = false,
			priority = 102,
			config = function()
				require("mason-lspconfig").setup({
					ensure_installed = { "lua_ls" },
				})
			end,
		},
		{
			"neovim/nvim-lspconfig",
			lazy = false,
			priority = 101,
			config = function()
				require("lspconfig").lua_ls.setup {}
			end,
		},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})