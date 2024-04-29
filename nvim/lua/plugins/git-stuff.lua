
return {
    {
        -- gitsigns
        'lewis6991/gitsigns.nvim', config = function ()
            require('gitsigns').setup({
                signcolumn = true,
                numhl = true,
            })
        end
    },
    {
        -- diffview
        'sindrets/diffview.nvim', config = function ()
            require('diffview').setup({
                use_icons = false,
            })
        end
    },
    {
        -- neogit
        'NeogitOrg/neogit', dependencies = {
            'nvim-lua/plenary.nvim',
        }, config = function ()
            require('neogit').setup({
                kind = 'auto',
                integrations = {
                    telescope = true,
                    diffview = true,
                },
            })
        end
    },
    {
        -- git
        'dinhhuy258/git.nvim', config = function ()
            require('git').setup({
            })
        end
    },
}

