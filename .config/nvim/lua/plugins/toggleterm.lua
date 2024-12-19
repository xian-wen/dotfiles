return {
  "akinsho/toggleterm.nvim",
  cmd = "ToggleTerm",
  keys = {
    {
      "<A-s>",
      function()
        vim.cmd(vim.v.count1 .. "ToggleTerm direction=horizontal")
      end,
      mode = { "n", "t" },
      desc = "Toggle Horizontal Terminal",
    },
    {
      "<A-v>",
      function()
        vim.cmd(vim.v.count1 .. "ToggleTerm direction=vertical")
      end,
      mode = { "n", "t" },
      desc = "Toggle Vertical Terminal",
    },
    {
      "<A-t>",
      function()
        vim.cmd("ToggleTerm direction=tab")
      end,
      mode = { "n", "t" },
      desc = "Toggle Terminal in Tab",
    },
    {
      "<A-f>",
      function()
        vim.cmd("ToggleTerm direction=float")
      end,
      mode = { "n", "t" },
      desc = "Toggle Floating Terminal",
    },
  },
  opts = {
    -- Size for horizontal and vertical terminals.
    size = function(term)
      return term.direction == "horizontal" and 15 or vim.o.columns * 0.4
    end,
    -- Size for floating terminal.
    float_opts = {
      width = 80,
      height = 20,
    },
  },
}
