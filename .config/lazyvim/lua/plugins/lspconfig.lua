return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              -- Avoid missing required fields warnnings.
              disable = { "missing-fields" },
            },
          },
        },
      },
    },
  },
}
