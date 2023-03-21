
local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
    return
end

treesitter.setup({
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'help',
        'lua',
        'json',
        'markdown',
        'rust',
        'vim',
    },
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true
    },
    auto_install = true
})
