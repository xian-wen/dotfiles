return {
  "lukas-reineke/indent-blankline.nvim",
  -- Same as LazyFile.
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  main = "ibl",
  keys = {
    { "<Leader>ug", "<Cmd>IBLToggle<CR>", desc = "Toggle Indent Guides" },
  },
  opts = {
    indent = { char = "│" },
    exclude = {
      filetypes = { "text" },
    },
  },
}
