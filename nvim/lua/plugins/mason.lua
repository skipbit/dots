
-- mason
local status, mason = pcall(require, 'mason')
if not status then
    return
end

mason.setup({
    ui = {
        border = 'rounded',
    }
})

-- mason-lspconfig (language server)
local status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status then
    return
end

mason_lspconfig.setup({
    ensure_installed = {
        'clangd',
        'cmake',
        'rust_analyzer',
    },
    automatic_installation = true,
})

-- mason-null-ls (linter, formatter)
local status, mason_null_ls = pcall(require, 'mason-null-ls')
if not status then
    return
end

mason_null_ls.setup({
    ensure_installed = {
        'actionlint',
        'asm-lsp',
        'bash-debug-adapter',
        'clang-format',
        'cpplint',
        'lua-language-server',
        'luacheck',
        'rustfmt',
        'stylua',
    },
    automatic_installation = true,
})

