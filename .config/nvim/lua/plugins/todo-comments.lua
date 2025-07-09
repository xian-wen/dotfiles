return {
  "folke/todo-comments.nvim",
  -- Same as LazyFile.
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next Todo Comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Prev Todo Comment",
    },
  },
  opts = {},
}
