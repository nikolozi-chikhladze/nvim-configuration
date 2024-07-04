-- explorer
vim.keymap.set("n", "<leader>ee", vim.cmd.Ex)

-- moving lines
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste without losing buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy in your system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete without saving to the buffer
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- esc shortcut
vim.keymap.set("i", "<C-c>", "<Esc>")

-- avoid force exit
vim.keymap.set("n", "Q", "<nop>")

-- navigating
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace current text in whole file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
