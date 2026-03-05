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

return M
