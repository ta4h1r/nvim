-- local function restore_nvim_tree()
-- 	local nvim_tree = require("nvim-tree")
-- 	nvim_tree.change_dir(vim.fn.getcwd())
-- 	nvim_tree.refresh()
-- end

require("auto-session").setup({
	log_level = "error",

	-- auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
	auto_session_allowed_dirs = { "~/Dev/*", "~/.config/*" },

	-- ⚠️ This will only work if Telescope.nvim is installed
	-- The following are already the default values, no need to provide them if these are already the settings you want.
	session_lens = {
		-- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
		buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
		load_on_setup = true,
		theme_conf = { border = true },
		previewer = false,
	},

	pre_save_cmds = { "NvimTreeClose" },
	post_restore_cmds = {
		"NvimTreeFindFile",
		"NvimTreeClose",
	},
})
