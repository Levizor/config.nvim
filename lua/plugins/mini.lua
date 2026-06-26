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

-- Helper 1: Get LSP Connection & Failure Status
local function get_lsp_status()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #buf_clients == 0 then
    return "󰚦 LSP: Off" -- No clients attached to the current buffer
  end

  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARNING })
  local info = ""
  if errors > 0 then
    info = info .. string.format(" %d", errors)
  end
  if warnings > 0 then
    info = info .. string.format(" %d", warnings)
  end

  return info
end

-- Helper 2: Get Formatting Disable/Failure State (Hooks into Conform)
local function get_format_status()
  -- Check if autoformatting was manually toggled off via our recent custom commands
  if vim.g.disable_autoformat or vim.b.disable_autoformat then
    return "󰉁 Skip"
  end

  -- Fallback logic to check if a valid formatter exists for the current filetype
  local has_formatter = package.loaded["conform"] and #require("conform").list_formatters(0) > 0
  if not has_formatter then
    return "" -- No formatter specified for this file extension (keep it silent)
  end

  return "󰉁 Auto"
end

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
      
      -- Fetch our new reactive statuses
      local lsp = get_lsp_status()
      local fmt = get_format_status()

      return statusline.combine_groups({
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- Spacer pushing everything following to the right edge
        { hl = "MiniStatuslineModeCommand", strings = { macro_indicator } },
        -- ─── ADDED DIAGNOSTIC & AUTOMATION GROUPS ───
        { hl = "MiniStatuslineDevinfo",     strings = { lsp } },
        { hl = "MiniStatuslineFileinfo",    strings = { fmt } },
        { hl = "MiniStatuslineFilename",    strings = { location } },
      })
    end,
  },
})

  end,
}
