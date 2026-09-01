
local claude_cmd = vim.fn.exepath('claude')
if claude_cmd == '' then
    claude_cmd = vim.fn.expand('~/.local/bin/claude')
end

-- Terminal providers that `:ClaudeCodeProvider` can switch between at runtime.
local providers = { 'native', 'snacks', 'external' }

-- Open Claude in a tmux pane. jobstart's `env` is not inherited through the tmux
-- server, so hand the variables over explicitly with env(1).
local function tmux_split(cmd, env)
    if not vim.env.TMUX then
        vim.notify('claudecode: the external provider needs tmux', vim.log.levels.ERROR)
        return nil
    end

    local parts = { 'tmux', 'split-window', '-h', '-c', vim.fn.getcwd(), '--', 'env' }
    for name, value in pairs(env or {}) do
        table.insert(parts, string.format('%s=%s', name, value))
    end
    vim.list_extend(parts, vim.split(cmd, ' ', { trimempty = true }))

    return parts
end

-- Any window inside a layout node; resizing it resizes the whole column.
local function first_leaf(node)
    if node[1] == 'leaf' then
        return node[2]
    end

    for _, child in ipairs(node[2]) do
        local win = first_leaf(child)
        if win then
            return win
        end
    end
end

-- An equal share of the columns left once the file tree is taken out, counting
-- the splits already side by side plus Claude's own.
local function target_width()
    local layout = vim.fn.winlayout()
    local usable = vim.o.columns
    local slots, has_claude = 0, false
    local ok, terminal = pcall(require, 'claudecode.terminal')
    local active = ok and terminal.get_active_terminal_bufnr() or nil

    if layout[1] == 'row' then
        for _, child in ipairs(layout[2]) do
            -- A non-leaf child is a stack of horizontal splits: one column either way.
            local win = child[1] == 'leaf' and child[2] or nil
            local buf = win and vim.api.nvim_win_get_buf(win)
            if buf and vim.bo[buf].filetype == 'NvimTree' then
                usable = usable - vim.api.nvim_win_get_width(win) - 1
            else
                slots = slots + 1
                has_claude = has_claude or (buf ~= nil and buf == active)
            end
        end
    else
        slots = 1
    end

    if not has_claude then
        slots = slots + 1
    end

    -- `slots` windows sit either side of `slots - 1` separators.
    return math.floor((usable - slots + 1) / slots)
end

-- The plugin sizes the split as `math.floor(columns * split_width_percentage)`
-- and resizes it again around diffs, so keep that fraction in step with the
-- layout. The extra 0.5 keeps the floor from shaving a column off.
--
-- `resize` additionally levels the columns out: opening with `botright vsplit`
-- only takes room from the neighbour, which leaves the other splits uneven.
local function fit(resize)
    local width = target_width()
    if width < 10 then
        return
    end

    local terminal = require('claudecode.terminal')
    terminal.defaults.split_width_percentage = (width + 0.5) / vim.o.columns

    -- Only the native provider puts Claude in an ordinary window. A snacks float
    -- and the tmux pane are not part of the layout, so leave the columns alone.
    local layout = vim.fn.winlayout()
    if not resize or layout[1] ~= 'row' or terminal.defaults.provider ~= 'native' then
        return
    end

    for _, child in ipairs(layout[2]) do
        local win = first_leaf(child)
        -- The file tree holds its own width (winfixwidth), so leave it alone.
        if win and vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'NvimTree' then
            vim.api.nvim_win_set_width(win, width)
        end
    end
end

-- `terminal.defaults` is the live config table the provider lookup reads on every
-- call, so swapping `provider` there is enough. Calling `terminal.setup()` again
-- would drop `terminal_cmd`, which it only takes as a positional argument.
local function switch_provider(name)
    local terminal = require('claudecode.terminal')

    terminal.close()
    terminal.defaults.provider = name

    local ok, provider = pcall(require, 'claudecode.terminal.' .. name)
    if ok and type(provider.setup) == 'function' then
        provider.setup(terminal.defaults)
    end
end

