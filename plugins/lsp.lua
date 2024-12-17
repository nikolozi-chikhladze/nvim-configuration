require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = { "lua_ls" }
})

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }

			},
			runtime = {
				version = "LuaJIT",
			},
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = 2,
				},
				stylua = {
					enable = true,
					path = vim.fn.expand("~/.local/share/nvim/mason/packages/stylua/bin/stylua")
				},
			},
		},
	},
})
