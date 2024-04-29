
vim.scriptencoding = 'utf-8'
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'
vim.g.editorconfig = true

local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazy_path
    }
end
vim.opt.rtp:prepend(lazy_path)

local lazy_options = {
    ui = {
        border = 'rounded',
    },
}

require('lazy').setup("plugins", lazy_options)
require('options')

