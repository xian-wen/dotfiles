return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "dart" },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        dart = { "dart_format" },
      },
    },
  },

  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    opts = {
      lsp = {
        init_options = {
          -- Skip full-project scan on launch, only analyze open files.
          -- Single most important setting for fast dartls startup on WSL.
          onlyAnalyzeProjectsWithOpenFiles = true,
        },
      },
    },
  },
}
