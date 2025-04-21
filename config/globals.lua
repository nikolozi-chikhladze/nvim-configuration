vim.g.mapleader = " "

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "~/.config/nvim/*",
  callback = function()
    vim.cmd("cd ~/.config/nvim")
  end,
})
