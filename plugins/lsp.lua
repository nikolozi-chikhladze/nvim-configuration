local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local ts_utils = require("nvim-lsp-ts-utils")
local cmp = require("cmp")

-- Mason setup
mason.setup()
mason_lspconfig.setup({
    ensure_installed = { "lua_ls", "ts_ls", "html", "cssls", "eslint", "prismals" },
})

-- Shared on_attach
local function on_attach(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
end

-- Capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- LSP Configurations
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            runtime = { version = "LuaJIT" },
            format = { enable = true },
        },
    },
})

lspconfig.ts_ls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        ts_utils.setup({ enable_import_on_completion = true })
        ts_utils.setup_client(client)
    end,
})

lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach })

lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach })

lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client)
    end,
})

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint,
    },
    on_attach = on_attach,
})

-- nvim-cmp Setup
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    }),
})
