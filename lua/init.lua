-- node version
-- Ensure Neovim uses the default nvm Node version
local nvm_dir = os.getenv("HOME") .. "/.nvm"
vim.fn.system("bash -c 'source " .. nvm_dir .. "/nvm.sh && nvm use default'")
-- update Neovim's PATH to include the correct Node bin
vim.env.PATH = os.getenv("HOME") .. "/.nvm/versions/node/$(nvm version default)/bin:" .. vim.env.PATH

require("taahir.plugins-setup")

require("taahir.core.options")
require("taahir.core.keymaps")
require("taahir.core.colorscheme")

require("taahir.plugins.lsp.lspsaga")
require("taahir.plugins.lsp.lspconfig")
require("taahir.plugins.lsp.mason")
require("taahir.plugins.lsp.null-ls")

require("taahir.plugins.auto-session")
require("taahir.plugins.autopairs")
require("taahir.plugins.copilot")
require("taahir.plugins.avante")
require("taahir.plugins.barbar")
require("taahir.plugins.comment")
require("taahir.plugins.gitsigns")
require("taahir.plugins.harpoon")
require("taahir.plugins.lualine")
require("taahir.plugins.nvim-cmp")
require("taahir.plugins.nvim-dap")
require("taahir.plugins.nvim-tree")
require("taahir.plugins.nvim-ufo")
require("taahir.plugins.refactoring")
require("taahir.plugins.telescope")
require("taahir.plugins.treesitter")
require("taahir.plugins.undotree")
