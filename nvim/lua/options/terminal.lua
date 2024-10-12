
local autocmd = vim.api.nvim_create_autocmd

-- `:Term` で下方分割
autocmd('CmdlineEnter', {
    command = 'command! Term :botright split term://$SHELL'
})
-- `:VTerm` または `:Vterm` で右側分割
autocmd('CmdlineEnter', {
    command = 'command! VTerm :botright vsplit term://$SHELL'
})
autocmd('CmdlineEnter', {
    command = 'command! Vterm :botright vsplit term://$SHELL'
})

-- ターミナルを開いた時
autocmd('TermOpen', {
    command = 'setlocal listchars= nonumber norelativenumber nocursorline'
})

autocmd('TermOpen', {
    command = 'startinsert'
})

-- ターミナルを閉じた時 (自動で閉じる)
autocmd('TermClose', {
    command = 'if &buftype == "terminal" && !v:event.status | exe "silent! bdelete!" | endif'
})

-- ターミナルに入った時
autocmd('BufEnter', {
    pattern = 'term://*',
    command = 'startinsert'
})

-- ターミナルから出た時
autocmd('BufLeave', {
    pattern = 'term://*',
    command = 'stopinsert'
})

