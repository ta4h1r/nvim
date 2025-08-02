-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme

	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	use("szw/vim-maximizer") -- maximizes and restores current window

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	use("numToStr/Comment.nvim")

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- vs-code like icons
	use("nvim-tree/nvim-web-devicons")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x", -- fuzzy finder
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use({
		"mason-org/mason.nvim",
		branch = "v1.x",
	}) -- in charge of managing lsp servers, linters & formatters
	use("mason-org/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}) -- enhanced lsp uis
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- undotree
	use("mbbill/undotree")

	-- harpoon
	use("theprimeagen/harpoon")

	-- debugger
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })
	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	})
	use({ "mfussenegger/nvim-jdtls", requires = { "mfussenegger/nvim-dap" } })

	-- tsx comments
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- folding
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

	-- refactoring
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- session manageer
	use("rmagatti/auto-session")

	-- tabs line
	-- These optional plugins should be loaded directly because of a bug in Packer lazy loading
	-- use("nvim-tree/nvim-web-devicons") -- OPTIONAL: for file icon
	-- use("lewis6991/gitsigns.nvim") -- OPTIONAL: for git status
	use("romgrk/barbar.nvim")

	-- diff view
	use("sindrets/diffview.nvim")

	-- lazygit
	use({
		"kdheepak/lazygit.nvim",
		commit = "2432b447483f42ff2e18b2d392cb2bb27e495c08",
		requires = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
	})

	-- color parentheses
	use("junegunn/rainbow_parentheses.vim")

	use({
		"isak102/telescope-git-file-history.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"tpope/vim-fugitive",
		},
	})

	-- Avante

	-- Required plugins
	use("MunifTanjim/nui.nvim")
	use("MeanderingProgrammer/render-markdown.nvim")

	-- Optional dependencies
	use("HakonHarnes/img-clip.nvim")
	use("zbirenbaum/copilot.lua")
	use("stevearc/dressing.nvim") -- for enhanced input UI
	use("folke/snacks.nvim") -- for modern input UI

	-- Avante.nvim with build process
	use({
		"yetone/avante.nvim",
		branch = "main",
		run = "make",
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
