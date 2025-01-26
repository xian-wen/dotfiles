local M = {}

M.git_root = function()
  return vim.fs.root(0, ".git")
end

M.root = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local lsp_root = clients and clients[1] and clients[1].config.root_dir
  return lsp_root or vim.fs.root(0, { ".git", "lua" }) or vim.uv.cwd()
end

return M
