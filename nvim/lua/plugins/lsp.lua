
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

vim.opt.signcolumn = 'yes'

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local buffer_options = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, buffer_options)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, buffer_options)

    vim.keymap.set('n', 'gr', vim.lsp.buf.references, buffer_options)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buffer_options)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buffer_options)
    vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, buffer_options)
    vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, buffer_options)
    vim.keymap.set('n', 'gS', vim.lsp.buf.workspace_symbol, buffer_options)
    vim.keymap.set('n', 'ga', vim.lsp.buf.declaration, buffer_options)
    vim.keymap.set('n', 'gh', vim.lsp.buf.incoming_calls, buffer_options)
    vim.keymap.set('n', 'gH', vim.lsp.buf.outgoing_calls, buffer_options)

    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']g', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setqflist)

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, buffer_options)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, buffer_options)

    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, buffer_options)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, buffer_options)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, buffer_options)

    vim.keymap.set('n', '<C-a>', '<cmd>ClangdSwitchSourceHeader<CR>', {})
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

-- python-lsp-server (Python)
lspconfig.pylsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
})
