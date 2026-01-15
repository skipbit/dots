
return {
    'nvim-telescope/telescope.nvim', tag = 'v0.2.1', dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        {
            'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function()
                return vim.fn.executable 'make' == 1
            end
        },
        {
            'nvim-telescope/telescope-dap.nvim', dependencies = { 'mfussenegger/nvim-dap' }
        },
        {
            'nvim-telescope/telescope-ui-select.nvim',
        },
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-k>'] = require('telescope.actions').move_selection_previous,
                        ['<C-j>'] = require('telescope.actions').move_selection_next,
                        ['<C-f>'] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
                    }
                },
            },
            pickers = {
                buffers = {
                    disable_devicons = true,
                },
                find_files = {
                    disable_devicons = true,
                },
                git_files = {
                    recurse_submodules = true,
                    disable_devicons = true,
                },
                grep_string = {
                    disable_devicons = true,
                },
                live_grep = {
                    disable_devicons = true,
                    additional_args = function(_)
                        return { "--hidden" }
                    end,
                    file_ignore_patterns = { '.git', '.hg', '.bzr', '.svn', '.cvs' },
                },
                oldfiles = {
                    disable_devicons = true,
                },
                current_buffer_fuzzy_find = {
                    sorting_strategy = 'ascending',
                },
            }
        })

        local builtin = require('telescope.builtin')

        -- Load extensions
        telescope.load_extension('dap')
        telescope.load_extension('fzf')
        telescope.load_extension('ui-select')

        -- File pickers
        vim.keymap.set('n', '<leader><C-f>', builtin.find_files, {})
        vim.keymap.set('n', '<leader>zf', builtin.git_files, {})

        -- Vim pickers
        vim.keymap.set('n', '<leader>zb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>zT', builtin.tags, {})
        vim.keymap.set('n', '<leader>zh', builtin.oldfiles, {})
        vim.keymap.set('n', '<leader>z:', builtin.command_history, {})
        vim.keymap.set('n', '<leader>z/', builtin.search_history, {})
        vim.keymap.set('n', '<leader>zq', builtin.quickfix, {})
        vim.keymap.set('n', '<leader>qq', builtin.quickfixhistory, {})
        vim.keymap.set('n', '<leader>zj', builtin.jumplist, {})
        vim.keymap.set('n', '<leader>zm', builtin.marks, {})
        vim.keymap.set('n', '<leader>zp', builtin.registers, {})
        vim.keymap.set('n', '<leader>zk', builtin.keymaps, {})
        vim.keymap.set('n', '<leader>zc', builtin.colorscheme, {})

        -- Help pickers
        vim.keymap.set('n', '<leader>?h', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>?m', builtin.man_pages, {})

        -- Grep pickers
        vim.keymap.set('n', '<leader>z*', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>z?', function()
            local ok, search = pcall(vim.fn.input, "Grep > ")
            if ok and search ~= '' then
                builtin.grep_string({ search = search })
            end
        end)
        vim.keymap.set('n', '<leader>zl', builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set('n', '<leader>zt', builtin.current_buffer_tags, {})

        -- Git pickers
        vim.keymap.set('n', '<leader>zG', builtin.git_commits, {})
        vim.keymap.set('n', '<leader>zg', builtin.git_bcommits, {})
        vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
        vim.keymap.set('n', '<leader>zz', builtin.git_status, {})
        vim.keymap.set('n', '<leader>gz', builtin.git_stash, {})

        -- LSP pickers
        vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
        vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, {})
        vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {})
        vim.keymap.set('n', '<leader>gD', builtin.lsp_type_definitions, {})
        vim.keymap.set('n', '<leader>gs', builtin.lsp_document_symbols, {})
        vim.keymap.set('n', '<leader>gS', builtin.lsp_workspace_symbols, {})
        vim.keymap.set('n', '<leader>g?', builtin.lsp_dynamic_workspace_symbols, {})
        vim.keymap.set('n', '<leader>gh', builtin.lsp_incoming_calls, {})
        vim.keymap.set('n', '<leader>gH', builtin.lsp_outgoing_calls, {})
        vim.keymap.set('n', '<leader><space>e', builtin.diagnostics, {})

        -- Telescope pickers
        vim.keymap.set('n', '<leader>??', builtin.builtin, {})
        vim.keymap.set('n', '<leader>//', builtin.commands, {})

        -- DAP pickers
        local dap_telescope = telescope.extensions.dap
        local function require_dap_session(fn)
            return function()
                if require('dap').session() then
                    fn()
                else
                    vim.notify('No active debug session', vim.log.levels.WARN)
                end
            end
        end
        vim.keymap.set('n', '<leader>d?', dap_telescope.commands, { desc = 'Debug: Commands' })
        vim.keymap.set('n', '<leader>dl', dap_telescope.list_breakpoints, { desc = 'Debug: List Breakpoints' })
        vim.keymap.set('n', '<leader>dv', require_dap_session(dap_telescope.variables), { desc = 'Debug: Variables' })
        vim.keymap.set('n', '<leader>df', require_dap_session(dap_telescope.frames), { desc = 'Debug: Frames' })
        vim.keymap.set('n', '<leader>dD', dap_telescope.configurations, { desc = 'Debug: configurations' })
    end
}
