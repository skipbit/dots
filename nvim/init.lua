
require 'plugins'

-- GENERIC
vim.o.fileformats = 'unix', 'mac', 'dos'
vim.o.fileencoding = 'utf-8'
vim.o.backup = false
vim.o.swapfile = false
vim.o.helplang = 'ja', 'en'

-- VIEWING
vim.o.number = true
vim.o.ruler = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.laststatus = 2

vim.o.showcmd = true
vim.o.showmatch = true
vim.o.wildmenu = true

-- EDITING
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.smartindent = true

-- SEARCHING
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.wrapscan = true

