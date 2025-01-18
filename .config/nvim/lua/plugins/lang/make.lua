return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "make" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        autotools_ls = {},
      },
    },
  },
}
