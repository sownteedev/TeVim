local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

require("nvim-treesitter.install").compilers = { "clang" }

treesitter.setup({
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},
	rainbow = { enable = true },
	indent = { enable = true },
	autotag = { enable = true },
	autopairs = { enable = true },
	auto_install = true,
	sync_install = false,
})
