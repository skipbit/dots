
return {
    {
        -- mason
        'williamboman/mason.nvim', lazy = false, config = function ()
            require('mason').setup({
                ui = {
                    border = 'rounded',
                }
            })
        end
    },
    {
        -- mason-lspconfig (language server)
        'williamboman/mason-lspconfig.nvim', lazy = false, opts = { auto_install = true, }, config = function ()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'bashls',
                    'clangd',
                    'cmake',
                    'dockerls',
                    'eslint',
                    'lua_ls',
                    'pylsp',
                    'rust_analyzer',
                    'tsserver',
                },
                automatic_installation = true,
            })
        end
    },
    {
        -- nvim-lspconfig (language server)
        'neovim/nvim-lspconfig', lazy = false, config = function ()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require('lspconfig')

            local on_attach = function(_, bufnr)
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

                vim.keymap.set('n', '<leader>a', '<cmd>ClangdSwitchSourceHeader<CR>', {})
                vim.keymap.set('n', '<leader>f', function()
                    vim.lsp.buf.format { async = true }
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

            -- python-lsp-server (Python)
            lspconfig.pylsp.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
            })

            -- lua
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                flags = { debounce_text_changes = 150 },
            })

            -- border settings
            local border_config = { border = 'rounded' }
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border_config)
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, border_config)
            vim.diagnostic.config {
                float = border_config
            }
            require('lspconfig.ui.windows').default_options.border = 'rounded'

            -- other settings
            vim.opt.signcolumn = 'yes'
        end
    },
    {
        -- none-ls
        'nvimtools/none-ls.nvim', config = function ()
            local null_ls = require('null-ls')
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.actionlint,   -- zsh
                    null_ls.builtins.diagnostics.zsh,          -- zsh
                    null_ls.builtins.formatting.clang_format,  -- clang (c/c++)
                    null_ls.builtins.formatting.prettier,      -- prettier (js, ts, html, etc)
                    null_ls.builtins.formatting.stylua,        -- lua
                    null_ls.builtins.hover.printenv,
                }
            })
        end
    },
}

