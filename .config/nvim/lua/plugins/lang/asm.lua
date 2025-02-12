return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "asm" },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        asm = { "asmfmt" },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "asmfmt" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        asm_lsp = {},
      },
    },
  },
}
