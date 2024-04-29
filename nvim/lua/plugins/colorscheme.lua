
return {
    {
        'edeneast/nightfox.nvim',
        'tomasr/molokai',
        'tanvirtin/monokai.nvim',
        'Mofiqul/dracula.nvim',
    },
    {
        'sainnhe/sonokai', config = function ()
            local status, _ = pcall(vim.cmd, 'colorscheme sonokai')
            if status then
                -- override colors
                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                vim.api.nvim_set_hl(0, "FloatBorder", { fg = "grey", bg = "none" }) -- respect for TelescopeBorder
                vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
                vim.api.nvim_set_hl(0, "VertSplit", { fg = "grey", bg = "none" })
                vim.api.nvim_set_hl(0, "Visual", { fg = "#f0e68c", bg = "#6b8e24" }) -- from desert
                vim.api.nvim_set_hl(0, "LazyNormal", { bg = "none" })
                vim.api.nvim_set_hl(0, "MasonNormal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NVimTreeNormal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
                vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
                vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#f0e68c", bg = "#6b8e24" })
            end
        end
    }
}
