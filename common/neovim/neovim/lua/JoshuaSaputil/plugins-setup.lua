local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
	return
end

lazy.setup({
	"folke/tokyonight.nvim",

	-- Essential plugins
	"ur4ltz/surround.nvim",
	"numToStr/Comment.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"folke/which-key.nvim",
	--"folke/noice.nvim",

	-- Plugin dependencies
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim", -- UI Component
	"nvim-tree/nvim-web-devicons", -- Icons
	"sharkdp/fd",
	"BurntSushi/ripgrep",

	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{ "<leader>e", "<cmd>NeoTreeShowToggle<cr>", desc = "NeoTree" },
		},
	},

	-- Statusline
	"nvim-lualine/lualine.nvim",

	-- Fuzzy finder
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },

	-- Configuring LSP Servers
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-nvim-lsp", -- for autocompletion
	{ "glepnir/lspsaga.nvim", branch = "main" }, -- enhanced lsp uis
	"onsails/lspkind.nvim", -- vs-code like icons for autocompletion

	-- Snippets
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",

	-- LSP Server Package Manager
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim", -- API to neovim lsp

	-- Formatting & linting
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},
	-- Autopairs
	"windwp/nvim-autopairs",

	-- GIT integration
	"lewis6991/gitsigns.nvim",

	-- Bufferline
	"akinsho/bufferline.nvim",

	-- Hex colors
	"NvChad/nvim-colorizer.lua",
})
