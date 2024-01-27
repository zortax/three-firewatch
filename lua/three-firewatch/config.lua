-- Copyright: The authors of https://github.com/folke/tokyonight.nvim

local M = {}

local defaults = {
	style = "",
	light_style = "day",
	transparent = false,
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		sidebars = "dark",
		floats = "dark",
	},
	sidebars = { "qf", "help" },
	day_brightness = 0.3,
	hide_inactive_statusline = false,
	dim_inactive = false,
	lualine_bold = false,
	on_colors = function(colors) end,
	on_highlights = function(highlights, colors) end,
	use_background = true,
}

M.options = {}

function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})
end

function M.extend(opts)
	M.options = vim.tbl_deep_extend("force", {}, M.options or defaults, opts or {})
end

function M.is_day()
	return M.options.style == "day" or M.options.use_background and vim.o.background == "light"
end

M.setup()

return M
