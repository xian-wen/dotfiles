return {
  "folke/lazydev.nvim",
  ft = "lua",
  cmd = "LazyDev",
  opts = {
    library = {
      -- Only load luvit types when the `vim.uv` word is found.
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- Load the lazy library when the `lazy` module is required.
      { path = "lazy.nvim", mods = { "lazy" } },
      -- Only load the snacks library when the `Snacks` global is found.
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
