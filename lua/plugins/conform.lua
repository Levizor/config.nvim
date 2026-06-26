return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo", "Format", "FormatDisable", "FormatEnable" },
	keys = {
		{ "<leader>ci", "<cmd>ConformInfo<CR>", desc = "ConformInfo" },
		{ "<leader>cf", "<cmd>Format<CR>", mode = "n", desc = "Format buffer" },
		{ "<leader>cf", "<cmd>Format<CR>", mode = "v", desc = "Format selection" },
		{ "<leader>tf", "<cmd>FormatToggle<CR>", mode = "n", desc = "Toggle Autoformat (Global)" },
		{ "<leader>tF", "<cmd>FormatToggle!<CR>", mode = "n", desc = "Toggle Autoformat (Buffer)" },
	},
	opts = {
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end,

		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff" },
			nix = { "nixfmt" },
			typst = { "typstyle" },
			bash = { "shfmt" },
			kotlin = { "ktlint" },
			c = { "clang-format" },
			rust = { "rustfmt" },
		},
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			conform.format({ builtin_lsp = "fallback", range = range })
		end, { range = true })

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				vim.b.disable_autoformat = true
				vim.notify("Autoformat disabled for current buffer")
			else
				vim.g.disable_autoformat = true
				vim.notify("Autoformat disabled globally")
			end
		end, { desc = "Disable autoformat on save", bang = true })

		vim.api.nvim_create_user_command("FormatEnable", function(args)
			if args.bang then
				vim.b.disable_autoformat = false
				vim.notify("Autoformat enabled for current buffer")
			else
				vim.g.disable_autoformat = false
				vim.notify("Autoformat enabled globally")
			end
		end, { desc = "Re-enable autoformat on save", bang = true })

		vim.api.nvim_create_user_command("FormatToggle", function(args)
			local is_disabled = args.bang and vim.b.disable_autoformat or vim.g.disable_autoformat
			if is_disabled then
				vim.cmd(args.bang and "FormatEnable!" or "FormatEnable")
			else
				vim.cmd(args.bang and "FormatDisable!" or "FormatDisable")
			end
		end, { desc = "Toggle autoformat on save", bang = true })

		vim.api.nvim_create_user_command("Wnf", function()
			local bufnr = vim.api.nvim_get_current_buf()
			vim.b[bufnr].disable_autoformat = true
			vim.cmd("write")
			vim.b[bufnr].disable_autoformat = false
		end, { desc = "Save buffer without autoformatting" })

		vim.cmd("cabbrev wnf Wnf")
	end,
}
