local lush = require("lush")

local o = vim.o
local g = vim.g
local api = vim.api

vim.cmd("hi clear")

if g.syntax_on == 1 then
	vim.cmd("syntax reset")
end

o.background = "light"
g.colors_name = "grey"

local background = "#f2f2f2"
local grey_bg_light = "#ececec"
local black = "#000000"
local blue = "#1561b8"
local green = "#1C5708"
local light_green = "#dfeacc"
local light_red = "#f2d3cd"
local red = "#c4331d"
local grey = "#5e5e5e"
local light_grey = "#e6e6e6"
local border = "#cccccc"
local highlight = "#eeeeee"
local dark_yellow = "#b37f02"
local yellow = "#f9db70"
local light_yellow = "#f9eab3"
local orange = "#a55000"
local purple = "#5c21a5"
local white = "#ffffff"
local cyan = "#007872"

-- Instead of RGB where you specify red, green and blue components, HSL uses:
--
-- Hue        (0 - 360) (each value is a angle around the color wheel)
-- Saturation (0 - 100) (0 is gray, 100 is colored)
-- Lightness  (0 - 100) (0 is black, 100 is white)
-- Note: Converting between colorspaces can introduce minor color differences
--       due to floating point maths. You may prefer to manually adjust your
--       colors "by eye" afterwards.

-- ###
-- ### HSL operations
-- ###
--
-- Lush.hsl (and hsluv) provides a number of convenience functions for:
--
--   Relative adjustment (rotate(), saturate(), desaturate(), lighten(), darken())
--   Absolute adjustment (prefix above with abs_)
--   Combination         (mix())
--   Overrides           (hue(), saturation(), lightness())
--   Access              (.h, .s, .l)
--   Coercion            (tostring(), "Concatination: " .. color)
--   Helpers             (readable())
--
--   Adjustment functions have shortcut aliases, ro, sa, de, li, da
--                                               abs_sa, abs_de, abs_li, abs_da
--
-- Because HSL colors are represented by degrees around a colorwheel, we can find
-- harmonious colors from our original set by rotating the hue:

local hsl = lush.hsl -- We'll use hsl a lot so its nice to bind it separately
local water = hsl(208, 100, 80) -- Vim has a mapping, <n>C-a and <n>C-x to
local water_deep = hsl(208, 90, 30) -- increment or decrement integers, or
local water_abyss = hsl(146, 90, 10) -- you can just type them normally.
local sea_gull = hsl("#efefef")

local leaf = hsl(150, 100, 30)
local wood = hsl(351, 100, 37)

g.terminal_color_0 = black
g.terminal_color_1 = red
g.terminal_color_2 = green
g.terminal_color_3 = dark_yellow
g.terminal_color_4 = blue
g.terminal_color_5 = purple
g.terminal_color_6 = cyan
g.terminal_color_7 = white

g.terminal_color_8 = black
g.terminal_color_9 = red
g.terminal_color_10 = green
g.terminal_color_11 = dark_yellow
g.terminal_color_12 = blue
g.terminal_color_13 = purple
g.terminal_color_14 = cyan
g.terminal_color_15 = white

