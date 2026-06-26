return {
  "jiaoshijie/undotree",
  cmd = "UndotreeToggle",
  opts = {
    float_diff = false,
    window = {
      width = 0.15
    }
  },
  keys = {
    { "<leader>uu", function() require('undotree').toggle() end, desc = "Toggle Undo Tree" },
  },
}
