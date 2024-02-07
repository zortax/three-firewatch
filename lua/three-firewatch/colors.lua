-- Copyright: The authors of https://github.com/folke/tokyonight.nvim

local util = require("three-firewatch.util")

local M = {}

---@class Palette
M.default = {
	none = "NONE",
	bg_dark = "#22252c",
	bg = "#282C34",
	bg_highlight = "#2c323c",
	bg_visual = "#3e4452",
	terminal_black = "#414868",
	fg = "#abb2bf",
	fg_dark = "#819fc2",
	fg_gutter = "#55606d",
	dark3 = "#545c7e",
	comment = "#55606d",
	dark5 = "#737aa2",
	blue0 = "#3d59a1",
	blue = "#819fc2",
	cyan = "#56b6c2",
	blue1 = "#91aac6",
	blue2 = "#9ec4ef",
	blue5 = "#819fc2",
	blue6 = "#6e88a6",
	blue7 = "#394b70",
	magenta = "#c17a7b",
	magenta2 = "#ff007c",
	purple = "#7878d4",
	orange = "#ff9e64",
	yellow = "#c8ae9d",
	green = "#98c379",
	green1 = "#73daca",
	green2 = "#41a6b5",
	teal = "#5e9e73",
	red = "#d86971",
	red1 = "#db4b4b",
	git = { change = "#819fc2", add = "#508f81", delete = "#b2555b" },
	gitSigns = {
		add = "#508f81",
		change = "#819fc2",
		delete = "#b2555b",
	},
}

M.night = {
	bg = "#1a1b26",
	bg_dark = "#16161e",
}
M.day = M.night

M.moon = function()
	local ret = {
		none = "NONE",
		bg_dark = "#1e2030", --
		bg = "#222436", --
		bg_highlight = "#2f334d", --
		terminal_black = "#444a73", --
		fg = "#c8d3f5", --
		fg_dark = "#828bb8", --
		fg_gutter = "#3b4261",
		dark3 = "#545c7e",
		comment = "#7a88cf", --
		dark5 = "#737aa2",
		blue0 = "#3e68d7", --
		blue = "#82aaff", --
		cyan = "#86e1fc", --
		blue1 = "#65bcff", --
		blue2 = "#0db9d7",
		blue5 = "#89ddff",
		blue6 = "#b4f9f8", --
		blue7 = "#394b70",
		purple = "#fca7ea", --
		magenta2 = "#ff007c",
		magenta = "#c099ff", --
		orange = "#ff966c", --
		yellow = "#ffc777", --
		green = "#98c379", --
		green1 = "#4fd6be", --
		green2 = "#41a6b5",
		teal = "#4fd6be", --
		red = "#ff757f", --
		red1 = "#c53b53", --
	}
	ret.comment = util.blend(ret.comment, ret.bg, "bb")
	ret.git = {
		change = util.blend(ret.blue, ret.bg, "ee"),
		add = util.blend(ret.green, ret.bg, "ee"),
		delete = util.blend(ret.red, ret.bg, "dd"),
	}
	ret.gitSigns = {
		change = util.blend(ret.blue, ret.bg, "66"),
		add = util.blend(ret.green, ret.bg, "66"),
		delete = util.blend(ret.red, ret.bg, "aa"),
	}
	return ret
end

---@return ColorScheme
function M.setup(opts)
	opts = opts or {}
	local config = require("three-firewatch.config")

	local style = config.is_day() and config.options.light_style or config.options.style
	local palette = M[style] or {}
	if type(palette) == "function" then
		palette = palette()
	end

	-- Color Palette
	---@class ColorScheme: Palette
	local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

	util.bg = colors.bg
	util.day_brightness = config.options.day_brightness

	colors.diff = {
		add = util.darken(colors.green2, 0.15),
		delete = util.darken(colors.red1, 0.15),
		change = util.darken(colors.blue7, 0.15),
		text = colors.blue7,
	}

	colors.git.ignore = colors.dark3
	colors.black = util.darken(colors.bg, 0.8, "#000000")
	colors.border_highlight = util.darken(colors.blue1, 0.8)
	colors.border = colors.black

	-- Popups and statusline always get a dark background
	colors.bg_popup = colors.bg_dark
	colors.bg_statusline = colors.bg_dark

	-- Sidebar and Floats are configurable
	colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
		or config.options.styles.sidebars == "dark" and colors.bg_dark
		or colors.bg

	colors.bg_float = config.options.styles.floats == "transparent" and colors.none
		or config.options.styles.floats == "dark" and colors.bg_dark
		or colors.bg

	colors.bg_search = colors.blue0
	colors.fg_sidebar = colors.fg
	-- colors.fg_float = config.options.styles.floats == "dark" and colors.fg_dark or colors.fg
	colors.fg_float = colors.fg

	colors.error = colors.red1
	colors.todo = colors.blue
	colors.warning = colors.yellow
	colors.info = colors.blue2
	colors.hint = colors.teal

	colors.delta = {
		add = util.darken(colors.green2, 0.45),
		delete = util.darken(colors.red1, 0.45),
	}

	config.options.on_colors(colors)
	if opts.transform and config.is_day() then
		util.invert_colors(colors)
	end

	return colors
end

return M
