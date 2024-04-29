
return {
    {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
    },
    {
        'mfussenegger/nvim-dap', config = function ()
            local dap, dapui = require('dap'), require('dapui')

            -- Adapters
            dap.adapters.lldb = {
                type = 'executable',
                command = '/usr/bin/lldb-vscode',
                name = 'lldb',
            }

            local lldb = {
                name = 'Launch lldb',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}', -- vim.fn.getcwd(),
                sourceMaps = true,
                stopOnEntry = false,
                runInTerminal = false,
                externalTerminal = false,
                env = {
                    DISPLAY = ':0',
                    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = 'YES',
                },
                args = {
                },
            }

            dap.configurations.c = {
                lldb
            }

            dap.configurations.cpp = {
                lldb
            }

            dap.configurations.rust = {
                lldb
            }

            -- DAP UI
            dapui.setup({})
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end

            -- DAP Keymaps
            vim.keymap.set('n', '<leader>dr', function() dap.continue() end)
            vim.keymap.set('n', '<leader>d_', function() dap.run_last() end)
            vim.keymap.set('n', '<leader>db', function() dap.set_breakpoint() end)
            vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
            vim.keymap.set('n', '<leader>dL', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
            vim.keymap.set('n', '<leader>dh', function() dap.toggle_breakpoint() end)
            vim.keymap.set('n', '<leader><C-k>', function() dap.step_out() end)
            vim.keymap.set('n', '<leader><C-l>', function() dap.step_into() end)
            vim.keymap.set('n', '<leader><C-j>', function() dap.step_over() end)
            vim.keymap.set('n', '<leader>dq', function() dap.terminate() end)

            vim.keymap.set('n', '<leader>di', function() dap.ui.variables.hover(function() return vim.fn.expand('<cexpr>') end) end)
            vim.keymap.set('v', '<leader>di', function() dap.ui.variables.visual_hover() end)
            vim.keymap.set('n', '<leader>d?', function() dap.ui.variables.scopes() end)

            vim.keymap.set('n', '<leader>dy', function() dapui.toggle() end)
            vim.keymap.set('v', '<leader>dv', function() dapui.eval(vim.fn.expand('<cexpr>')) end)
        end
    }
}

