local M = {}

---@param name string
M.opts = function(name)
  local plugin = require("lazy.core.config").spec.plugins[name]
  return plugin and require("lazy.core.plugin").values(plugin, "opts", false) or {}
end

M.root = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local lsp_root = clients and clients[1] and clients[1].config.root_dir
  return lsp_root or vim.fs.root(0, { ".git", "lua" }) or vim.uv.cwd()
end

M.git_root = function()
  return vim.fs.root(0, ".git")
end

return M
