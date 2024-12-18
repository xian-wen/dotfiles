return {
  "lukas-reineke/indent-blankline.nvim",
  -- Alias for LazyFile.
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  main = "ibl",
  opts = {
    indent = { char = "│" },
    exclude = {
      filetypes = {
        "help",
        "lazy",
        "mason",
        "snacks_dashboard",
        "toggleterm",
      },
    },
  }
}
