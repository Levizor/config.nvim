return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true, 
      columns = {
        "icon",
      },
      view_options = {
        show_hidden = true,
      },

      float = {
        padding = 0,
        max_width = 0,
        max_height = 0,
        border = "none",
        preview_split = "right",
      },

      preview_win = {
        update_on_cursor_moved = true,
        win_options = {
          signcolumn = "yes:1",
          number = false,
          relativenumber = false,
          foldcolumn = "0",
        },
      },

      keymaps = {
        ["q"] = "actions.close",
        ["<C-d>"] = "actions.preview_scroll_down",
        ["<C-u>"] = "actions.preview_scroll_up",
      },

    })

    vim.keymap.set("n", "e", function() require("oil").toggle_float(nil, {preview = {vertical = true}}) end, { desc = "Open parent directory in Oil" })
  end,
}