local base = {
	-- This highlight group can be used when one wants to disable a highlight
	-- group using `winhl`
	Disabled = {},
	-- These highlight groups can be used for statuslines, for example when
	-- displaying ALE warnings and errors.
	BlackOnLightYellow = { fg = black, bg = light_yellow },
	LightRedBackground = { bg = light_red },
	WhiteOnBlue = { fg = white, bg = blue },
	WhiteOnOrange = { fg = white, bg = orange },
	WhiteOnRed = { fg = white, bg = red },
	WhiteOnYellow = { fg = white, bg = dark_yellow },
	Yellow = { fg = dark_yellow, bold = true },
	Bold = { fg = black, bold = true },
	Boolean = { link = "Keyword" },
	Character = { link = "String" },
	ColorColumn = { bg = highlight },
	Comment = { fg = grey },
	Conceal = {},
	Constant = { fg = black },
	Cursor = { bg = black },
	-- This is to work around https://github.com/neovim/neovim/issues/9800.
	CursorLine = { ctermfg = "black" },
	CursorLineNr = { fg = black, bold = true },
	Directory = { fg = purple },
	EndOfBuffer = { fg = background, bg = background },
	Error = { link = "ErrorMsg" },
	ErrorMsg = { fg = red, bold = true },
	FoldColumn = { link = "Comment" },
	Folded = { link = "Comment" },
	Identifier = { fg = black },
	Function = { fg = black },
	IncSearch = { link = "Search" },
	CurSearch = { link = "Search" },
	Include = { fg = black, bold = true },
	InstanceVariable = { fg = purple },
	Keyword = { fg = black, bold = true },
	Label = { link = "Keyword" },
	LineNr = { fg = grey },
	Macro = { fg = orange },
	MatchParen = { bold = true },
	MoreMsg = { fg = black },
	ModeMsg = { fg = black, bold = true },
	MsgSeparator = { fg = border },
	NonText = { fg = grey },
	Normal = { fg = black, bg = background },
	NormalFloat = { fg = black },
	FloatTitle = { fg = black, bold = true },
	FloatBorder = { fg = border },
	Number = { fg = blue },
	Operator = { fg = black },
	Pmenu = { fg = black, bg = grey_bg_light },
	PmenuSbar = { bg = grey_bg_light },
	PmenuSel = { bg = light_grey, bold = true },
	PmenuThumb = { bg = light_grey },
	PmenuMatch = { fg = dark_yellow, bold = true },
	PreCondit = { link = "Macro" },
	PreProc = { fg = black },
	Question = { fg = black },
	QuickFixLine = { bg = highlight, bold = true },
	Regexp = { fg = orange },
	Search = { bg = light_yellow },
	SignColumn = { link = "FoldColumn" },
	Special = { fg = black },
	SpecialKey = { link = "Number" },
	SpellBad = { sp = red, underline = true },
	SpellCap = { sp = dark_yellow, underline = true },
	SpellLocal = { sp = blue, underline = true },
	SpellRare = { sp = purple, underline = true },
	Statement = { link = "Keyword" },
	StatusLine = { fg = black, bg = background },
	StatusLineNC = { fg = black, bg = grey_bg_light },
	StatusLineTab = { fg = black, bg = background, bold = true },
	WinBar = { fg = black, bold = true },
	WinBarNc = { fg = black, bold = true },
	WinBarFill = { fg = border },
	StorageClass = { link = "Keyword" },
	String = { fg = green },
	SnippetTabstop = {},
	Symbol = { fg = orange },
	TabLine = { fg = black, bg = light_grey },
	TabLineFill = { fg = black, bg = light_grey },
	TabLineSel = { fg = black, bg = background, bold = true },
	Title = { fg = black, bold = true },
	Todo = { fg = grey, bold = true },
	Type = { link = "Constant" },
	Underlined = { underline = true },
	VertSplit = { fg = border },
	WinSeparator = { fg = border },
	Visual = { bg = light_grey },
	WarningMsg = { fg = dark_yellow, bold = true },
	Whitespace = { fg = border },
	WildMenu = { link = "PmenuSel" },
	-- ALE
	ALEError = { fg = red, bold = true },
	ALEErrorSign = { fg = red, bold = true },
	ALEWarning = { fg = dark_yellow, bold = true },
	ALEWarningSign = { fg = dark_yellow, bold = true },
	-- ccc.nvim
	CccFloatNormal = { link = "NormalFloat" },
	CccFloatBorder = { link = "FloatBorder" },
	-- CSS
	cssClassName = { link = "Keyword" },
	cssColor = { link = "Number" },
	cssIdentifier = { link = "Keyword" },
	cssImportant = { link = "Keyword" },
	cssProp = { link = "Identifier" },
	cssTagName = { link = "Keyword" },
	cssCustomProp = { fg = purple },
	cssPseudoClass = { fg = orange, bold = true },
	cssPseudoClassId = { link = "cssPseudoClass" },
	["@tag.css"] = { link = "cssIdentifier" },
	["@type.css"] = { link = "cssClassName" },
	["@variable.css"] = { link = "cssCustomProp" },
	["@constant.css"] = { link = "cssTagName" },
	-- Diffs
	DiffAdd = { bg = light_green },
	DiffChange = { bg = highlight },
	DiffDelete = { fg = red },
	DiffText = { bg = light_yellow },
	diffAdded = { link = "DiffAdd" },
	diffChanged = { link = "DiffChange" },
	diffFile = { fg = black, bold = true },
	diffLine = { fg = blue },
	diffRemoved = { link = "DiffDelete" },
	-- Dot/Graphviz
	dotKeyChar = { link = "Operator" },
	-- diffview.nvim
	DiffviewCursorLine = { bold = true, bg = light_grey },
	DiffviewDiffAddAsDelete = { bg = light_red },
	DiffviewDiffDelete = { fg = light_grey },
	DiffviewDiffDeleteDim = { fg = light_grey },
	DiffviewFilePanelFileName = { fg = black },
	DiffviewFilePanelPath = { fg = purple },
	DiffviewFilePanelRootPath = { fg = purple },
	DiffviewFilePanelTitle = { fg = black, bold = true },
	DiffviewFilePanelInsertions = { fg = green },
	DiffviewFilePanelDeletions = { fg = red },
	DiffviewStatusModified = { fg = dark_yellow, bold = true },
	DiffviewStatusAdded = { fg = green, bold = true },
	DiffviewStatusCopied = { fg = green, bold = true },
	DiffviewStatusDeleted = { fg = red, bold = true },
	-- Eyeliner
	EyelinerPrimary = { fg = red, bold = true },
	EyelinerSecondary = { fg = dark_yellow, bold = true },
	EyelinerDimmed = { link = "Comment" },
	-- Flash
	FlashBackdrop = { link = "None" },
	FlashLabel = { fg = black, bold = true, bg = yellow },
	FlashPromptIcon = { bold = true },
	-- Fugitive
	FugitiveblameHash = { fg = purple },
	FugitiveblameTime = { fg = blue },
	gitCommitOverflow = { link = "ErrorMsg" },
	gitCommitSummary = { link = "String" },
	-- gitcommit
	["@string.special.url.gitcommit"] = { fg = black },
	["@markup.link.gitcommit"] = { fg = green, bold = true },
	["@comment.warning.gitcommit"] = { fg = red, bold = true },
	-- Gitsigns
	GitSignsAdd = { fg = border },
	GitSignsDelete = { fg = border },
	GitSignsChange = { fg = border },
	GitSignsStagedAdd = { fg = grey },
	GitSignsStagedDelete = { fg = grey },
	GitSignsStagedChange = { fg = grey },
	-- HAML
	hamlClass = { fg = black },
	hamlDocType = { link = "Comment" },
	hamlId = { fg = black },
	hamlTag = { fg = black, bold = true },
	-- hop.nvim
	HopNextKey = { fg = black, bold = true, bg = yellow },
	HopNextKey1 = { bg = light_yellow },
	HopNextKey2 = { bg = light_yellow },
	HopUnmatched = {},
	-- HTML
	htmlArg = { link = "Identifier" },
	htmlLink = { link = "Directory" },
	htmlScriptTag = { link = "htmlTag" },
	htmlSpecialTagName = { link = "htmlTag" },
	htmlTag = { fg = black, bold = true },
	htmlTagName = { link = "htmlTag" },
	htmlItalic = { italic = true },
	htmlBold = { bold = true },
	-- Inko
	inkoCommentBold = { fg = grey, bold = true },
	inkoCommentInlineUrl = { link = "Number" },
	inkoCommentItalic = { fg = grey, italic = true },
	inkoCommentTitle = { fg = grey, bold = true },
	inkoInstanceVariable = { link = "InstanceVariable" },
	inkoKeywordArgument = { link = "Regexp" },
	["@variable.member.inko"] = { link = "InstanceVariable" },
	["@constant.builtin.inko"] = { link = "Keyword" },
	-- Java
	javaAnnotation = { link = "Directory" },
	javaCommentTitle = { link = "javaComment" },
	javaDocParam = { link = "Todo" },
	javaDocTags = { link = "Todo" },
	javaExternal = { link = "Keyword" },
	javaStorageClass = { link = "Keyword" },
	-- Javascript
	JavaScriptNumber = { link = "Number" },
	javaScriptBraces = { link = "Operator" },
	javaScriptFunction = { link = "Keyword" },
	javaScriptIdentifier = { link = "Keyword" },
	javaScriptMember = { link = "Identifier" },
	-- JSON
	jsonKeyword = { link = "String" },
	-- Lua
	luaFunction = { link = "Keyword" },
	-- LSP
	DiagnosticUnderlineError = { underline = true, sp = red },
	DiagnosticUnderlineWarn = { underline = true, sp = dark_yellow },
	LspDiagnosticsUnderlineError = { link = "DiagnosticUnderlineError" },
	LspDiagnosticsUnderlineWarning = { link = "DiagnosticUnderlineWarn" },
	LspReferenceTarget = {},
	DiagnosticFloatingError = { fg = red, bold = true },
	DiagnosticFloatingHint = { fg = black, bold = true },
	DiagnosticFloatingInfo = { fg = blue, bold = true },
	DiagnosticFloatingWarn = { fg = dark_yellow, bold = true },
	DiagnosticError = { fg = red, bold = true },
	DiagnosticHint = { fg = grey, bold = true },
	DiagnosticInfo = { fg = blue, bold = true },
	DiagnosticWarn = { fg = dark_yellow, bold = true },
	DiagnosticDeprecated = {},
	-- Make
	makeTarget = { link = "Function" },
	-- Markdown
	markdownCode = { link = "markdownCodeBlock" },
	markdownCodeBlock = { link = "Comment" },
	markdownListMarker = { link = "Keyword" },
	markdownOrderedListMarker = { link = "Keyword" },
	markdownUrl = { fg = blue },
	-- mini.diff
	MiniDiffSignAdd = { fg = border },
	MiniDiffSignDelete = { fg = border },
	MiniDiffSignChange = { fg = border },
	-- mini.icons
	MiniIconsAzure = { fg = blue },
	MiniIconsBlue = { fg = blue },
	MiniIconsCyan = { fg = cyan },
	MiniIconsGreen = { fg = green },
	MiniIconsGrey = { fg = grey },
	MiniIconsOrange = { fg = orange },
	MiniIconsPurple = { fg = purple },
	MiniIconsRed = { fg = red },
	MiniIconsYellow = { fg = dark_yellow },
	-- mini.jump2d
	MiniJump2dSpot = { fg = red, bold = true },
	MiniJump2dSpotAhead = { fg = red, bold = true },
	-- mini.pick
	MiniPickBorder = { fg = border },
	MiniPickBorderBusy = { link = "MiniPickBorder" },
	MiniPickBorderText = { link = "Comment" },
	MiniPickHeader = { fg = black, bold = true },
	MiniPickMatchCurrent = { bg = light_grey, bold = true },
	MiniPickMatchRanges = { fg = dark_yellow, bold = true },
	MiniPickNormal = { fg = black },
	MiniPickPrompt = { fg = black },
	MiniPickMatchMarked = { bold = true },
	-- netrw
	netrwClassify = { link = "Identifier" },
	-- Neogit
	NeogitBranch = { fg = green, bold = true },
	NeogitBranchHead = { link = "NeogitBranch" },
	NeogitCommitViewHeader = { fg = dark_yellow, bold = true },
	NeogitCursorLine = { bg = highlight },
	NeogitDiffAdd = { link = "DiffAdd" },
	NeogitDiffAddHighlight = { link = "NeogitDiffAdd" },
	NeogitDiffContext = { link = "Normal" },
	NeogitDiffContextHighlight = { link = "Normal" },
	NeogitDiffDelete = { link = "DiffDelete" },
	NeogitDiffDeleteHighlight = { link = "NeogitDiffDelete" },
	NeogitDiffHeader = { fg = black, bold = true },
	NeogitDiffHeaderHighlight = { link = "NeogitDiffHeader" },
	NeogitFilePath = { fg = purple },
	NeogitGraphBlue = { fg = blue },
	NeogitGraphBoldBlue = { fg = blue, bold = true },
	NeogitGraphBoldCyan = { fg = cyan, bold = true },
	NeogitGraphBoldGray = { fg = grey, bold = true },
	NeogitGraphBoldGreen = { fg = green, bold = true },
	NeogitGraphBoldOrange = { fg = orange, bold = true },
	NeogitGraphBoldPurple = { fg = purple, bold = true },
	NeogitGraphBoldRed = { fg = red, bold = true },
	NeogitGraphBoldWhite = { fg = black, bold = true },
	NeogitGraphBoldYellow = { fg = dark_yellow, bold = true },
	NeogitGraphCyan = { fg = cyan },
	NeogitGraphGray = { fg = grey },
	NeogitGraphGreen = { fg = green },
	NeogitGraphOrange = { fg = orange },
	NeogitGraphPurple = { fg = purple },
	NeogitGraphRed = { fg = red },
	NeogitGraphWhite = { fg = black },
	NeogitGraphYellow = { fg = dark_yellow },
	NeogitHunkHeader = { fg = blue },
	NeogitHunkHeaderHighlight = { link = "NeogitHunkHeader" },
	NeogitPopupActionKey = { link = "NeogitPopupOptionKey" },
	NeogitPopupBranchName = { link = "NeogitBranch" },
	NeogitPopupConfigEnabled = { link = "NeogitPopupOptionEnabled" },
	NeogitPopupConfigKey = { link = "NeogitPopupOptionKey" },
	NeogitPopupOptionEnabled = { bg = light_green, bold = true },
	NeogitPopupOptionKey = { bold = true },
	NeogitPopupSectionTitle = { link = "Title" },
	NeogitPopupSwitchEnabled = { link = "NeogitPopupOptionEnabled" },
	NeogitPopupSwitchKey = { link = "NeogitPopupOptionKey" },
	NeogitRemote = { link = "NeogitBranch" },
	-- Notify
	NotifyDEBUGBorder = { fg = border },
	NotifyDEBUGIcon = { fg = grey },
	NotifyDEBUGTitle = { fg = grey },
	NotifyERRORBorder = { fg = border },
	NotifyERRORIcon = { fg = red },
	NotifyERRORTitle = { fg = red },
	NotifyINFOBorder = { fg = border },
	NotifyINFOTitle = { fg = green },
	NotifyINFOIcon = { fg = green },
	NotifyTRACEBorder = { fg = border },
	NotifyTRACEIcon = { fg = purple },
	NotifyTRACETitle = { fg = purple },
	NotifyWARNBorder = { fg = border },
	NotifyWARNIcon = { fg = orange },
	NotifyWARNTitle = { fg = orange },
	-- Perl
	perlPackageDecl = { link = "Identifier" },
	perlStatementInclude = { link = "Statement" },
	perlStatementPackage = { link = "Statement" },
	podCmdText = { link = "Todo" },
	podCommand = { link = "Comment" },
	podVerbatimLine = { link = "Todo" },
	-- Ruby
	rubyAttribute = { link = "Identifier" },
	rubyClass = { link = "Keyword" },
	rubyClassVariable = { link = "rubyInstancevariable" },
	rubyConstant = { link = "Constant" },
	rubyDefine = { link = "Keyword" },
	rubyFunction = { link = "Function" },
	rubyInstanceVariable = { link = "InstanceVariable" },
	rubyMacro = { link = "Identifier" },
	rubyModule = { link = "rubyClass" },
	rubyRegexp = { link = "Regexp" },
	rubyRegexpCharClass = { link = "Regexp" },
	rubyRegexpDelimiter = { link = "Regexp" },
	rubyRegexpQuantifier = { link = "Regexp" },
	rubyRegexpSpecial = { link = "Regexp" },
	rubyStringDelimiter = { link = "String" },
	rubySymbol = { link = "Symbol" },
	["@variable.member.ruby"] = { link = "InstanceVariable" },
	["@string.special.symbol.ruby"] = { link = "rubySymbol" },
	-- Rust
	rustCommentBlockDoc = { link = "Comment" },
	rustCommentLineDoc = { link = "Comment" },
	rustFuncCall = { link = "Identifier" },
	rustModPath = { link = "Identifier" },
	["@function.macro.rust"] = { link = "Macro" },
	["@attribute.rust"] = { link = "Identifier" },
	-- pounce.nvim
	PounceAccept = { fg = black, bg = yellow, bold = true },
	PounceAcceptBest = { link = "PounceAccept" },
	PounceMatch = { bg = light_yellow },
	PounceUnmatched = {},
	PounceGap = { link = "None" },
	-- Python
	pythonOperator = { link = "Keyword" },
	-- SASS
	sassClass = { link = "cssClassName" },
	sassId = { link = "cssIdentifier" },
	-- Shell
	shFunctionKey = { link = "Keyword" },
	-- Snacks
	SnacksPickerMatch = { fg = dark_yellow, bold = true },
	SnacksPickerDir = { fg = black },
	SnacksPickerPrompt = { fg = black, bold = true },
	SnacksInputBorder = { link = "FloatBorder" },
	SnacksInputTitle = { link = "Title" },
	SnacksPickerRow = { link = "Number" },
	SnacksPickerCol = { link = "Number" },
	SnacksPickerListCursorLine = { bg = light_grey, bold = true },
	-- Snippy
	SnippyPlaceholder = { link = "SnippetTabstop" },
	-- SQL
	sqlKeyword = { link = "Keyword" },
	-- Typescript
	typescriptBraces = { link = "Operator" },
	typescriptEndColons = { link = "Operator" },
	typescriptExceptions = { link = "Keyword" },
	typescriptFuncKeyword = { link = "Keyword" },
	typescriptFunction = { link = "Function" },
	typescriptIdentifier = { link = "Identifier" },
	typescriptLogicSymbols = { link = "Operator" },
	-- Telescope
	TelescopeBorder = { fg = border },
	TelescopeMatching = { fg = dark_yellow, bold = true },
	TelescopePromptNormal = { fg = black },
	TelescopePromptBorder = { fg = border },
	TelescopePromptPrefix = { fg = black, bold = true },
	TelescopeSelection = { bg = light_grey, bold = true },
	TelescopeTitle = { fg = black, bold = true },
	TelescopeNormal = { fg = black },
	-- Treesitter
	["@markup.link"] = { fg = blue },
	["@property.json"] = { bold = true },
	["@text.emphasis"] = { italic = true },
	["@text.reference"] = { fg = purple },
	["@text.strong"] = { bold = true },
	["@text.uri"] = { fg = blue },
	["@variable.builtin"] = { bold = true },
	["@string.regexp"] = { link = "Regexp" },
	-- Custom Tree-sitter captures added by this theme.
	["@variable.parameter.reference"] = { fg = orange },
	-- Vimscript
	VimCommentTitle = { link = "Todo" },
	VimIsCommand = { link = "Constant" },
	vimGroup = { link = "Constant" },
	vimHiGroup = { link = "Constant" },
	-- XML
	xmlAttrib = { link = "Identifier" },
	xmlTag = { link = "Identifier" },
	xmlTagName = { link = "Identifier" },
	-- YAML
	yamlPlainScalar = { link = "String" },
	-- YARD
	yardComment = { link = "Comment" },
	yardType = { link = "Todo" },
	yardTypeList = { link = "Todo" },
}

