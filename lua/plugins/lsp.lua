return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lspconfig")
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to Definition")
          map("gr", vim.lsp.buf.references, "Go to References")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
          map("<leader>li", "<cmd>checkhealth vim.lsp<CR>", "Check LSP health")
          map("<leader>lr", "<cmd>lsp restart<CR>", "Check LSP health")
          map("<leader>ld", "<cmd>lsp disable<CR>", "Disable LSP")
          map("<leader>le", "<cmd>lsp enable<CR>", "Enable LSP")
        end,
      })
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded"
      },
    },

    config = function(_, opts)
      require("mason").setup(opts)
      vim.keymap.set("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Mason" })
    end,
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
        ensure_installed = { "lua_ls", "nil_ls", "ruff" },
        handlers = {
          -- Default automatic initialization handler for all downloaded servers
          function(server_name)
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Inject those capabilities into lspconfig!
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,

          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              settings = {
                Lua = { diagnostics = { globals = {"vim", "Snacks" }, }, },
              },
            })
          end,
        }
      })
    end,
  }
}
