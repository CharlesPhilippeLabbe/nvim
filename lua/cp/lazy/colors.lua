function ColorMyPencils(color)
	color = color or "everforest"
	vim.cmd.colorscheme(color)

    --vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
    --vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
end


return   {
    'sainnhe/everforest',
    as = 'everforest',
    config = function()
        vim.cmd('set background=dark')
        vim.cmd('colorscheme everforest') 
        ColorMyPencils()
    end
}

