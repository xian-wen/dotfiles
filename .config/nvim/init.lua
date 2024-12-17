-- Set options.
require("config.options")

-- Bootstrap lazy.nvim and plugins.
require("config.lazy")

-- Set colorscheme.
vim.cmd.colorscheme("onedark")

-- Lazily load autocmds and keymaps.
vim.schedule(function()
  require("config.autocmds")
  require("config.keymaps")
end)
