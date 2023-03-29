
vim.scriptencoding = 'utf-8'
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

require 'core.plugins'
require 'plugins.lsp'
require 'plugins.dap'
require 'plugins.mason'
require 'plugins.completion'
require 'plugins.treesitter'
require 'plugins.telescope'
require 'plugins.nvim-tree'
require 'plugins.lualine'

require 'core.options'
require 'core.themes'
require 'core.terminal'
require 'core.keymaps'

