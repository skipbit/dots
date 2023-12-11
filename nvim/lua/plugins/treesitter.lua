
local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
    return
end

treesitter.setup({
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'lua',
        'json',
        'markdown',
        'rust',
        'vim',
        'vimdoc',
        'dockerfile',
        'git_config',
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true
    },
    auto_install = true
})
