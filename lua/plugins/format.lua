return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},

		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff" },
			nix = { "nixfmt" },
			typst = { "typstyle" },
		},
	},

	config = function()
		vim.keymap.set("n", "<leader>cf", "<cmd>ConformInfo<CR>", { desc = "ConformInfo" })
	end,
}
