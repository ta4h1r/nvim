-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

-- configure telescope
telescope.setup({
	-- configure custom mappings
	defaults = {
		file_ignore_patterns = { "node%_modules/.*", "package%-lock" },
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
				["<C-w>"] = actions.delete_buffer,
			},
		},
	},

	extensions = {
		git_file_history = {
			-- Keymaps inside the picker
			mappings = {
				i = {
					["<C-g>"] = telescope.extensions.git_file_history.actions.open_in_browser,
				},
				n = {
					["<C-g>"] = telescope.extensions.git_file_history.actions.open_in_browser,
				},
			},

			-- The command to use for opening the browser (nil or string)
			-- If nil, it will check if xdg-open, open, start, wslview are available, in that order.
			browser_command = nil,
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("lazygit")
telescope.load_extension("refactoring")
telescope.load_extension("git_file_history")
