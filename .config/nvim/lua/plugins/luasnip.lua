return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keep_roots = true,
      link_roots = true,
      link_children = true,
      update_events = { "TextChanged", "TextChangedI" },
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
    end,
  },

  {
    "saghen/blink.cmp",
    opts = {
      snippets = { preset = "luasnip" },
    },
  },
}
