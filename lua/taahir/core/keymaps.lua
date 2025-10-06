vim.g.mapleader = " "

local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<C-S-l>", "5<C-w>>") -- increase window width
keymap.set("n", "<C-S-h>", "5<C-w><") -- decrease window width
keymap.set("n", "<C-S-k>", "5<C-w>+") -- increase window height
keymap.set("n", "<C-S-j>", "5<C-w>-") -- decrease window height

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- moving lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor on same line with J
keymap.set("n", "J", "mzJ`z")

-- scroll half page with cursor in page center
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- scroll with cursor in place
-- keymap.set("n", "<C-e>", "j<C-e>")
-- keymap.set("n", "<C-y>", "k<C-y>")

-- horizontal scrolling
keymap.set("n", "<leader>l", "20zl") --  20 chars right
keymap.set("n", "<leader>h", "20zh") -- 20 chars left

-- blackhole paste
keymap.set("x", "<leader>p", [["_dP]])

-- center screen on search
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- yank to clipboard register
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

-- buffers
keymap.set("n", "[b", ":bp<CR>")
keymap.set("n", "]b", ":bn<CR>")

-- search under cursor
keymap.set("n", "<leader>/", "yiwq/p<cr>") -- this is the same as pressing * (or see telescope grep_string)

----------------------
-- Plugin Keybinds
----------------------

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>zz") -- toggle file explorer
keymap.set("n", "<leader>E", ":NvimTreeFindFile<CR>zz") -- toggle file explorer

-- telescope (see :help telescope.builtin)
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>") -- resume previous search
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>R", "<cmd>Telescope lsp_references<cr>") -- find references under cursor

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]
keymap.set("n", "<leader>gh", "<cmd>Telescope git_file_history<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
keymap.set("n", "zR", require("ufo").openAllFolds)
keymap.set("n", "zM", require("ufo").closeAllFolds)

-- list sessions
-- keymap.set("n", "<leader>ls", require("auto-session.session-lens").search_session, {
-- 	noremap = true,
-- })

-- prompt for a refactor to apply when the remap is triggered
keymap.set({ "n", "x" }, "<leader>rr", function()
	require("telescope").extensions.refactoring.refactors()
end) -- Note that not all refactor support both normal and visual mode

-- lazygit
keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>")
