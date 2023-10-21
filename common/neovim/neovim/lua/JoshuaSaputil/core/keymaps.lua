vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

-- Mode selection keymaps
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "x", '"_x')
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- Window keymaps
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertical
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontal
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- Tab keymaps
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- previous tab

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-w>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-x>", ":close<CR>")

-- Terminal
keymap.set("n", "<leader>st", "<cmd>split | te<cr>")

-- Buffers
keymap.set("n", "<leader>c", "<cmd>bd!<cr>")

--------------------
-- PLUGIN KEYMAPS --
--------------------

-- neotree
keymap.set("n", "<leader>e", ":Neotree toggle<CR>")
keymap.set("n", "<leader>fl", ":Neotree float<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- Bufferline
keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<cr>")
keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<cr>")
