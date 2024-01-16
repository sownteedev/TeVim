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
	rainbow = { enable = true },
	indent = { enable = true },
	autotag = { enable = true },
	autopairs = { enable = true },
	ensure_installed = { "lua" },
	auto_install = true,
	sync_install = false,
})
