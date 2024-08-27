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

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        {
            {
                'nvim-telescope/telescope.nvim',
                branch = '0.1.x',
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
                        ensure_installed = { "javascript", "typescript", "tsx", "json", "c", "lua", "vim", "vimdoc", "query" },
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
            { 'mbbill/undotree' },
            { 'tpope/vim-fugitive' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/nvim-cmp' },
            { 'L3MON4D3/LuaSnip' },
            { 'lewis6991/gitsigns.nvim', config = function()
                require('gitsigns').setup({
                    signs = {
                        add          = { text = '┃' },
                        change       = { text = '┃' },
                        delete       = { text = '_' },
                        topdelete    = { text = '‾' },
                        changedelete = { text = '~' },
                        untracked    = { text = '┆' },
                    },
                    signs_staged = {
                        add          = { text = '┃' },
                        change       = { text = '┃' },
                        delete       = { text = '_' },
                        topdelete    = { text = '‾' },
                        changedelete = { text = '~' },
                        untracked    = { text = '┆' },
                    },
                    signs_staged_enable = true,
                    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
                    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
                    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
                    watch_gitdir = {
                        follow_files = true
                    },
                    auto_attach = true,
                    attach_to_untracked = false,
                    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                    current_line_blame_opts = {
                        virt_text = true,
                        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                        delay = 1000,
                        ignore_whitespace = false,
                        virt_text_priority = 100,
                    },
                    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
                    sign_priority = 6,
                    update_debounce = 100,
                    status_formatter = nil, -- Use default
                    max_file_length = 40000, -- Disable if file is longer than this (in lines)
                    preview_config = {
                        -- Options passed to nvim_open_win
                        border = 'single',
                        style = 'minimal',
                        relative = 'cursor',
                        row = 0,
                        col = 1
                    },
                    on_attach = function(bufnr)
                        local gitsigns = require('gitsigns')

                        local function map(mode, l, r, opts)
                            opts = opts or {}
                            opts.buffer = bufnr
                            vim.keymap.set(mode, l, r, opts)
                        end

                        -- Navigation
                        map('n', ']c', function()
                            if vim.wo.diff then
                                vim.cmd.normal({']c', bang = true})
                            else
                                gitsigns.nav_hunk('next')
                            end
                        end)

                        map('n', '[c', function()
                            if vim.wo.diff then
                                vim.cmd.normal({'[c', bang = true})
                            else
                                gitsigns.nav_hunk('prev')
                            end
                        end)

                        -- Actions
                        map('n', '<leader>hs', gitsigns.stage_hunk)
                        map('n', '<leader>hr', gitsigns.reset_hunk)
                        map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                        map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                        map('n', '<leader>hS', gitsigns.stage_buffer)
                        map('n', '<leader>hu', gitsigns.undo_stage_hunk)
                        map('n', '<leader>hR', gitsigns.reset_buffer)
                        map('n', '<leader>hp', gitsigns.preview_hunk)
                        map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
                        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                        map('n', '<leader>hd', gitsigns.diffthis)
                        map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
                        map('n', '<leader>td', gitsigns.toggle_deleted)

                        -- Text object
                        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                    end

                })

            end},
            --{'mhartington/formatter.nvim'},
            --{'jose-elias-alvarez/null-ls.nvim', dependencies = { 'nvim-lua/plenary.nvim' }},
            --{'jay-babu/mason-null-ls', dependencies = { 'jose-elias-alvarez/null-ls.nvim', 'williamboman/mason-lspconfig.nvim' }},
            {
                'mhartington/formatter.nvim',
                config = function()
                    local formatter_prettier = { require('formatter.defaults.prettier') }
                    require("formatter").setup({
                        filetype = {
                            javascript      = formatter_prettier,
                            javascriptreact = formatter_prettier,
                            typescript      = formatter_prettier,
                            typescriptreact = formatter_prettier,
                            json            = formatter_prettier,
                        }
                    })
                    -- automatically format buffer before writing to disk:
                    vim.api.nvim_create_augroup('BufWritePreFormatter', {})
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        command = 'FormatWrite',
                        group = 'BufWritePreFormatter',
                        pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
                    })
                end,
                ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json' },
            },
            --{
            --    "pmizio/typescript-tools.nvim",
            --    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
            --    opts = {},
            --}
        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "rose-pine" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
