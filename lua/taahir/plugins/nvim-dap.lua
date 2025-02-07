require("dapui").setup()

local dap, dapui, dap_vscode_js = require("dap"), require("dapui"), require("dap-vscode-js")

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- Configure JS DAP
dap_vscode_js.setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = { "chrome", "node", "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
	}
end

-- dap.adapters["node"] = {
-- 	type = "server",
-- 	host = "::1",
-- 	port = "${port}",
-- 	executable = {
-- 		command = "node",
-- 		-- 💀 Make sure to update this path to point to your installation
-- 		args = { "/Users/taahirbhaiyat/.config/nvim/microsoft/js-debug/src/dapDebugServer.js", "${port}" },
-- 	},
-- }
--
-- dap.configurations["typescript"] = {
-- 	{
-- 		type = "node",
-- 		request = "attach",
-- 		name = "Attach to process",
-- 		-- processId = "${command:PickProcess}",
-- 		processId = 29456,
-- 	},
-- 	{
-- 		name = "Launch TypeScript",
-- 		type = "node",
-- 		request = "launch",
-- 		program = "app.ts",
-- 		outFiles = { "${workspaceFolder}/bin/**/*.js" },
-- 	},
-- }
--
-- dap.configurations["javascript"] = {
-- 	{
-- 		type = "pwa-node",
-- 		request = "launch",
-- 		name = "Launch file",
-- 		program = "${file}",
-- 		cwd = "${workspaceFolder}",
-- 	},
-- }

-- Configure Python DAP
dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = "/Users/taahir.bhaiyat/opt/anaconda3/bin/python",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directory and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/Users/taahir.bhaiyat/opt/anaconda3/bin/python") == 1 then
				return cwd .. "/Users/taahir.bhaiyat/opt/anaconda3/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/Users/taahir.bhaiyat/opt/anaconda3/bin/python"
			else
				return "/Users/taahir.bhaiyat/opt/anaconda3/bin/python"
			end
		end,
	},
}

-- keybind options
local opts = { noremap = true, silent = true }

-- debugger toggles
vim.keymap.set("n", "<leader>B", "<Cmd>lua require'dapui'.toggle()<CR>")
vim.keymap.set("n", "<leader>b", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<C-n>", "<Cmd>lua require'dap'.continue()<CR>")
