
-- cmp_nvim_lsp (auto-completion)
local status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status then
    return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

-- nvim-lspconfig
local status, lspconfig = pcall(require, 'lspconfig')
if not status then
    return
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local buffer_options = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, buffer_options)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buffer_options)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buffer_options)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buffer_options)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, buffer_options)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, buffer_options)

    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, buffer_options)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, buffer_options)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, buffer_options)
end

-- clangd (C/C++)
lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
})

-- rust_analyzer (Rust)
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
})
