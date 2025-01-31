local M = {}

---@param name string
M.opts = function(name)
  local plugin = require("lazy.core.config").spec.plugins[name]
  return plugin and require("lazy.core.plugin").values(plugin, "opts", false) or {}
end

---@param opts? {buf?: number}
M.root = function(opts)
  opts = opts or {}
  local buf = opts.buf or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf })
  local lsp_root = clients[1] and clients[1].config.root_dir
  return lsp_root or vim.fs.root(0, { ".git", "lua" }) or vim.uv.cwd()
end

M.git_root = function()
  return vim.fs.root(0, ".git")
end

return M
