return {
  "nvim-tree/nvim-tree.lua",
  cmd = "NvimTreeToggle",
  keys = {
    {
      "<Leader>fe",
      function()
        require("nvim-tree.api").tree.toggle({
          find_file = true,
          update_root = true,
        })
      end,
      desc = "Explorer NvimTree (Dir of Current File)",
    },
    {
      "<Leader>fE",
      function()
        require("nvim-tree.api").tree.toggle({ path = vim.uv.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    { "<Leader>e", "<Leader>fe", desc = "Explorer NvimTree (Dir of Current File)", remap = true },
    { "<Leader>E", "<Leader>fE", desc = "Explorer NvimTree (cwd)", remap = true },
  },
  opts = {
    -- Avoid the size of the non nvim-tree windows be equalized.
    view = { preserve_window_proportions = true },
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
  },
}
