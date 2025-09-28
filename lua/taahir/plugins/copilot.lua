require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = false,
		keymap = {
			accept = "<C-l>",
			next = "<C-n>",
			prev = "<C-p>",
			dismiss = "<C-c>",
		},
	},
	panel = { enabled = false },
})
