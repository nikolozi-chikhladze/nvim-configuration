require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = { "lua_ls" }
})

local lspconfig = require('lspconfig')

-- lua setup
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
		html = {
			format = {
				enable = false
			},
			prettier = {
				enable = true,
				path = vim.fn.expand("~/.local/share/nvim/mason/packages/prettier/bin/prettier")
			}
		},
		css = {
			format = {
				enable = false
			},
			prettier = {
				enable = true,
				path = vim.fn.expand("~/.local/share/nvim/mason/packages/prettier/bin/prettier")
			}
		}
	},
})

-- javascript/typescript setup
lspconfig.ts_ls.setup({
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "jsx", "tsx" },
})

-- html setup
lspconfig.html.setup({
	filetypes = { "html" },
})

-- null-ls setup for Prettier formatting
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json", "html", "css", "scss", "markdown" }, -- Add other filetypes if needed
		}),
	},
})

-- eslint setup
lspconfig.eslint.setup({
	on_attach = function(client, bufnr)
		-- Disable eslint formatting because we are using Prettier with null-ls
		if client.server_capabilities.documentFormattingProvider then
			client.server_capabilities.documentFormattingProvider = false
		end
	end,
})
