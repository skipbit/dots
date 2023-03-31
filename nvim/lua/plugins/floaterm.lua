
-- 'voldikss/vim-floaterm'

vim.cmd[[let g:floaterm_wintype = 'float']]
vim.cmd[[let g:floaterm_width = 0.8]]
vim.cmd[[let g:floaterm_height = 0.8]]
vim.cmd[[let g:floaterm_position = 'center']]
vim.cmd[[let g:floaterm_opener = 'vsplit']]
vim.cmd[[let g:floaterm_autoclose = 1]]
vim.cmd[[let g:floaterm_autohide = 1]]

vim.cmd[[let g:floaterm_keymap_new = '<Leader>tc']]
vim.cmd[[let g:floaterm_keymap_prev = '<Leader>tp']]
vim.cmd[[let g:floaterm_keymap_next = '<Leader>tn']]
vim.cmd[[let g:floaterm_keymap_hide = '<Leader>th']]
vim.cmd[[let g:floaterm_keymap_toggle = '<Leader>tt']]

vim.keymap.set('n', '<leader>tc', '<Cmd>FloatermNew<CR>')
vim.keymap.set('n', '<leader>tk', '<Cmd>FloatermKill<CR>')
vim.keymap.set('n', '<leader>tp', '<Cmd>FloatermPrev<CR>')
vim.keymap.set('n', '<leader>tn', '<Cmd>FloatermNext<CR>')
vim.keymap.set('n', '<leader>t0', '<Cmd>FloatermFirst<CR>')
vim.keymap.set('n', '<leader>t$', '<Cmd>FloatermLast<CR>')
vim.keymap.set('n', '<leader>ts', '<Cmd>FloatermShow<CR>')
vim.keymap.set('n', '<leader>th', '<Cmd>FloatermHide<CR>')
vim.keymap.set('n', '<leader>tt', '<Cmd>FloatermToggle<CR>')

vim.keymap.set('t', '<leader>tc', '<C-\\><C-n><Cmd>FloatermNew<CR>')
vim.keymap.set('t', '<leader>tk', '<C-\\><C-n><Cmd>FloatermKill<CR>')
vim.keymap.set('t', '<leader>tp', '<C-\\><C-n><Cmd>FloatermPrev<CR>')
vim.keymap.set('t', '<leader>tn', '<C-\\><C-n><Cmd>FloatermNext<CR>')
vim.keymap.set('t', '<leader>ts', '<C-\\><C-n><Cmd>FloatermShow<CR>')
vim.keymap.set('t', '<leader>t0', '<C-\\><C-n><Cmd>FloatermFirst<CR>')
vim.keymap.set('t', '<leader>t$', '<C-\\><C-n><Cmd>FloatermLast<CR>')
vim.keymap.set('t', '<leader>th', '<C-\\><C-n><Cmd>FloatermHide<CR>')
vim.keymap.set('t', '<leader>tt', '<C-\\><C-n><Cmd>FloatermToggle<CR>')
