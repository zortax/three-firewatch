-- Copyright: The authors of https://github.com/folke/tokyonight.nvim

local util = require("three-firewatch.util")
local theme = require("three-firewatch.theme")
local config = require("three-firewatch.config")

local M = {}

function M._load(style)
	if style and not M._style then
		M._style = require("three-firewatch.config").options.style
	end
	if not style and M._style then
		require("three-firewatch.config").options.style = M._style
		M._style = nil
	end
	M.load({ style = style, use_background = style == nil })
end

function M.load(opts)
	if opts then
		require("three-firewatch.config").extend(opts)
	end
	util.load(theme.setup())
end

M.setup = config.setup

M.colorscheme = M.load

return M
