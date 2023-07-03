require("JoshuaSaputil.plugins-setup")
require("JoshuaSaputil.core.options")
require("JoshuaSaputil.core.colorscheme")
require("JoshuaSaputil.core.keymaps")
require("JoshuaSaputil.core.shell")
require("JoshuaSaputil.plugins.surround")
require("JoshuaSaputil.plugins.comment")
require("JoshuaSaputil.plugins.neo-tree")
require("JoshuaSaputil.plugins.lualine")
require("JoshuaSaputil.plugins.telescope")
require("JoshuaSaputil.plugins.lsp.mason")
require("JoshuaSaputil.plugins.nvim-cmp")
require("JoshuaSaputil.plugins.lsp.lspsaga")
require("JoshuaSaputil.plugins.lsp.lspconfig")
require("JoshuaSaputil.plugins.lsp.null-ls")
require("JoshuaSaputil.plugins.autopairs")
require("JoshuaSaputil.plugins.treesitter")
require("JoshuaSaputil.plugins.gitsigns")
require("JoshuaSaputil.plugins.bufferline")
require("JoshuaSaputil.plugins.indent-blankline")
require("JoshuaSaputil.plugins.which-key")
require("JoshuaSaputil.plugins.noice")
require("JoshuaSaputil.plugins.nvim-colorizer")

local has = vim.fn.has
local is_mac = has("macunix")
local is_win = has("win32")
local is_wsl = has("wsl")

if is_mac == 1 then
	require("JoshuaSaputil.core.macos")
end
if is_win == 1 then
	require("JoshuaSaputil.core.windows")
end
if is_wsl == 1 then
	require("JoshuaSaputil.core.wsl")
end
