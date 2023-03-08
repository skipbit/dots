
local status, telescope = pcall(require, 'telescope')
if not status then
    return
end

local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            }
        }
    }
})

vim.keymap.set('n', '<leader><C-f>', '<cmd>Telescope find_files<CR>')

vim.keymap.set('n', '<leader>zf', '<cmd>Telescope git_files<CR>')
vim.keymap.set('n', '<leader>zh', '<cmd>Telescope search_history')
vim.keymap.set('n', '<leader>zt'. '<cmd>Telescope tags')

telescope.load_extension('fzf')

