return {
  "smjonas/inc-rename.nvim",
  -- cmd = "IncRename",
  config = function()
    require("inc_rename").setup({
      input_buffer_type = "dressing",
    })

    vim.keymap.set("n", "<leader>cr", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true, desc = "LSP Incremental Rename" })
  end,
}
