
vim.scriptencoding = 'utf-8'
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

require 'core.plugins'
require 'plugins.lsp'
require 'plugins.mason'
require 'plugins.treesitter'
require 'plugins.telescope'
require 'plugins.nvim-tree'

require 'core.options'
require 'core.themes'
require 'core.terminal'
require 'core.keymaps'

