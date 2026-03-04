local M = {}

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

local _defaults = {} ---@type table<string, boolean>

-- Determines whether it's safe to set an option to a default value.
-- It will only set the option if:
-- * it is the same as the global value
-- * it's current value is a default value
-- * it was last set by a script in $VIMRUNTIME
---@param option string
---@param value string|number|boolean
---@return boolean was_set
M.set_default = function(option, value)
  local l = vim.api.nvim_get_option_value(option, { scope = "local" })
  local g = vim.api.nvim_get_option_value(option, { scope = "global" })
  _defaults[("%s=%s"):format(option, value)] = true
  local key = ("%s=%s"):format(option, l)
  if l ~= g and not _defaults[key] then
    -- Option does not match global and is not a default value.
    -- Check if it was set by a script in $VIMRUNTIME.
    local info = vim.api.nvim_get_option_info2(option, { scope = "local" })
    ---@param e vim.fn.getscriptinfo.ret
    local scriptinfo = vim.tbl_filter(function(e)
      return e.sid == info.last_set_sid
    end, vim.fn.getscriptinfo())
    local by_rtp = #scriptinfo == 1 and vim.startswith(scriptinfo[1].name, vim.fn.expand("$VIMRUNTIME"))
    if not by_rtp then
      return false
    end
  end
  vim.api.nvim_set_option_value(option, value, { scope = "local" })
  return true
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
