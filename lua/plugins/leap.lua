return {
	url = "https://codeberg.org/andyg/leap.nvim",
	config = function()
		local leap = require("leap")

		-- Basic keymaps
		vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
		vim.keymap.set("n", "S", "<Plug>(leap-from-window)")

		-- Preview filter to minimize visual noise
		leap.opts.preview = function(ch0, ch1, ch2)
			return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
		end

		-- Equivalence classes for brackets/quotes
		leap.opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

		-- Repeat keys
		require("leap.user").set_repeat_keys("<enter>", "<backspace>")

		-- f/t motions with leap
		local function as_ft(key_specific_args)
			local common_args = {
				inputlen = 1,
				inclusive = true,
				opts = {
					labels = "", -- force autojump
					safe_labels = vim.fn.mode(1):match("[no]") and "" or nil,
				},
			}
			return vim.tbl_deep_extend("keep", common_args, key_specific_args)
		end

		local clever = require("leap.user").with_traversal_keys
		local clever_f = clever("f", "F")
		local clever_t = clever("t", "T")

		-- Add ; and , to traversal keys
		clever_f.keys = vim.tbl_deep_extend("force", clever_f.keys or {}, {
			next_target = { "f", ";" },
			prev_target = { "F", "," },
		})
		clever_t.keys = vim.tbl_deep_extend("force", clever_t.keys or {}, {
			next_target = { "t", ";" },
			prev_target = { "T", "," },
		})

		for key, key_specific_args in pairs({
			f = { opts = clever_f },
			F = { backward = true, opts = clever_f },
			t = { offset = -1, opts = clever_t },
			T = { backward = true, offset = 1, opts = clever_t },
		}) do
			vim.keymap.set({ "n", "x", "o" }, key, function()
				leap.leap(as_ft(key_specific_args))
			end)
		end
	end,
}
