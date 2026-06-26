-- netrw
vim.g.netrw_banner = 0 -- Don't show netrw banner
vim.g.netrw_list_hide = [[^\.\.\/\=$,^\.\/\=$]] -- Hide ../ and ./
vim.g.netrw_hide = 1
vim.g.border = "single"

local opt = vim.opt

opt.showmode = true
opt.showcmd = true
opt.number = true              -- Show line numbers
opt.relativenumber = true      -- Show relative line numbers 
opt.numberwidth = 2            -- Min number of columns used for numbers
opt.cmdheight = 0              -- Lines used for cmdline (not shown if not used)

opt.tabstop = 2                -- Number of spaces a tab counts for
opt.shiftwidth = 2             -- Number of spaces for auto-indent
opt.softtabstop = 2            -- Moving cursor instead of writing tab in insert mode
opt.expandtab = true           -- Convert tabs to spaces
opt.smartindent = false        -- Disable smart indenting
opt.autoindent = true

opt.ignorecase = true          -- Ignore case when searching...
opt.smartcase = true           -- Unless search contains a capital letter
opt.mouse = "a"                -- Add mouse support
opt.hlsearch = true            -- Leave highlights after search

opt.termguicolors = true       -- True color support
opt.signcolumn = "yes"         -- Always show sign column 
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"       -- Behaviour of scroll buffer when opening/resizing windows
opt.scrolloff = 8              -- Keep at least 8 lines above/below cursor
opt.cursorline = true          -- Highlight the text line of the cursor
opt.cursorlineopt = "number"   -- Highlight the line number

opt.clipboard = "unnamedplus"  -- Use system clipboard
opt.undofile = true            -- Add undo file

opt.wrap = true                -- Wrap lines longer than the width of the window
opt.linebreak = true           -- Wrap words
opt.breakindent = true         -- Preserve indent
opt.virtualedit = "block"      -- Allow positioning cursor where there is no character in block selection mode (C-v)

opt.swapfile = false           -- Do not use swap file

-- opt.background = 
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
