
-- <https://raw.githubusercontent.com/kyazdani42/nvim-tree.lua/master/doc/nvim-tree-lua.txt>

local status, nvimtree = pcall(require, 'nvim-tree')
if not status then
    return
end

--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
    view = {
        side = left,
        width = 40,
    },
    renderer = {
        highlight_git = true,
        icons = {
            show = { file = false, folder = false, folder_arrow = true, git = false, modified = false }
        },
    },
})

local api = require('nvim-tree.api')
local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

-- override: horizontal split (default: <C-X>)
vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))

vim.keymap.set('n', '<C-l>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<C-n>', ':NvimTreeFindFile<CR>')

