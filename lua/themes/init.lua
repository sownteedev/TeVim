local highlights = require('themes.highlights')
local function setup(opts)
	local colors = require('themes.schemes.' .. opts.theme).get_colors()
	highlights.highlight_all(colors, opts)
end

return { setup = setup }
