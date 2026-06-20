local lush = require("lush")

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
return theme
