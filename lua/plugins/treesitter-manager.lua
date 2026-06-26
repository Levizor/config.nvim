return {
  {
    "romus204/tree-sitter-manager.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function(_, opts)
      require("tree-sitter-manager").setup(opts)
    end,
  },
}
