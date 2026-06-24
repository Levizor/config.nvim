return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	keys = {
		{ "<leader>cf", "<cmd>ConformInfo<CR>", { desc = "ConformInfo" } },
	},
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
			bash = { "shfmt" },
			kotlin = { "ktlint" },
			c = { "clang-format" },
			rust = { "rustfmt" },
		},
	},
}
