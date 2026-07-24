<h1 align="center">TeVim</h1>

<p align="center">
  A fast, extensible Neovim configuration with a custom UI, sensible defaults,
  built-in LSP support, and a user layer that stays separate from the core.
</p>

<div align="center">

![GitHub top language](https://img.shields.io/github/languages/top/sownteedev/TeVim?color=6d92bf&style=for-the-badge&labelColor=111418)
![Last Commit](https://img.shields.io/github/last-commit/sownteedev/TeVim?style=for-the-badge&color=da696f&logoColor=D9E0EE&labelColor=111418)
![GitHub code size](https://img.shields.io/github/languages/code-size/sownteedev/TeVim?color=e1b56a&style=for-the-badge&labelColor=111418)
![GitHub stars](https://img.shields.io/github/stars/sownteedev/TeVim?color=74be88&style=for-the-badge&labelColor=111418)

</div>

<img src="https://github.com/sownteedev/TeVim/assets/90148193/dda6c61f-10a1-4317-8df2-561e3f961bd2" alt="TeVim dashboard">

## Features

- Fast startup with lazy-loaded plugins.
- Custom dashboard, statusline, bufferline, and theme system.
- LSP support powered by Neovim's native LSP client, nvim-lspconfig, and Mason.
- Completion, snippets, Treesitter highlighting, Git integration, Telescope, and Neo-tree.
- A separate `lua/custom/` layer for personal configuration.
- 16 bundled colorschemes with support for user-created themes.

On the author's machine, a headless startup typically takes approximately 14–20 ms.
Startup time depends on hardware, operating system, and enabled custom plugins.

<details>
<summary><strong>Theme showcase — 16 colorschemes</strong></summary>

| | | | |
| :-: | :-: | :-: | :-: |
| <img src="https://github.com/sownteedev/TeVim/assets/90148193/7b5e73eb-244c-48b0-937a-bd9590ca151c" width="200" alt="TeVim theme 1"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/0dad550e-08f0-4ed3-a0a5-b8ace6e561d2" width="200" alt="TeVim theme 2"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/a3f2a5ab-e17f-4132-9c52-7ea8b0962ab8" width="200" alt="TeVim theme 3"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/ed8f0347-b809-4570-b0d9-6b49e81257d9" width="200" alt="TeVim theme 4"> |
| <img src="https://github.com/sownteedev/TeVim/assets/90148193/a7426bf0-43cd-4eb5-943c-7995b23a5b4b" width="200" alt="TeVim theme 5"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/49100402-f82c-40e3-9197-debdc04a0e54" width="200" alt="TeVim theme 6"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/7ec88e9b-5e40-475c-b765-82cc83571dd5" width="200" alt="TeVim theme 7"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/2148b26a-b799-426b-89ec-5ceda8a1006b" width="200" alt="TeVim theme 8"> |
| <img src="https://github.com/sownteedev/TeVim/assets/90148193/c4fe9259-0714-4247-8c95-9cec37c0c697" width="200" alt="TeVim theme 9"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/073d64fd-f049-43a4-903d-6fde8ab1fbe3" width="200" alt="TeVim theme 10"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/a77bc174-cc25-4610-9c58-32590ad8c577" width="200" alt="TeVim theme 11"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/2ff7f908-51e7-4214-9609-9c4b72da8f90" width="200" alt="TeVim theme 12"> |
| <img src="https://github.com/sownteedev/TeVim/assets/90148193/c9bc8b70-1912-4700-8f8c-928493189805" width="200" alt="TeVim theme 13"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/974c9cec-5479-49a1-9d37-05e82749ac97" width="200" alt="TeVim theme 14"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/eabb7fba-1596-44ec-b93c-98fb2244c911" width="200" alt="TeVim theme 15"> | <img src="https://github.com/sownteedev/TeVim/assets/90148193/f7502d7c-fe4b-4970-899c-d32cd83bec73" width="200" alt="TeVim theme 16"> |

</details>

## Requirements

- Neovim **0.11.3 or newer**. Neovim 0.12 is recommended.
- Git, curl, ripgrep, and a C compiler.
- A [Nerd Font](https://www.nerdfonts.com/) configured in your terminal.
- A clipboard provider: `wl-clipboard` on Wayland, or `xclip`/`xsel` on X11.
- Optional: `lazygit` and `ranger`.

Some Treesitter parsers and native Telescope extensions require a working compiler.
Windows users can use LLVM/Clang or MinGW and must add it to `PATH`.

## Installation

Back up your existing configuration first.

### Linux and macOS

```sh
mv ~/.config/nvim ~/.config/nvim.bak
git clone --depth 1 https://github.com/sownteedev/TeVim ~/.config/nvim
nvim
```

### Windows PowerShell

```powershell
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
git clone --depth 1 https://github.com/sownteedev/TeVim $env:LOCALAPPDATA\nvim
nvim
```

TeVim installs plugins on the first launch and creates `lua/custom/`
automatically. Restart Neovim after the initial installation finishes.

## Core and custom configuration

TeVim separates maintained defaults from user configuration:

```text
lua/
├── tevim/       # TeVim core: UI, defaults, and bundled plugins
└── custom/      # Your plugins, options, keymaps, LSP servers, and themes
```

Do not edit `lua/tevim/` for personal changes. Files in `lua/custom/` are
loaded after the core and can extend or override it without creating conflicts
when TeVim is updated.

### Add a plugin

Add a Lazy plugin specification to `lua/custom/plugins.lua`:

```lua
return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {},
	},
}
```

You can also add another specification with the same repository name to
override a bundled plugin.

### Change an option

Add your changes to `lua/custom/options.lua`:

```lua
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.g.transparency = true
```

### Add a keymap

Add keymaps to `lua/custom/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", {
	desc = "Toggle file explorer",
	silent = true,
})
```

### Add LSP servers and Mason packages

List packages managed by `:TeVimCheckMason` in
`lua/custom/configs/overrides.lua`:

```lua
local M = {}

M.mason = {
	ensure_installed = {
		"typescript-language-server",
		"eslint-lsp",
		"prettier",
	},
}

return M
```

Create `lua/custom/configs/lspconfig.lua`:

```lua
local base = require("tevim.plugins.configs.lspconfig")
local servers = { "ts_ls", "eslint" }

for _, server in ipairs(servers) do
	vim.lsp.config(server, {
		on_attach = base.on_attach,
		capabilities = base.capabilities,
	})
end

vim.lsp.enable(servers)
```

Then extend the bundled LSP plugin in `lua/custom/plugins.lua`:

```lua
return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("tevim.plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
}
```

Run `:TeVimCheckMason` after changing the package list.

### Add a colorscheme

Copy one of the palette files from `lua/tevim/themes/schemes/` to
`lua/custom/themes/schemes/mytheme.lua`, change its colors, and select it in
`lua/custom/options.lua`:

```lua
vim.g.TeVimTheme = "mytheme"
```

Custom highlight overrides belong in `lua/custom/themes/integrations.lua`.

## Commands

| Command | Description |
| --- | --- |
| `:TeVimThemes` | Open the colorscheme picker |
| `:TeVimToggleTrans` | Toggle background transparency |
| `:TeVimCheckMason` | Synchronize packages listed in `custom/configs/overrides.lua` |
| `:TeVimUpdate` | Update TeVim |
| `:Mason` | Open the Mason package manager |
| `:Lazy` | Open the Lazy plugin manager |

## Keymaps

The leader key is <kbd>Space</kbd>. Use `:Telescope keymaps` to browse the
complete list.

| Key | Action |
| --- | --- |
| <kbd>Ctrl</kbd>+<kbd>E</kbd> | Toggle Neo-tree |
| <kbd>Ctrl</kbd>+<kbd>`</kbd> | Toggle the terminal |
| <kbd>Ctrl</kbd>+<kbd>S</kbd> | Save the current file |
| <kbd>Ctrl</kbd>+<kbd>/</kbd> | Toggle comments |
| <kbd>Leader</kbd> <kbd>f</kbd> <kbd>f</kbd> | Find files |
| <kbd>Leader</kbd> <kbd>f</kbd> <kbd>w</kbd> | Search text |
| <kbd>Leader</kbd> <kbd>l</kbd> <kbd>a</kbd> | LSP code action |
| <kbd>Leader</kbd> <kbd>l</kbd> <kbd>r</kbd> | LSP rename |
| <kbd>Leader</kbd> <kbd>l</kbd> <kbd>I</kbd> | LSP information |
| <kbd>Leader</kbd> <kbd>s</kbd> <kbd>i</kbd> | Treesitter module information |
| <kbd>Leader</kbd> <kbd>s</kbd> <kbd>u</kbd> | Update Treesitter parsers |
| <kbd>Leader</kbd> <kbd>Leader</kbd> <kbd>c</kbd> | Open the theme picker |
| <kbd>Leader</kbd> <kbd>Leader</kbd> <kbd>m</kbd> | Synchronize Mason packages |

## Main plugins

| Plugin | Purpose |
| --- | --- |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager and lazy-loading |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Parsers, queries, and syntax highlighting |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP server configurations |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | External development-tool manager |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [Telescope](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder and picker interface |
| [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer |
| [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) | Git changes and hunk actions |
| [ToggleTerm](https://github.com/akinsho/toggleterm.nvim) | Terminal integration |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keymap discovery |

## Troubleshooting

- Run `:checkhealth` to inspect Neovim, LSP, Treesitter, and provider health.
- Run `:Lazy sync` if a plugin is missing or out of date.
- Run `:Mason` to inspect external tools.
- Run `:LspInfo` after opening a source file to inspect attached LSP clients.
- When reporting an issue, include your Neovim version and relevant
  `:checkhealth` output.

> TeVim is an opinionated configuration intended for users who are comfortable
> with Lua and Neovim. If you encounter a problem, please
> [open an issue](https://github.com/sownteedev/TeVim/issues).

<details>
<summary><strong>Credits</strong></summary>

- [NvChad](https://github.com/NvChad) inspired parts of TeDash and TeBufline.

</details>
