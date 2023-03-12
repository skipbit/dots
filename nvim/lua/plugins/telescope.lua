
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

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><C-f>', builtin.find_files, {})

vim.keymap.set('n', '<leader>zf', builtin.git_files, {})
vim.keymap.set('n', '<leader>zh', builtin.search_history, {})
vim.keymap.set('n', '<leader>zt', builtin.tags, {})
vim.keymap.set('n', '<leader>??', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

telescope.load_extension('fzf')

