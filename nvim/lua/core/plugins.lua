
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazy_path
    }
end
vim.opt.rtp:prepend(lazy_path)

return require('lazy').setup({
    -- general
    'vim-jp/vimdoc-ja',
    'vim-jp/cpp-vim',
    'editorconfig/editorconfig-vim',

    --[[ backends ]]--
    {
        -- lsp
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                { 'williamboman/mason.nvim' },
                { 'williamboman/mason-lspconfig.nvim' },
                { 'j-hui/fidget.nvim' },
                { 'folke/neodev.nvim' },
            },
        },
        -- auto completion
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path'
            }
        },
        -- syntax highlight
        {
            'nvim-treesitter/nvim-treesitter',
            dependencies = {
                { 'nvim-treesitter/nvim-treesitter-textobjects' },
            },
            config = function()
                pcall(require('nvim-treesitter.install').update { with_sync = true })
            end
        },
    },

    --[[ explore ]]--
    {
        -- telescope
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                { 'nvim-lua/plenary.nvim' },
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    build = 'make',
                    cond = function()
                        return vim.fn.executable 'make' == 1
                    end,
                }
            },
        },
        -- files
        { 'nvim-tree/nvim-tree.lua' },
        -- scm
        {
            'tpope/vim-fugitive',
            'airblade/vim-gitgutter',
        },
    },

    --[[ apprearance ]]--
    {
        -- status bar
        { 'nvim-lualine/lualine.nvim' },
        -- colorscheme
        {
            { 'edeneast/nightfox.nvim' },
            { 'folke/tokyonight.nvim' },
            { 'catppuccin/nvim', as = 'catppuccin' },
            { 'jacoborus/tender.vim' },
            { 'rose-pine/neovim' },
            { 'nyoom-engineering/oxocarbon.nvim' },
        },
    },
})
