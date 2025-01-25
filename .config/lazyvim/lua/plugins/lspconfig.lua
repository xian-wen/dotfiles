return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      bashls = {},
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
