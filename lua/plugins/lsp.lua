return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "gd", vim.lsp.buf.definition, "Go to Definition" },
			{ "gr", vim.lsp.buf.references, "Go to References" },
			{ "K", vim.lsp.buf.hover, "Hover Documentation" },
			{ "<leader>ca", vim.lsp.buf.code_action, "Code Action" },
			{ "<leader>cr", vim.lsp.buf.rename, "Rename Symbol" },
			{ "<leader>li", "<cmd>checkhealth vim.lsp<CR>", "Check LSP health" },
			{ "<leader>lr", "<cmd>lsp restart<CR>", "Check LSP health" },
			{ "<leader>ld", "<cmd>lsp disable<CR>", "Disable LSP" },
			{ "<leader>le", "<cmd>lsp enable<CR>", "Enable LSP" },
		},
	},

	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				border = "rounded",
			},
		},

		keys = {
			{ "<leader>cm", "<cmd>Mason<CR>", { desc = "Mason" } },
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim" },
			"neovim/nvim-lspconfig",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lsp = require("mason-lspconfig")

			mason_lsp.setup({
				ensure_installed = { "lua_ls", "nil_ls", "statix", "ruff" },
				handlers = {
					function(server_name)
						local capabilities = require("blink.cmp").get_lsp_capabilities()

						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,

					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							settings = {
								Lua = { diagnostics = { globals = { "vim", "Snacks" } } },
							},
						})
					end,
				},
			})
		end,
	},
}
