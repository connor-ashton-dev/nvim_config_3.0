return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional Breakpoint" },
			{ "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
			{ "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
			{ "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
			{ "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
			{ "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
			{ "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
			{ "<leader>dx", function() require("dap").terminate() end, desc = "Terminate" },
			{ "<leader>dX", function() require("dap").clear_breakpoints() end, desc = "Clear All Breakpoints" },
			{ "<leader>dw", function() require("dapui").elements.watches.add(vim.fn.expand("<cword>")) end, desc = "Watch Word Under Cursor" },
			{ "<leader>du", function() require("dapui").toggle() end, desc = "Toggle UI" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup({
				controls = { enabled = false },
			})

			-- Auto open/close UI
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			-- Breakpoint icons
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
			vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticOk", linehl = "Visual" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError" })

			-- js-debug adapter (installed via :MasonInstall js-debug-adapter)
			local js_debug_path = vim.fn.stdpath("data")
				.. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

			for _, name in ipairs({ "pwa-node", "node", "node-terminal", "pwa-chrome" }) do
				dap.adapters[name] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						args = { js_debug_path, "${port}" },
						detached = false,
					},
				}
			end

			-- JS/TS configurations
			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach to dev:debug",
						port = 9229,
						cwd = "${workspaceFolder}",
						restart = true,
						skipFiles = { "<node_internals>/**" },
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach to Node Process",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch Chrome (localhost:3000)",
						url = "http://localhost:3000",
						webRoot = "${workspaceFolder}",
					},
				}
			end
		end,
	},
}
