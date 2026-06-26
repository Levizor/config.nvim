return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "Select around a function" },
          ["if"] = { query = "@function.inner", desc = "Select inside a function" },
          ["ac"] = { query = "@class.outer", desc = "Select around a class" },
          ["ic"] = { query = "@class.inner", desc = "Select inside a class" },
          ["aa"] = { query = "@parameter.outer", desc = "Select around an argument" },
          ["ia"] = { query = "@parameter.inner", desc = "Select inside an argument" },
        },
        selection_modes = {
          ["@function.outer"] = "V",
          ["@class.outer"] = "V",
        },
      },
    })
  end,
}
