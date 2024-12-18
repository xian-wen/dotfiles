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
      desc = "Horizontal Terminal",
    },
    {
      "<A-v>",
      function()
        vim.cmd(vim.v.count1 .. "ToggleTerm direction=vertical")
      end,
      mode = { "n", "t" },
      desc = "Vertical Terminal",
    },
    {
      "<A-t>",
      function()
        vim.cmd("ToggleTerm direction=tab")
      end,
      mode = { "n", "t" },
      desc = "Tab Terminal",
    },
    {
      "<A-f>",
      function()
        vim.cmd("ToggleTerm direction=float")
      end,
      mode = { "n", "t" },
      desc = "Float Terminal",
    },
  },
  opts = {
    size = function(term)
      return term.direction == "horizontal" and 15 or vim.o.columns * 0.4
    end,
    float_opts = {
      width = 80,
      height = 20,
    },
  },
}
