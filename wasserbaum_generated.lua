local colors = {
	-- content here will not be touched
	-- PATCH_OPEN
	Normal = { fg = "#033016", bg = "#F0F0F0" },
	Comment = { fg = "#3779B3" },
	CursorLine = { bg = "#D4D4D4" },
	CursorColumn = { link = "CursorLine" },
	CursorLineNr = { fg = "#279155", italic = true },
	ErrorMsg = { fg = "#FF0000" },
	Function = { fg = "#085191" },
	Keyword = { fg = "#BD001C" },
	LineNr = { fg = "#3779B3", italic = true },
	LineNrAbove = { link = "LineNr" },
	LineNrBelow = { link = "LineNr" },
	OkMsg = { fg = "#009963" },
	String = { fg = "#00753B" },
	Visual = { fg = "#F0F0F0", bg = "#033016" },
	WarningMsg = { fg = "#9B5A22" },
	-- PATCH_CLOSE
	-- content here will not be touched
}

-- colorschemes generally want to do this
vim.cmd("highlight clear")
vim.cmd("set t_Co=256")
vim.cmd("let g:colors_name='my_theme'")

-- apply highlight groups
for group, attrs in pairs(colors) do
	vim.api.nvim_set_hl(0, group, attrs)
end
