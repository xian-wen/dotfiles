return {
  {
    "Exafunction/codeium.nvim",
    build = ":Codeium Auth",
    cond = vim.g.ai_cmp == "codeium",
    event = "BufReadPost",
    cmd = "Codeium",
    opts = {},
  },

  {
    "saghen/blink.cmp",
    dependencies = { "codeium.nvim" },
    opts = {
      sources = {
        compat = { "codeium" },
        providers = {
          codeium = {
            kind = "Codeium",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
