return {
  {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
      filetypes = { markdown = true },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        opts = {},
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 1,
      })
    end,
  },
}
