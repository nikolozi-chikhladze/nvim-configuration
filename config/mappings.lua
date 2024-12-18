local set_keymap = vim.api.nvim_set_keymap

-- show explorer
set_keymap('n', '<Leader>ee', ':Explore<CR>', { noremap = true, silent = true })

-- format file
set_keymap('n', '<Leader>f', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

-- turn off search highlighting
set_keymap('n', '<Leader>nh', ':nohlsearch<CR>', { noremap = true, silent = true })

-- lsp commands
set_keymap('n', '<Leader>d', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>t', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>r', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>dc', '<Cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })

-- Move selected lines up
set_keymap('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Move selected lines down
set_keymap('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Map Ctrl+C to Esc in normal, insert, and visual modes
set_keymap('n', '<C-c>', '<Esc>', { noremap = true, silent = true })
set_keymap('i', '<C-c>', '<Esc>', { noremap = true, silent = true })
set_keymap('v', '<C-c>', '<Esc>', { noremap = true, silent = true })

-- Git fugitive keymaps
set_keymap('n', '<Leader>gv', ':G<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>gl', ':GcLog<CR>', { noremap = true, silent = true })
set_keymap('n', '<Leader>gca', ':Git commit --amend<CR>', { noremap = true, silent = true })

