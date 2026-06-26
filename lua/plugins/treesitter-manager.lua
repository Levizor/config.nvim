return {
  {
    "romus204/tree-sitter-manager.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    keys = {
      { "<leader>tm", "<cmd>TSManager<cr>", {desc = "TreeSitter manager"} }
    },
    config = function(_, opts)
      require("tree-sitter-manager").setup(opts)
    end,
  },
}
