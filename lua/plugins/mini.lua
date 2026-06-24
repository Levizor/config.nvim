return {
  "echasnovski/mini.nvim",
  event = "VimEnter", -- Automatically loads when you enter Insert mode
  config = function()
  require("mini.pairs").setup({ })
  require("mini.surround").setup({
    mappings = {
      add = "sa",            -- Add surrounding characters 
      delete = "sd",         -- Delete surrounding characters
      find = "sf",           -- Find surrounding characters
      find_left = "sF",      -- Find surrounding characters to the left
      highlight = "sh",      -- Highlight surrounding characters
      replace = "sr",        -- Replace surrounding characters
      update_n_lines = "sn", -- Update number of analyzed lines
    },
  })


  require("mini.ai").setup({
    n_lines = 500, -- How far up/down the engine searches to find the closest matching pair
  })

  local statusline = require("mini.statusline")
  statusline.setup({
    content = {
      active = function()
        local filename = vim.fn.expand("%:.")
        if filename == "" then
          filename = "[No Name]"
        end

        local reg = vim.fn.reg_recording()
        local macro_indicator = reg ~= "" and ("rec @" .. reg) or ""

        local location = string.format("%d|%d", vim.fn.line("."), vim.fn.col("."))

        return statusline.combine_groups({
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- Spacer pushing everything following to the right edge
          { hl = "MiniStatuslineModeCommand", strings = { macro_indicator } },
          { hl = "MiniStatuslineFilename", strings = { location } },
        })
      end,
    },
  })

  end,
}
