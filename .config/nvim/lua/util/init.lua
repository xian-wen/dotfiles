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
M.get_plugin = function(name)
  return require("lazy.core.config").spec.plugins[name]
end

---@param plugin string
M.has = function(plugin)
  return M.get_plugin(plugin) ~= nil
end

---@param name string
M.opts = function(name)
  local plugin = M.get_plugin(name)
  return plugin and require("lazy.core.plugin").values(plugin, "opts", false) or {}
end

-- Weak table for automatic cache cleanup
local cache = setmetatable({}, { __mode = "kv" })
-- Cache invalidation events
vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach", "BufEnter" }, {
  callback = function(args)
    cache[args.buf] = nil
  end,
})

-- Root spec: { "lsp", { ".git", "lua" }, "cwd" }
---@param opts? { buf?: integer, patterns?: string[] }
---@return string
M.root = function(opts)
  opts = opts or {}
  local buf = opts.buf or 0
  local patterns = opts.patterns or { ".git", "lua" }
  -- Cache check
  if cache[buf] then
    return cache[buf]
  end
  -- Multi-LSP handling
  local clients = vim.lsp.get_clients({ bufnr = buf })
  if #clients > 0 then
    local lsp_roots = vim.tbl_map(function(client)
      return client.config.root_dir
    end, clients)
    -- Sort by most specific path (longest path first)
    table.sort(lsp_roots, function(a, b)
      return #a > #b
    end)
    cache[buf] = lsp_roots[1]
    return cache[buf]
  end
  -- Pattern-based detection
  local root = vim.fs.root(buf, patterns)
  if root then
    cache[buf] = root
    return cache[buf]
  end
  -- Fallback to CWD
  cache[buf] = vim.uv.cwd()
  return cache[buf]
end

M.git_root = function()
  return vim.fs.root(0, ".git")
end

return M
