return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})

      local float_win = nil
      local float_buf = nil
      local max_width = 40

      -- 🎚️ Dynamic Floating Widget Engine
      local function draw_harpoon_widget()
        if not float_buf or not vim.api.nvim_buf_is_valid(float_buf) then
          float_buf = vim.api.nvim_create_buf(false, true)
          vim.bo[float_buf].buftype = "nofile"
        end

        local list = harpoon:list()
        local list_length = list:length()

        -- If nothing is pinned, cleanly close the HUD panel and exit
        if list_length == 0 then
          if float_win and vim.api.nvim_win_is_valid(float_win) then
            vim.api.nvim_win_close(float_win, true)
            float_win = nil
          end
          return
        end

        local current_file_path = vim.api.nvim_buf_get_name(0)
        local lines = {}
        local highlights = {}

        -- ⚡ FULLY DYNAMIC ITERATION: Automatically scales up to 9 or more items
        for i = 1, list_length do
          local item = list:get(i)
          if item then
            local item_path = vim.loop.fs_realpath(item.value) or item.value
            local current_path = vim.loop.fs_realpath(current_file_path) or current_file_path
            local display_name = item.value:match("^.+/(.+)$") or item.value

            local raw_text = string.format("%d:%s", i, display_name)
            
            -- Keep text bound within max width
            if #raw_text > max_width then
              raw_text = string.sub(raw_text, 1, max_width - 3) .. "..."
            end

            -- Right-justify layout padding logic
            local padding_needed = max_width - #raw_text
            local aligned_text = string.rep(" ", padding_needed) .. raw_text

            table.insert(lines, aligned_text)

            if item_path == current_path then
              table.insert(highlights, { group = "DiagnosticSignInfo", line = i - 1 })
            else
              table.insert(highlights, { group = "Comment", line = i - 1 })
            end
          end
        end

        vim.bo[float_buf].modifiable = true
        vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, lines)
        vim.bo[float_buf].modifiable = false

        for _, hl in ipairs(highlights) do
          vim.api.nvim_buf_add_highlight(float_buf, 0, hl.group, hl.line, 0, -1)
        end

        -- Calculate layout constraints relative to top-right screen deck
        local win_width = vim.api.nvim_get_option_value("columns", {})
        local row = 1 
        local col = win_width - max_width - 2 

        local win_opts = {
          relative = "editor",
          width = max_width,
          height = list_length, -- Height perfectly scales to match your active list items
          row = row,
          col = col,
          style = "minimal",
          focusable = false,
          border = "none",
        }

        if not float_win or not vim.api.nvim_win_is_valid(float_win) then
          float_win = vim.api.nvim_open_win(float_buf, false, win_opts)
          vim.wo[float_win].winbl = 100 
        else
          vim.api.nvim_win_set_config(float_win, win_opts)
        end
      end

      -- Window display hook automation pipelines
      vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "VimResized", "BufWritePost" }, {
        callback = function()
          if vim.bo.buftype == "" and vim.api.nvim_buf_get_name(0) ~= "" then
            draw_harpoon_widget()
          elseif float_win and vim.api.nvim_win_is_valid(float_win) then
            vim.api.nvim_win_close(float_win, true)
            float_win = nil
          end
        end,
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
        draw_harpoon_widget()
        print("File harpooned!")
      end, { desc = "Harpoon: Add File" })

      vim.keymap.set("n", "<leader>hh", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon: List Menu" })

      -- ⚡ DYNAMIC HOTKEY LOOP: Generates bindings cleanly from 1 all the way to 9
      for idx = 1, 9 do
        vim.keymap.set("n", "<M-" .. idx .. ">", function()
          harpoon:list():select(idx)
          vim.schedule(draw_harpoon_widget)
        end, { desc = "Harpoon File " .. idx })
      end
    end,
  },
}
