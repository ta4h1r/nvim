require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
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
