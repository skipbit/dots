
-- <https://raw.githubusercontent.com/kyazdani42/nvim-tree.lua/master/doc/nvim-tree-lua.txt>

--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

return {
    'nvim-tree/nvim-tree.lua', config = function()
        require('nvim-tree').setup({
            actions = {
                open_file = {
                    window_picker = {
                        enable = true,
                    },
                },
            },
            view = {
                side = 'left',
                width = 40,
            },
            renderer = {
                highlight_git = true,
                icons = {
                    show = { file = false, folder = false, folder_arrow = true, git = false, modified = false }
                },
            },
            on_attach = function (bufnr)
                local function opts(desc)
                    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                local api = require('nvim-tree.api')
                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split')) -- override: horizontal split (default: <C-X>)
            end
        })

        vim.keymap.set('n', '<C-l>', ':NvimTreeToggle<CR>')
        vim.keymap.set('n', '<C-n>', ':NvimTreeFindFile<CR>')
    end
}
