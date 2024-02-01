
--[[ terminal mode ]]--

vim.keymap.set('t', '<C-w>N', '<C-\\><C-n>')
vim.keymap.set('t', '<C-w>h', '<Cmd>wincmd h<CR>', { silent = true })
vim.keymap.set('t', '<C-w>j', '<Cmd>wincmd j<CR>', { silent = true })
vim.keymap.set('t', '<C-w>k', '<Cmd>wincmd k<CR>', { silent = true })
vim.keymap.set('t', '<C-w>l', '<Cmd>wincmd l<CR>', { silent = true })
vim.keymap.set('t', '<C-w>t', '<Cmd>wincmd t<CR>', { silent = true })
vim.keymap.set('t', '<C-w>b', '<Cmd>wincmd b<CR>', { silent = true })
vim.keymap.set('t', '<C-w>p', '<Cmd>wincmd p<CR>', { silent = true })
vim.keymap.set('t', '<C-w>w', '<Cmd>wincmd w<CR>', { silent = true })
vim.keymap.set('t', '<C-w><C-w>', '<Cmd>wincmd <C-w><CR>', { silent = true })
vim.keymap.set('t', '<C-w>gt', '<Cmd>wincmd gt<CR>', { silent = true })
vim.keymap.set('t', '<C-w>gT', '<Cmd>wincmd gT<CR>', { silent = true })
vim.keymap.set('t', '<C-w>|', '<Cmd>wincmd |<CR>', { silent = true })
vim.keymap.set('t', '<C-w>_', '<Cmd>wincmd _<CR>', { silent = true })
vim.keymap.set('t', '<C-w>=', '<Cmd>wincmd =<CR>', { silent = true })

--[[ copilot ]]--
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<C-o>', '<Plug>(copilot-dismiss)')
vim.keymap.set('i', '<C-s>', '<Plug>(copilot-suggest)')
vim.keymap.set('i', '<C-g>', 'copilot#Accept("<CR>")', { silent = true, expr = true, script = true, replace_keycodes = false })
vim.keymap.set('i', '<C-W>', '<Plug>(copilot-accept-word)', { silent = true })
vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-line)', { silent = true })