---@diagnostic disable: undefined-global
local theme = lush(function()
	return {
		-- Vim internals
		Normal({ bg = sea_gull, fg = water_abyss }), -- Goodbye gray, hello blue!
		CursorLine({ bg = Normal.bg.darken(12) }), -- lighten() can also be called via li()
		Visual({ fg = Normal.bg, bg = Normal.fg }), -- Try pressing v and selecting some text
		Comment({ fg = water.de(47).da(43) }),
		Keyword({ fg = wood }),
		String({ fg = leaf.sa(49).da(25) }),
		Function({ fg = water_deep }),
		CursorColumn({ CursorLine }),
		OkMsg({ fg = hsl(159, 100, 30) }),
		WarningMsg({ fg = hsl(28, 64, 37) }),
		ErrorMsg({ fg = hsl(0, 100, 50) }),
		LineNr({ Comment, gui = "italic" }),
		LineNrBelow({ LineNr }),
		LineNrAbove({ LineNr }),
		CursorLineNr({ LineNr, fg = CursorLine.bg.mix(Normal.fg, 64) }),
	}
end)

local norm_lush_theme = {}

for k, v in pairs(theme) do
	print("K:", k)
	print("V:", v)
	local t = {}
	for kk, vv in pairs(v) do
		print("KKKK:", kk)
		print("VVVV:", vv)
		t[tostring(kk)] = tostring(vv)
	end
	norm_lush_theme[tostring(k)] = t
end

print("111111111")
print(vim.inspect(base))
print(vim.inspect(theme))
print(vim.inspect(norm_lush_theme))
for k, v in pairs(norm_lush_theme) do
	base[k] = v
end

return base
