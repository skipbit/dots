
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
                ['<C-f>'] = actions.send_selected_to_qflist + actions.open_qflist,
            }
        }
    },
    pickers = {
        git_files = {
            recurse_submodules = true
        }
    }
})

local builtin = require('telescope.builtin')

-- File pickers
vim.keymap.set('n', '<leader><C-f>', builtin.find_files, {})
vim.keymap.set('n', '<leader>zf', builtin.git_files, {})

-- Vim pickers
vim.keymap.set('n', '<leader>zb', builtin.buffers, {})
vim.keymap.set('n', '<leader>zt', builtin.tags, {})
vim.keymap.set('n', '<leader>zh', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>z:', builtin.command_history, {})
vim.keymap.set('n', '<leader>z/', builtin.search_history, {})
vim.keymap.set('n', '<leader>zq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>qq', builtin.quickfixhistory, {})
vim.keymap.set('n', '<leader>zj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>zl', builtin.loclist, {})
vim.keymap.set('n', '<leader>zm', builtin.marks, {})
vim.keymap.set('n', '<leader>zp', builtin.registers, {})
vim.keymap.set('n', '<leader>zk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>zc', builtin.colorscheme, {})
-- vim.keymap.set('n', '<leader>z*', builtin.highlights, {}) -- highlight color for current colorscheme
vim.keymap.set('n', '<leader>za', builtin.autocommands, {})
vim.keymap.set('n', '<leader>zo', builtin.vim_options, {})

-- Help pickers
vim.keymap.set('n', '<leader>?h', builtin.help_tags, {})
vim.keymap.set('n', '<leader>?m', builtin.man_pages, {})

-- Grep pickers
vim.keymap.set('n', '<leader>z*', builtin.live_grep, {})
vim.keymap.set('n', '<leader>//', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
--vim.keymap.set('n', '<leader>z?', builtin.pickers, {})
vim.keymap.set('n', '<leader>zL', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>zt', builtin.current_buffer_tags, {})

-- Git pickers
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gf', builtin.git_status, {})
vim.keymap.set('n', '<leader>gz', builtin.git_stash, {})

-- LSP pickers
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>gD', builtin.lsp_type_definitions, {})
vim.keymap.set('n', '<leader>gs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>gS', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>g?', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>ge', builtin.diagnostics, {})

-- Telescope pickers
vim.keymap.set('n', '<leader>??', builtin.builtin, {})

telescope.load_extension('fzf')

