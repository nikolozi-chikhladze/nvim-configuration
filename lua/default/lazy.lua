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

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        {
            {
                'nvim-telescope/telescope.nvim', branch = '0.1.x',
                dependencies = { 'nvim-lua/plenary.nvim' }
            },
            { 
                "rose-pine/neovim", 
                name = "rose-pine" 
            },
            {
                'nvim-treesitter/nvim-treesitter',
                --commit = 'fe5c581',
                tag = 'v0.9.2',
                build = ':TSUpdate',
                config = function()
                    local configs = require('nvim-treesitter.configs')

                    configs.setup({
                        ensure_installed = {"javascript", "typescript", "tsx", "json", "c", "lua", "vim", "vimdoc", "query" },
                        sync_install = false,
                        auto_install = true,
                        highlight = { enable = true },
                        indent = { enable = true },
                    })
                end
            },
            {
                'ThePrimeagen/harpoon',
                dependencies = { 'nvim-lua/plenary.nvim' }
            },
            {'mbbill/undotree'},
            {'tpope/vim-fugitive'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
            {'neovim/nvim-lspconfig'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/nvim-cmp'},
            {'L3MON4D3/LuaSnip'},
            --{'mhartington/formatter.nvim'},
            {'jose-elias-alvarez/null-ls.nvim', dependencies = { 'nvim-lua/plenary.nvim' }},
            --{'jay-babu/mason-null-ls', dependencies = { 'jose-elias-alvarez/null-ls.nvim', 'williamboman/mason-lspconfig.nvim' }},
        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "rose-pine" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
