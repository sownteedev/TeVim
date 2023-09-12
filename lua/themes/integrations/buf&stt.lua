return function(colors)
	return {
		-- Buffer
		BufferLineFill = { fg = colors.grey, bg = colors.black },
		BufferLineBackground = { fg = colors.grey, bg = colors.black },

		BufferLineBuffer = { fg = colors.grey, bg = colors.black },
		BufferLineBufferSelected = { fg = colors.white, bg = colors.black, italic = true, bold = true },
		BufferLineBufferVisible = { fg = colors.grey, bg = colors.black },
		BufferLineBufferInactive = { fg = colors.grey, bg = colors.black },

		BufferLineModified = { fg = colors.green },
		BufferLineModifiedSelected = { fg = colors.green },
		BufferLineModifiedVisible = { fg = colors.green },
		BufferLineModifiedInactive = { fg = colors.green },

		BufferLineCloseButton = { fg = colors.grey },
		BufferLineCloseButtonSelected = { fg = colors.red },
		BufferLineCloseButtonVisible = { fg = colors.grey },
		BufferLineCloseButtonInactive = { fg = colors.grey },

		BufferLineTabClose = { fg = colors.grey, bg = colors.black },
		BufferLineTabCloseSelected = { fg = colors.red, bg = colors.black },
		BufferLineTabCloseVisible = { fg = colors.grey, bg = colors.black },
		BufferLineTabCloseInactive = { fg = colors.grey, bg = colors.black },

		BufferLineTab = { fg = colors.grey },
		BufferLineTabSelected = { fg = colors.grey },
		BufferLineTabVisible = { fg = colors.grey },
		BufferLineTabInactive = { fg = colors.grey },

		BufferLineSeparator = { fg = colors.black },
		BufferLineSeparatorSelected = { fg = colors.black },
		BufferLineSeparatorVisible = { fg = colors.black },
		BufferLineSeparatorInactive = { fg = colors.black },

		BufferLineIndicator = { fg = colors.grey },
		BufferLineIndicatorSelected = { fg = colors.cyan },
		BufferLineIndicatorVisible = { fg = colors.grey },
		BufferLineIndicatorInactive = { fg = colors.grey },

		BufferLinePick = { fg = colors.grey, bg = colors.black },
		BufferLinePickVisible = { fg = colors.grey, bg = colors.black },
		BufferLinePickSelected = { fg = colors.grey, bg = colors.black },
		BufferLinePickInactive = { fg = colors.grey, bg = colors.black },

		BufferLineClose = { fg = colors.grey, bg = colors.black },
		BufferLineCloseVisible = { fg = colors.grey, bg = colors.black },
		BufferLineCloseSelected = { fg = colors.red },
		BufferLineCloseInactive = { fg = colors.grey, bg = colors.black },

		BufferLineNumbers = { fg = colors.grey, bg = colors.black },
		BufferLineNumbersSelected = { bg = colors.black, italic = true, bold = true },
		BufferLineNumbersVisible = { fg = colors.grey, bg = colors.black },

		BufferLineDevIconLua = { fg = colors.grey, bg = colors.black },
		BufferLineDevIconLuaInactive = { fg = colors.grey, bg = colors.black },
		BufferLineDevIconLuaSelected = { fg = colors.blue, bg = colors.black },

		BufferLineTruncMarker = { fg = colors.grey, bg = colors.darker_black },

		-- Statusline
		StatusLine = { bg = colors.black },
		StatusLineNC = { bg = colors.black },
	}
end
