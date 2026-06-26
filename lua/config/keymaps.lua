local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<leader>lz", "<cmd>Lazy<cr>", {desc = "Lazy"})

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<C-q>", "<C-w>q", { desc = "Close Buffer" })

-- Move selected lines down and up in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected text down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected text up" })

-- Don't loose selection
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "[d", function()
  vim.diagnostic.goto_prev({ severity = nil })
end, { desc = "Go to Previous Diagnostic" })

map("n", "]d", function()
  vim.diagnostic.goto_next({ severity = nil })
end, { desc = "Go to Next Diagnostic" })

map("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Go to Previous LSP Error" })

map("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Go to Next LSP Error" })

map("n", "<leader>cd", function()
  vim.diagnostic.open_float({
    scope = "line",
    border = vim.g.diagnostic_border or "single",
    focusable = true,
  })
end, { desc = "Line Diagnostics" })
