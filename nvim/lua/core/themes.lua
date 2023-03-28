
--[[
local status, _ = pcall(vim.cmd 'colorscheme nightfox')
if not status then
    print('colorscheme is not available')
    return
end
--]]
pcall(vim.cmd 'colorscheme dracula')

function colormypencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

--colormypencils()
