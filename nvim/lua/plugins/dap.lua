
return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            -- UI
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            -- Inline variable display
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            local widgets = require('dap.ui.widgets')

            ---------------------------------------------------------------------------
            -- Adapters
            ---------------------------------------------------------------------------

            -- codelldb (installed via Mason: :MasonInstall codelldb)
            dap.adapters.codelldb = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
                    args = { '--port', '${port}' },
                },
            }

            ---------------------------------------------------------------------------
            -- Configurations
            ---------------------------------------------------------------------------

            local codelldb_config = {
                {
                    name = 'Launch executable',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = function()
                        local input = vim.fn.input('Arguments: ')
                        return vim.split(input, ' ', { trimempty = true })
                    end,
                },
                {
                    name = 'Attach to process',
                    type = 'codelldb',
                    request = 'attach',
                    pid = require('dap.utils').pick_process,
                    cwd = '${workspaceFolder}',
                },
            }

            dap.configurations.c = codelldb_config
            dap.configurations.cpp = codelldb_config
            dap.configurations.rust = codelldb_config

            ---------------------------------------------------------------------------
            -- DAP UI
            ---------------------------------------------------------------------------

            dapui.setup({
                icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
                layouts = {
                    {
                        elements = {
                            { id = 'scopes', size = 0.4 },
                            { id = 'breakpoints', size = 0.2 },
                            { id = 'stacks', size = 0.2 },
                            { id = 'watches', size = 0.2 },
                        },
                        size = 40,
                        position = 'left',
                    },
                    {
                        elements = {
                            { id = 'repl', size = 0.5 },
                            { id = 'console', size = 0.5 },
                        },
                        size = 10,
                        position = 'bottom',
                    },
                },
            })

            -- Auto open/close UI
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            ---------------------------------------------------------------------------
            -- Virtual Text
            ---------------------------------------------------------------------------

            require('nvim-dap-virtual-text').setup({
                enabled = true,
                enabled_commands = true,
                highlight_changed_variables = true,
                highlight_new_as_changed = false,
                show_stop_reason = true,
                commented = false,
                only_first_definition = true,
                all_references = false,
                virt_text_pos = 'eol',
            })

            ---------------------------------------------------------------------------
            -- Signs
            ---------------------------------------------------------------------------

            vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
            vim.fn.sign_define('DapBreakpointCondition', { text = '◐', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
            vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
            vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })

            ---------------------------------------------------------------------------
            -- Keymaps
            ---------------------------------------------------------------------------

            -- Session control
            vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Continue' })
            vim.keymap.set('n', '<leader>dr', dap.run_last, { desc = 'Debug: Run last' })
            vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = 'Debug: Terminate' })
            vim.keymap.set('n', '<leader>dp', dap.pause, { desc = 'Debug: Pause' })

            -- Stepping
            vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step into' })
            vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step over' })
            vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug: Step out' })
            vim.keymap.set('n', '<leader>dC', dap.run_to_cursor, { desc = 'Debug: Run to cursor' })

            -- Breakpoints
            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint' })
            vim.keymap.set('n', '<leader>dB', function()
                dap.set_breakpoint(vim.fn.input('Condition: '))
            end, { desc = 'Debug: Conditional breakpoint' })
            vim.keymap.set('n', '<leader>dl', function()
                dap.set_breakpoint(nil, nil, vim.fn.input('Log message: '))
            end, { desc = 'Debug: Log point' })
            vim.keymap.set('n', '<leader>dx', dap.clear_breakpoints, { desc = 'Debug: Clear breakpoints' })

            -- UI
            vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })
            vim.keymap.set('n', '<leader>de', dapui.eval, { desc = 'Debug: Eval' })
            vim.keymap.set('v', '<leader>de', dapui.eval, { desc = 'Debug: Eval selection' })

            -- Widgets (hover, scopes, etc.)
            vim.keymap.set('n', '<leader>dh', widgets.hover, { desc = 'Debug: Hover' })
            vim.keymap.set('v', '<leader>dh', widgets.hover, { desc = 'Debug: Hover selection' })
            vim.keymap.set('n', '<leader>ds', function()
                widgets.centered_float(widgets.scopes)
            end, { desc = 'Debug: Scopes' })
            vim.keymap.set('n', '<leader>df', function()
                widgets.centered_float(widgets.frames)
            end, { desc = 'Debug: Frames' })

            -- REPL
            vim.keymap.set('n', '<leader>dR', dap.repl.toggle, { desc = 'Debug: Toggle REPL' })
        end,
    },
}
