local set_keymap = vim.api.nvim_set_keymap

-- show explorer
set_keymap('n', '<Leader>ee', ':Explore<CR>', { noremap = true, silent = true })

-- format file
set_keymap('n', '<Leader>f', ':lua vim.lsp.buf.format()<CR>', { noremap = false, silent = true })

-- turn off search highlighting
set_keymap('n', '<Leader>nh', ':nohlsearch<CR>', { noremap = true, silent = true })


