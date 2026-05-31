return {
  "lukas-reineke/indent-blankline.nvim",
  -- Same as LazyFile.
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  main = "ibl",
  opts = function()
    Snacks.toggle({
      name = "Indent Guides",
      get = function()
        return require("ibl.config").get_config(0).enabled
      end,
      set = function(state)
        require("ibl").setup_buffer(0, { enabled = state })
      end,
    }):map("<Leader>ug")
    return {
      indent = { char = "│" },
      exclude = {
        filetypes = { "text" },
      },
    }
  end,
}
