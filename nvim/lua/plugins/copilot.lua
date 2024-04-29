
return {
    'zbirenbaum/copilot.lua', cmd = 'Copilot', event = 'InsertEnter',
    config = function()
        require('copilot').setup({
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = '[[',
                    jump_next = ']]',
                    accept = '<CR>',
                    refresh = 'gr',
                    open = '<M-CR>',
                },
                layout = {
                    position = 'right', -- top | left | right | bottom
                    ratio = 0.4
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = false,
                debounce = 75,
                keymap = {
                    accept = '<C-g>',
                    accept_word = false,
                    accept_line = false,
                    next = '<C-j>',
                    prev = '<C-k>',
                    dismiss = '<C-o>',
                },
            },
            filetypes = {
                ['*'] = true,
            },
            copilot_node_command = 'node',
            server_opts_overrides = {},
        })
    end
}

