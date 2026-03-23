return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
	},
	keys = {
		{
			"<leader>bb",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>bB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Breakpoint Condition",
		},
		{
			"<leader>bc",
			function()
				require("dap").continue()
			end,
			desc = "Run/Continue",
		},
		{
			"<leader>bx",
			function()
				require("dap").clear_breakpoints()
			end,
			desc = "Clear Breakpoints",
		},
		{
			"<leader>bC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
{
			"<leader>bi",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>bo",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>bO",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>bP",
			function()
				require("dap").pause()
			end,
			desc = "Pause",
		},
		{
			"<leader>bt",
			function()
				require("dap").terminate({ all = true })
			end,
			desc = "Terminate",
		},
		{
			"<leader>bu",
			function()
				require("dapui").toggle({})
			end,
			desc = "Dap UI",
		},
		{
			"<leader>be",
			function()
				require("dapui").eval()
			end,
			desc = "Eval",
			mode = { "n", "v" },
		},

		{
			"<leader>br",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		require("nvim-dap-virtual-text").setup()
		require("dap-go").setup()
		for _, adapterType in ipairs({ "node" }) do
			local pwaType = "pwa-" .. adapterType

			dap.adapters[pwaType] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			-- this allow us to handle launch.json configurations
			-- which specify type as "node" or "chrome" or "msedge"
			dap.adapters[adapterType] = function(cb, config)
				local nativeAdapter = dap.adapters[pwaType]

				config.type = pwaType

				if type(nativeAdapter) == "function" then
					nativeAdapter(cb, config)
				else
					cb(nativeAdapter)
				end
			end
		end

		for _, language in ipairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file using Node.js (nvim-dap)",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to process using Node.js (nvim-dap)",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug: Custom command",
					runtimeExecutable = "bash",
					runtimeArgs = function()
						local cmd = vim.fn.input("Enter command (e.g., 'test:unit'): ")
						return { "-c", cmd } -- Runs via bash to handle complex commands
					end,
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
					sourceMaps = true,
					port = 9229,
					skipFiles = { "<node_internals>/**" },
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
				},
				-- {
				-- 	type = "pwa-node",
				-- 	request = "launch",
				-- 	name = "Debug Terminal",
				-- 	runtimeExecutable = "bash",
				-- 	runtimeArgs = function()
				-- 		local cmd = vim.fn.input("Enter full command (e.g., 'yarn start:dev'): ", "yarn start:dev")
				-- 		return { "-c", cmd } -- Runs via bash to handle complex commands
				-- 	end,
				-- 	cwd = "${workspaceFolder}",
				-- 	sourceMaps = true,
				-- 	port = 9229,
				-- 	console = "integratedTerminal",
				-- 	internalConsoleOptions = "neverOpen",
				-- 	skipFiles = { "<node_internals>/**" },
				-- 	timeout = 30000,
				-- },
			}
		end

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

		-- Configure DAP signs directly (no LazyVim dependency)
		vim.api.nvim_set_hl(0, "DapStoppedLine", {
			bg = "#45475a",
			fg = "#f5e0dc",
			bold = true,
		})
		local signs = {
			Stopped = { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine" },
			Breakpoint = { text = " ", texthl = "DiagnosticError" },
			BreakpointCondition = { text = " ", texthl = "DiagnosticInfo" },
			BreakpointRejected = { text = " ", texthl = "DiagnosticError" },
			LogPoint = { text = " ", texthl = "DiagnosticInfo" },
		}
		for name, sign in pairs(signs) do
			vim.fn.sign_define("Dap" .. name, sign)
		end
	end,
}
