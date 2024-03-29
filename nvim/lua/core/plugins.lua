
local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
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

return require('lazy').setup({
    -- general
    'vim-jp/cpp-vim',
    'editorconfig/editorconfig-vim',

    --[[ backends ]]--
    {
        -- lsp
        {
            'neovim/nvim-lspconfig', dependencies = {
                { 'williamboman/mason.nvim' },
                { 'williamboman/mason-lspconfig.nvim' },
            },
        },
        -- dap
        {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui',
        },
        -- auto completion
        {
            {
                'hrsh7th/nvim-cmp', dependencies = {
                    'hrsh7th/cmp-nvim-lsp',
                    'hrsh7th/cmp-buffer',
                    'hrsh7th/cmp-path',
                    'hrsh7th/cmp-cmdline',
                },
            },
            { 'hrsh7th/vim-vsnip' },
        },
        -- syntax highlight
        {
            'nvim-treesitter/nvim-treesitter', dependencies = {
                { 'nvim-treesitter/nvim-treesitter-textobjects' },
            }, config = function()
                pcall(require('nvim-treesitter.install').update { with_sync = true })
            end
        },
    },

    --[[ explore ]]--
    {
        -- telescope
        {
            'nvim-telescope/telescope.nvim', dependencies = {
                { 'nvim-lua/plenary.nvim' },
                { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function()
                        return vim.fn.executable 'make' == 1
                    end,
                },
                { 'nvim-telescope/telescope-dap.nvim' },
                { 'nvim-telescope/telescope-ui-select.nvim' },
            },
        },
        -- files
        { 'nvim-tree/nvim-tree.lua' },
        -- scm
        {
            'NeogitOrg/neogit', dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope.nvim',
                'sindrets/diffview.nvim',
            },
            { 'lewis6991/gitsigns.nvim' },
            { 'sindrets/diffview.nvim' },
            { 'dinhhuy258/git.nvim' },
        },
    },

    --[[ apprearance ]]--
    {
        -- status bar
        { 'nvim-lualine/lualine.nvim' },
        -- colorscheme
        {
            { 'edeneast/nightfox.nvim' },
            { 'tomasr/molokai' },
            { 'tanvirtin/monokai.nvim' },
            { 'sainnhe/sonokai' },
            { 'Mofiqul/dracula.nvim' },
        },
    },

    --[[ advanced ]]--
    {
        { 'zbirenbaum/copilot.lua', cmd = 'Copilot', event = 'InsertEnter' },
        {
            'zbirenbaum/copilot-cmp', config = function()
                require('copilot_cmp').setup({})
            end,
        }
    }
}, lazy_options)
