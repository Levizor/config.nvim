return {
  'saghen/blink.cmp',
  dependencies = {
    'saghen/blink.lib',
    'rafamadriz/friendly-snippets',
  },
  build = function()
    require('blink.cmp').build():pwait()
  end,

  ---@module 'blink.cmp'
  ----@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    -- https://main.cmp.saghen.dev/configuration/keymap.html#snippets
    keymap = {
      preset = 'enter' ,
      ["<CR>"] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.accept()
        end
        local pairs_ok, mini_pairs = pcall(require, "mini.pairs")
        if pairs_ok then
          local keys = mini_pairs.cr()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), "n", false)
          return true 
        end
      end,
      "fallback",
      },
      ["<Tab>"] = {"snippet_forward", "fallback" },
      ["<S-Tab>"] = {"snippet_backward", "fallback" },
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = true }, menu = { border = vim.g.border }},



    -- (Default) list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"`
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "rust" },

    appearance = {
      nerd_font_variant = "mono",
    },
  },
}
