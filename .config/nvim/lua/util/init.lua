local M = {}

M.foldexpr = function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].ts_folds == nil then
    if vim.bo[buf].filetype == "" then
      return "0"
    end
    if vim.bo[buf].filetype:find("dashboard") then
      vim.b[buf].ts_folds = false
    else
      vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
    end
  end
  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

---@param name string
M.opts = function(name)
  local plugin = require("lazy.core.config").spec.plugins[name]
  return plugin and require("lazy.core.plugin").values(plugin, "opts", false) or {}
end

---@param opts? { buf?: number }
M.root = function(opts)
  opts = opts or {}
  return vim.fs.root(opts.buf or 0, { ".git", "lua" }) or vim.uv.cwd()
end

M.git_root = function()
  return vim.fs.root(0, ".git")
end

return M
