return {
  {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    cond = vim.g.ai_cmp == "copilot",
    event = "BufReadPost",
    cmd = "Copilot",
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
