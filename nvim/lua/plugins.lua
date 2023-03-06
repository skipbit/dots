
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
    use ({ 'nvim-treesitter/nvim-treesitter'}, { run = ':TSUpdate' })
    use ({ 'nvim-telescope/telescope.nvim' })
    use ({ 'nvim-telescope/telescope-file-browser.nvim' })
end)