return {
    'coder/claudecode.nvim',
    cmd = {
        'ClaudeCode',
        'ClaudeCodeFocus',
        'ClaudeCodeSelectModel',
        'ClaudeCodeAdd',
        'ClaudeCodeSend',
        'ClaudeCodeTreeAdd',
        'ClaudeCodeStatus',
        'ClaudeCodeStart',
        'ClaudeCodeStop',
        'ClaudeCodeOpen',
        'ClaudeCodeClose',
        'ClaudeCodeDiffAccept',
        'ClaudeCodeDiffDeny',
        'ClaudeCodeCloseAllDiffs',
    },
    keys = {
        { '<leader>wc', '<cmd>ClaudeCode<CR>', desc = 'Claude: Toggle' },
        { '<leader>wf', '<cmd>ClaudeCodeFocus<CR>', desc = 'Claude: Focus' },
        { '<leader>wr', '<cmd>ClaudeCode --resume<CR>', desc = 'Claude: Resume' },
        { '<leader>wC', '<cmd>ClaudeCode --continue<CR>', desc = 'Claude: Continue' },
        { '<leader>wm', '<cmd>ClaudeCodeSelectModel<CR>', desc = 'Claude: Select model' },
        { '<leader>wb', '<cmd>ClaudeCodeAdd %<CR>', desc = 'Claude: Add current buffer' },
        { '<leader>ws', '<cmd>ClaudeCodeSend<CR>', mode = 'v', desc = 'Claude: Send selection' },
        { '<leader>ws', '<cmd>ClaudeCodeTreeAdd<CR>', ft = 'NvimTree', desc = 'Claude: Add file' },
        { '<leader>wa', '<cmd>ClaudeCodeDiffAccept<CR>', desc = 'Claude: Accept diff' },
        { '<leader>wd', '<cmd>ClaudeCodeDiffDeny<CR>', desc = 'Claude: Deny diff' },
    },
    opts = {
        terminal_cmd = claude_cmd,
        terminal = {
            provider = 'native',
            split_side = 'right',
            split_width_percentage = 0.5, -- kept in step by fit() below
            auto_close = true,
            auto_insert = true,
            -- Only used by `:ClaudeCodeProvider snacks`.
            snacks_win_opts = {
                position = 'float',
                width = 0.95,
                height = 0.95,
                border = 'rounded',
            },
            provider_opts = {
                external_terminal_cmd = tmux_split,
            },
        },
        diff_opts = {
            layout = 'vertical',
        },
    },
    config = function(_, opts)
        require('claudecode').setup(opts)

        fit()
        local width_group = vim.api.nvim_create_augroup('ClaudeCodeWidth', { clear = true })

        -- Refresh the fraction whenever the layout changes, so the split opens at
        -- the right width to begin with instead of squeezing the file tree and
        -- being resized afterwards. WinClosed fires before the window is gone,
        -- hence the deferral.
        vim.api.nvim_create_autocmd({ 'WinNew', 'WinClosed', 'VimResized', 'TabEnter' }, {
            group = width_group,
            callback = function()
                vim.schedule(fit)
            end,
        })

        -- TermOpen covers the first launch; re-opening the split only shows the
        -- buffer again, which is BufWinEnter.
        vim.api.nvim_create_autocmd({ 'TermOpen', 'BufWinEnter' }, {
            group = width_group,
            callback = function(args)
                if vim.bo[args.buf].buftype ~= 'terminal' then
                    return
                end

                -- The provider records the buffer only after termopen() returns,
                -- so the check has to wait a tick.
                vim.schedule(function()
                    if require('claudecode.terminal').get_active_terminal_bufnr() == args.buf then
                        fit(true)
                    end
                end)
            end,
        })

        vim.api.nvim_create_user_command('ClaudeCodeProvider', function(args)
            if not vim.tbl_contains(providers, args.args) then
                vim.notify(
                    'claudecode: unknown provider: ' .. args.args .. ' (' .. table.concat(providers, ', ') .. ')',
                    vim.log.levels.ERROR
                )
                return
            end

            switch_provider(args.args)
            vim.notify('claudecode: terminal provider is now ' .. args.args)
        end, {
            nargs = 1,
            complete = function()
                return providers
            end,
            desc = 'Switch the terminal provider',
        })
    end,
}
