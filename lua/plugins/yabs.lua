return {
	"pianocomposer321/yabs.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("yabs"):setup({
			languages = { -- List of languages in vim's `filetype` format
				lua = {
					tasks = {
						run = {
							command = "luafile %", -- The command to run (% and other
							-- wildcards will be automatically
							-- expanded)
							type = "vim", -- The type of command (can be `vim`, `lua`, or
							-- `shell`, default `shell`)
						},
					},
				},
				python = {
					default_task = "run",
					tasks = {
						run = {
							command = "python3 %", -- Assuming you're using python3
							output = "terminal",
						},
						lint = {
							command = "pylint %", -- Run pylint for linting
							output = "quickfix",
						},
					},
				},
				go = {
					default_task = "run",
					tasks = {
						build = {
							command = "go build %", -- Build the current Go package
							output = function()
								vim.cmd([[1TermExec cmd="go build"]])
							end,
						},
						run = {
							command = "go run %", -- Run the current Go file
							output = function()
								vim.cmd([[1TermExec cmd="go run ."]])
							end,
						},
						lint = {
							command = "golangci-lint run",
							output = function()
								vim.cmd([[1TermExec cmd="golangci-lint run"]])
							end,
						},
						build_and_run = {
							command = "go build .; go run .", -- Run the current Go file
							output = function()
								vim.cmd([[1TermExec cmd="go build . && go run ."]])
							end,
						},
					},
				},
				java = {
					default_task = "build_and_run",
					tasks = {
						compile = {
							command = "javac %",
							output = "quickfix",
							opts = {
								open_on_run = "auto",
							},
						},
						run = {
							command = "java %",
							output = "terminal",
						},
						build_and_run = {
							command = function()
								require("yabs"):run_task("compile", {
									on_exit = function(_, exit_code)
										if exit_code == 0 then
											require("yabs").languages.java:run_task("run")
										end
									end,
								})
							end,
							type = "lua",
						},
					},
				},
				c = {
					default_task = "build_and_run",
					tasks = {
						build = {
							command = "gcc main.c -o main",
							output = "quickfix", -- Where to show output of the
							-- command. Can be `buffer`,
							-- `consolation`, `echo`,
							-- `quickfix`, `terminal`, or `none`
							opts = { -- Options for output (currently, there's only
								-- `open_on_run`, which defines the behavior
								-- for the quickfix list opening) (can be
								-- `never`, `always`, or `auto`, the default)
								open_on_run = "auto",
							},
						},
						run = { -- You can specify as many tasks as you want per
							-- filetype
							command = "./main",
							output = "terminal",
						},

						build_and_run = { -- Setting the type to lua means the command
							-- is a lua function
							command = function()
								-- The following api can be used to run a task when a
								-- previous one finishes
								-- WARNING: this api is experimental and subject to
								-- changes
								require("yabs"):run_task("build", {
									-- Job here is a plenary.job object that represents
									-- the finished task, read more about it here:
									-- https://github.com/nvim-lua/plenary.nvim#plenaryjob
									on_exit = function(Job, exit_code)
										-- The parameters `Job` and `exit_code` are optional,
										-- you can omit extra arguments or
										-- skip some of them using _ for the name
										if exit_code == 0 then
											require("yabs").languages.c:run_task("run")
										end
									end,
								})
							end,
							type = "lua",
						},
					},
				},
				rust = {
					default_task = "run",
					tasks = {
						build = {
							command = "",
							output = function()
								vim.cmd([[1TermExec cmd="cargo build"]])
							end,
						},
						run = {
							command = "",
							output = function()
								vim.cmd([[1TermExec cmd="cargo run"]])
							end,
						},
						check = {
							command = "",
							output = function()
								vim.cmd([[1TermExec cmd="cargo check"]])
							end,
						},
						test = {
							command = "",
							output = function()
								vim.cmd([[1TermExec cmd="cargo test"]])
							end,
						},
						release = {
							command = "",
							output = function()
								vim.cmd([[1TermExec cmd="cargo build --release"]])
							end,
						},
						lint = {
							command = "",
							output = function()
								vim.cmd([[1TermExec cmd="cargo clean && cargo clippy -- -W clippy::pedantic"]])
							end,
						},
						doc = {
							command = "cargo doc --open",
							output = "terminal",
						},
					},
				},
			},
			tasks = { -- Same values as `language.tasks`, but global
				build = {
					command = "echo building project...",
					output = "consolation",
				},
				run = {
					command = "echo running project...",
					output = "echo",
				},
				optional = {
					command = "echo runs on condition",
					-- You can specify a condition which determines whether to enable a
					-- specific task
					-- It should be a function that returns boolean,
					-- not a boolean directly
					-- Here we use a helper from yabs that returns such function
					-- to check if the files exists
					condition = require("yabs.conditions").file_exists("filename.txt"),
				},
			},
			opts = { -- Same values as `language.opts`
				output_types = {
					quickfix = {
						open_on_run = "always",
					},
				},
			},
		})
	end,
}
