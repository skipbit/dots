-- nvim-treesitter configuration for Neovim 0.11+ (main branch)
-- Highlighting uses Neovim's built-in vim.treesitter.start()
return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            -- Install parsers
            require('nvim-treesitter').install({
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
            })

            -- Enable highlighting and indentation via FileType autocommand
            vim.api.nvim_create_autocmd('FileType', {
                callback = function(args)
                    -- Enable treesitter highlighting (built-in Neovim feature)
                    pcall(vim.treesitter.start, args.buf)
                    -- Enable treesitter indentation
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
}

