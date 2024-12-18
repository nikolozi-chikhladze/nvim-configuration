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
		},
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
		null_ls.builtins.formatting.beautysh.with({
			extra_args = { "--indent", "2" }, -- Example to set indentation level
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

local cmp = require('cmp')
cmp.setup({
	snippet = {
		expand = function(args)
			require 'luasnip'.lsp_expand(args.body) -- Snippet expansion (optional)
		end,
	},
	mapping = {
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'path' },
	}),
})
