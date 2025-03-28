-- Overridden by lspconfig.lua

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
-- 	dynamicRegistration = false,
-- 	lineFoldingOnly = true,
-- }

-- local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
-- for _, ls in ipairs(language_servers) do
-- 	require("lspconfig")[ls].setup({
-- 		capabilities = capabilities,
-- 		-- you can add other fields for setting up lsp server in this table
-- 	})
-- end

local ftMap = {
	vim = "indent",
	python = { "indent" },
	git = "",
}

require("ufo").setup({
	-- open_fold_hl_timeout = 150,
	-- close_fold_kinds_for_ft = {
	-- 	default = { "imports", "comment" },
	-- 	json = { "array" },
	-- 	c = { "comment", "region" },
	-- },
	-- preview = {
	-- 	win_config = {
	-- 		border = { "", "─", "", "", "", "─", "", "" },
	-- 		winhighlight = "Normal:Folded",
	-- 		winblend = 0,
	-- 	},
	-- 	mappings = {
	-- 		scrollU = "<C-u>",
	-- 		scrollD = "<C-d>",
	-- 		jumpTop = "[",
	-- 		jumpBot = "]",
	-- 	},
	-- },
	-- provider_selector = function(bufnr, filetype, buftype)
	-- 	-- if you prefer treesitter provider rather than lsp,
	-- 	-- return ftMap[filetype] or {'treesitter', 'indent'}
	-- 	return ftMap[filetype]
	--
	-- 	-- refer to ./doc/example.lua for detail
	-- end,
})

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
-- vim.keymap.set("n", "K", function()
-- 	local winid = require("ufo").peekFoldedLinesUnderCursor()
-- 	if not winid then
-- 		-- choose one of coc.nvim and nvim lsp
-- 		vim.fn.CocActionAsync("definitionHover") -- coc.nvim
-- 		vim.lsp.buf.hover()
-- 	end
-- end)
