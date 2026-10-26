vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.termguicolors = true
vim.cmd.colorscheme('desert')
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
