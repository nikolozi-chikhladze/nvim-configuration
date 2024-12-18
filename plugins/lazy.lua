-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	{
		"rose-pine/neovim",
		name = "rose-pine"
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build =
				'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
			}
		}
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup {
				highlight = {
					enable = true,
				},
				ensure_installed = {
					"vimdoc",
					"luadoc",
					"vim",
					"lua",
					"markdown",
					"javascript",
					"typescript",
					"html",
					"css",
					"scss"
				}
			}
		end,
	},
	{ "jose-elias-alvarez/null-ls.nvim" },
	{ "lewis6991/gitsigns.nvim" },
	{ "tpope/vim-fugitive" },
	{ "folke/which-key.nvim" },
})
