local map = vim.keymap.set
local unmap = vim.keymap.del

-- Buffers
map("n", "<C-n>", "<Cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<C-p>", "<Cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "<Leader>bb", "<Cmd>e #<CR>", { desc = "Switch to Other Buffer" })
map("n", "<Leader>`", "<Leader>bb", { desc = "Switch to Other Buffer", remap = true })
map("n", "<Leader>bn", "<Cmd>enew<CR>", { desc = "New Buffer" })
map("n", "<Leader>bc", "<Cmd>bdelete<CR>", { desc = "Close Buffer" })

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

-- Toggle Location/Quickfix List
map("n", "<Leader>xl", function()
  local ok, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not ok and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })
map("n", "<Leader>xq", function()
  local ok, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not ok and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })

-- Diagnostic
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
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
map("n", "<Leader>uI", function()
  vim.treesitter.inspect_tree()
  -- Equivalent to pressing "I" in the inspect tree.
  vim.api.nvim_input("I")
end, { desc = "Inspect Tree" })

-- Keywordprg
map("n", "<Leader>K", "<Cmd>normal! K<CR>", { desc = "Keywordprg" })

-- Lazy
map("n", "<Leader>L", "<Cmd>Lazy<CR>", { desc = "Lazy" })

-- Toggle options
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<Leader>ub")
Snacks.toggle.option("list", { name = "List" }):map("<Leader>ul")
Snacks.toggle.option("number", { name = "Number" }):map("<Leader>un")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<Leader>ur")
Snacks.toggle.option("spell", { name = "Spelling" }):map("<Leader>us")
Snacks.toggle
  .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
  :map("<Leader>ut")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<Leader>uw")

-- Toggle others
Snacks.toggle.diagnostics():map("<Leader>ud")
Snacks.toggle.dim():map("<Leader>uD")
Snacks.toggle.indent():map("<Leader>ug")
Snacks.toggle.inlay_hints():map("<Leader>uh")
Snacks.toggle.treesitter():map("<Leader>uT")
Snacks.toggle.zen():map("<Leader>uz")
Snacks.toggle.zoom():map("<Leader>uZ")
