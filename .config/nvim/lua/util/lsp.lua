local M = {}

---@param fn fun(client: vim.lsp.Client, bufnr: integer)
---@param name? string
function M.on_attach(fn, name)
  return vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (not name or client.name == name) then
        return fn(client, bufnr)
      end
    end,
  })
end

---@param fn fun(client: vim.lsp.Client, bufnr: integer): boolean?
---@param opts? { group?: integer }
M.on_dynamic_capability = function(fn, opts)
  return vim.api.nvim_create_autocmd("User", {
    pattern = "LspDynamicCapability",
    group = opts and opts.group or nil,
    callback = function(args)
      local bufnr = args.data.bufnr
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        return fn(client, bufnr)
      end
    end,
  })
end

---@type table<string, table<vim.lsp.Client, table<number, boolean>>>
M._supports_method = {}

---@param method string
---@param fn fun(client: vim.lsp.Client, bufnr: integer)
M.on_supports_method = function(method, fn)
  -- __mode = "k" means weak key in table, see :h __mode
  M._supports_method[method] = M._supports_method[method] or setmetatable({}, { __mode = "k" })
  return vim.api.nvim_create_autocmd("User", {
    pattern = "LspSupportsMethod",
    callback = function(args)
      local bufnr = args.data.bufnr
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and method == args.data.method then
        return fn(client, bufnr)
      end
    end,
  })
end

---@param client vim.lsp.Client
---@param bufnr integer
M._check_methods = function(client, bufnr)
  -- Don't trigger on invalid buffers.
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  -- Don't trigger on non-listed buffers.
  if not vim.bo[bufnr].buflisted then
    return
  end
  -- Don't trigger on nofile buffers.
  if vim.bo[bufnr].buftype == "nofile" then
    return
  end
  for method, clients in pairs(M._supports_method) do
    clients[client] = clients[client] or {}
    if not clients[client][bufnr] then
      if client.supports_method and client:supports_method(method, bufnr) then
        clients[client][bufnr] = true
        vim.api.nvim_exec_autocmds("User", {
          pattern = "LspSupportsMethod",
          data = {
            client_id = client.id,
            bufnr = bufnr,
            method = method,
          },
        })
      end
    end
  end
end

M.setup = function()
  local register_capability = vim.lsp.handlers["client/registerCapability"]
  vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
    local ret = register_capability(err, res, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client then
      for bufnr in pairs(client.attached_buffers) do
        vim.api.nvim_exec_autocmds("User", {
          pattern = "LspDynamicCapability",
          data = {
            client_id = client.id,
            bufnr = bufnr,
          },
        })
      end
    end
    return ret
  end
  M.on_attach(M._check_methods)
  M.on_dynamic_capability(M._check_methods)
end

return M
