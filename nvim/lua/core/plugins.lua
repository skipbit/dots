
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
	    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
    })
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use ({ 'nvim-lua/plenary.nvim' })

    -- lsp
    use ({ 'neovim/nvim-lspconfig' })
    use ({ 'hrsh7th/cmp-nvim-lsp' })
    -- manage & install lsp servers/linters/formatters
    use ({ 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' })
    use ({ 'jose-elias-alvarez/null-ls.nvim', 'jay-babu/mason-null-ls.nvim' })

    -- syntax highlight
    use ({ 'nvim-treesitter/nvim-treesitter'}, { run = ':TSUpdate' })

    -- completion
    use ({ 'hrsh7th/nvim-cmp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path' })

    -- colorscheme
    use ({
        { 'edeneast/nightfox.nvim' },
        { 'folke/tokyonight.nvim' },
        { 'catppuccin/nvim', as = 'catppuccin' },
        { 'jacoborus/tender.vim' },
    })

    -- files
    use ({ 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' }})

    -- telescope
    use ({ 'nvim-telescope/telescope.nvim' })
    use ({ 'nvim-telescope/telescope-file-browser.nvim' })

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
