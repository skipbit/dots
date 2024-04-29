
return {
    'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
    },
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'bash',
                'c',
                'cpp',
                'lua',
                'json',
                'markdown',
                'rust',
                'vim',
                'vimdoc',
                'dockerfile',
                'git_config',
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true
            },
            autotag = {
                enable = true
            },
            auto_install = true
        })
    end
}

