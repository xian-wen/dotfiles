-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del

-- Buffers
map("n", "<C-n>", "<Cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<C-p>", "<Cmd>bprevious<CR>", { desc = "Prev Buffer" })
unmap("n", "<S-h>")
unmap("n", "<S-l>")

-- LazyExtra
map("n", "<Leader>X", "<Cmd>LazyExtra<CR>", { desc = "LazyExtra" })

-- Lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<Leader>G", function()
    Snacks.lazygit({ cwd = LazyVim.root.git() })
  end, { desc = "Lazygit (Root Dir)" })
end
