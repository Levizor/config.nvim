local map = vim.keymap.set

map("n", "<Esc", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<C-q>", "<C-w>q", { desc = "Close Buffer" })

-- Don't loose selection
map("v", "<", "<gv")
map("v", ">", ">gv")
