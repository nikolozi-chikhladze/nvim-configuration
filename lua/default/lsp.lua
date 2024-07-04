local lsp_zero = require('lsp-zero')

local on_attach = (function(_, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    --vim.keymap.set("n", "<leader>vsh", function() vim.lsp.buf.signature_help() end, opts)

    lsp_zero.default_keymaps(opts)
end)

lsp_zero.on_attach(on_attach)

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here 
    -- with the ones you want to install
    ensure_installed = {'tsserver'},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        tsserver = function()
            require('lspconfig').tsserver.setup({
                on_attach = on_attach,
                filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
                cmd = { "typescript-language-server", "--stdio" }
            })
        end,
    },
})
