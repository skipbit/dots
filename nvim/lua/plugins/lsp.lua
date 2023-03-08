
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

-- clangd (C/C++)
lspconfig.clangd.setup({
    capabilities = capabilities,
})

-- rust_analyzer (Rust)
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
})
