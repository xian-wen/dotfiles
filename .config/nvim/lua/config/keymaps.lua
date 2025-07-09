local map = vim.keymap.set
local unmap = vim.keymap.del

-- Buffers
map("n", "<C-n>", "<Cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<C-p>", "<Cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "<Leader>bb", "<Cmd>e #<CR>", { desc = "Switch to Other Buffer" })
map("n", "<Leader>`", "<Leader>bb", { desc = "Switch to Other Buffer", remap = true })
map("n", "<Leader>bn", "<Cmd>enew<CR>", { desc = "New Buffer" })
map("n", "<Leader>bc", "<Cmd>bd<CR>", { desc = "Close Buffer" })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
-- <C-w>n: New Window
-- <C-w>c: Close Window
-- <C-w>o: Close Other Windows

map({ "n", "t" }, "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase Window Height" })
map({ "n", "t" }, "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease Window Height" })
map({ "n", "t" }, "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase Window Width" })
map({ "n", "t" }, "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease Window Width" })

-- Unmap <C-w><C-d>, which is set to show line diagnostics by default,
-- so that scroll down works in <C-w> or <Leader>w in which-key.
unmap("n", "<C-w><C-d>")

-- Tabs
-- gt: Next Tab
-- gT: Prev Tab
map("n", "<Leader><Tab>n", "<Cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<Leader><Tab>c", "<Cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<Leader><Tab>o", "<Cmd>tabonly<CR>", { desc = "Close Other Tabs" })

-- Clear search
map("n", "<Esc>", "<Cmd>nohlsearch<CR><Esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- Taken from runtime/lua/_editor.lua
map(
  "n",
  "<Leader>uu",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- Add undo break-points
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Quickfix/Location List
map("n", "<Leader>xq", "<Cmd>copen<CR>", { desc = "Quickfix List" })
map("n", "<Leader>xl", "<Cmd>lopen<CR>", { desc = "Location List" })

-- Diagnostic
local diagnostic_goto = function(next, severity)
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({
      count = next and 1 or -1,
      severity = severity,
      float = true,
    })
  end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
-- <C-w>d: Line Diagnostics

-- Highlights under cursor
map("n", "<Leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<Leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- Toggle options
map("n", "<Leader>ub", function()
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
end, { desc = "Toggle Background" })
map("n", "<Leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle Diagnostics" })
map("n", "<Leader>uh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })
map("n", "<Leader>ul", "<Cmd>set list!<CR>", { desc = "Toggle List" })
map("n", "<Leader>un", "<Cmd>set number!<CR>", { desc = "Toggle Number" })
map("n", "<Leader>ur", "<Cmd>set relativenumber!<CR>", { desc = "Toggle Relative Number" })
map("n", "<Leader>us", "<Cmd>set spell!<CR>", { desc = "Toggle Spell" })
map("n", "<Leader>ut", function()
  if vim.b.ts_highlight then
    vim.treesitter.stop()
  else
    vim.treesitter.start()
  end
end, { desc = "Toggle Treesitter Highlight" })
map("n", "<Leader>uw", "<Cmd>set wrap!<CR>", { desc = "Toggle Wrap" })

-- Keywordprg
map("n", "<Leader>K", "<Cmd>normal! K<CR>", { desc = "Keywordprg" })

-- Lazy
map("n", "<Leader>L", "<Cmd>Lazy<CR>", { desc = "Lazy" })
