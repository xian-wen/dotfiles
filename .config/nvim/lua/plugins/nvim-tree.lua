return {
  "nvim-tree/nvim-tree.lua",
  cmd = "NvimTreeToggle",
  keys = {
    { "<Leader>e", "<Leader>fe", desc = "Explorer NvimTree (Root Dir)", remap = true },
    { "<Leader>E", "<Leader>fE", desc = "Explorer NvimTree (cwd)", remap = true },
    {
      "<Leader>fe",
      function()
        require("nvim-tree.api").tree.toggle({
          path = require("util").root(),
          find_file = true,
          update_root = true,
        })
      end,
      desc = "Explorer NvimTree (Root Dir)",
    },
    {
      "<Leader>fE",
      function()
        require("nvim-tree.api").tree.toggle({ path = vim.uv.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
  opts = {
    view = {
      -- Avoid the size of the non nvim-tree windows be equalized.
      preserve_window_proportions = true,
      -- Dynamic width based on the longest line.
      width = { min = 30, max = -1 },
    },
    renderer = {
      indent_markers = { enable = true },
      icons = {
        glyphs = {
          default = "󰈔",
          symlink = "",
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
        },
      },
    },
    git = { timeout = 3000 },
  },
}
