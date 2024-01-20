-- This file contains the immportant parts of my vimrc, converted to Lua

-- line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- search options (ignore case)
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- smart window movement
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- indent options
vim.opt.smartindent = true
vim.opt.autoindent = true

-- CUSTOM COMMANDS
-- TODO: uptdate to use lua instead of vimscript
vim.api.nvim_exec("command Rswdg %s/\'/\"/g", false)
vim.api.nvim_exec("command Rswdl s/\'/\"/g", false)
