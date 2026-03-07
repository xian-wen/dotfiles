return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  keys = {
    {
      "<Leader>qs",
      function()
        require("persistence").load()
      end,
      desc = "Restore Session",
    },
    {
      "<Leader>qS",
      function()
        require("persistence").select()
      end,
      desc = "Select Session",
    },
    {
      "<Leader>ql",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore Last Session",
    },
    {
      "<Leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "Don't Save Current Session",
    },
  },
  opts = {},
}
