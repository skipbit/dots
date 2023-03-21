
--[[ normal mode ]]--

vim.keymap.set('n', 'J', "mzJz")
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")

--[[ visual mode ]]--

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

--[[ terminal mode ]]--

vim.keymap.set('t', '<C-w>N', '<C-\\><C-n>')
vim.keymap.set('t', '<C-w>h', '<Cmd>wincmd h<CR>', { silent = true })
vim.keymap.set('t', '<C-w>j', '<Cmd>wincmd j<CR>', { silent = true })
vim.keymap.set('t', '<C-w>k', '<Cmd>wincmd k<CR>', { silent = true })
vim.keymap.set('t', '<C-w>l', '<Cmd>wincmd l<CR>', { silent = true })
vim.keymap.set('t', '<C-w>w', '<Cmd>wincmd w<CR>', { silent = true })
vim.keymap.set('t', '<C-w><C-w>', '<Cmd>wincmd <C-w><CR>', { silent = true })

