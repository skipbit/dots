
-- gitsigns
require('gitsigns').setup({
    signcolumn = true,
    numhl = true,
})

-- neogit
require('neogit').setup({
    kind = 'auto',
    integrations = {
        telescope = true,
        diffview = true,
    },
})

-- diffview
require('diffview').setup({
    use_icons = false,
})

