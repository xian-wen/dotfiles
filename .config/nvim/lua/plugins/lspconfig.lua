return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "mason-lspconfig.nvim",
  },
  -- Same as LazyFile.
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = function()
    local icons = require("config").icons.diagnostics
    return {
      diagnostics = {
        virtual_text = {
          -- Only show sources if there is more than one source of diagnostics in the buffer.
          source = "if_many",
          spacing = 4,
          prefix = function(diagnostic)
            return icons[vim.diagnostic.severity[diagnostic.severity]]
          end,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.ERROR,
            [vim.diagnostic.severity.WARN] = icons.WARN,
            [vim.diagnostic.severity.INFO] = icons.INFO,
            [vim.diagnostic.severity.HINT] = icons.HINT,
          },
        },
        -- Order: ERROR, WARN, INFO, HINT.
        severity_sort = true,
      },
      inlay_hints = {
        enabled = true,
        exclude = {},
      },
      codelens = { enabled = false },
      -- Global capabilities
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      -- LSP server settings
      servers = {
        -- Ref: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
        -- Ref: https://luals.github.io/wiki/settings
        lua_ls = {
          -- mason = false,
          -- keys = {},
          settings = {
            Lua = {
              diagnostics = {
                -- Avoid missing required fields warnnings.
                disable = { "missing-fields" },
              },
              hint = {
                enable = true,
                arrayIndex = "Disable",
              },
            },
          },
        },
      },
      -- Additional LSP server setup
      -- Return true for server not to be setup with lspconfig.
      setup = {
        -- Example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * as a fallback for any server.
        -- ["*"] = function(server, opts) end,
      },
    }
  end,
  config = function(_, opts)
    local on_attach = function(fn, name)
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

    local on_progress = function(fn)
      return vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params.value
          if client and type(value) == "table" then
            return fn(client, value)
          end
        end,
      })
    end

    local on_dynamic_capability = function(fn, options)
      return vim.api.nvim_create_autocmd("User", {
        pattern = "LspDynamicCapability",
        group = options and options.group or nil,
        callback = function(args)
          local bufnr = args.data.bufnr
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            return fn(client, bufnr)
          end
        end,
      })
    end

    local _supports_method = {}
    local on_supports_method = function(method, fn)
      -- __mode = "k" means weak key in table, see :h __mode
      _supports_method[method] = _supports_method[method] or setmetatable({}, { __mode = "k" })
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

    local _check_methods = function(client, bufnr)
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
      if not vim.bo[bufnr].buflisted then
        return
      end
      if vim.bo[bufnr].buftype == "nofile" then
        return
      end
      for method, clients in pairs(_supports_method) do
        clients[client] = clients[client] or {}
        if not clients[client][bufnr] then
          if client.supports_method and client.supports_method(method, { bufnr = bufnr }) then
            clients[client][bufnr] = true
            vim.api.nvim_exec_autocmds("User", {
              pattern = "LspSupportsMethod",
              data = { client_id = client.id, bufnr = bufnr, method = method },
            })
          end
        end
      end
    end

    -- LSP setup
    local register_capability = vim.lsp.handlers["client/registerCapability"]
    vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
      local ret = register_capability(err, res, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if client then
        for bufnr in pairs(client.attached_buffers) do
          vim.api.nvim_exec_autocmds("User", {
            pattern = "LspDynamicCapability",
            data = { client_id = client.id, bufnr = bufnr },
          })
        end
      end
      return ret
    end
    on_attach(_check_methods)
    on_dynamic_capability(_check_methods)

    -- Keymaps
    local keymaps_on_attach = function(_, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end
      -- The following keymaps are replaced with those of picker (telescope/fzf-lua/Snacks.picker).
      -- map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
      -- map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
      -- map("n", "gI", vim.lsp.buf.implementation, "Go to Implementation")
      -- map("n", "gr", vim.lsp.buf.references, "References")
      -- map("n", "gy", vim.lsp.buf.type_definition, "Go to T[y]pe Definition")
      map("n", "K", vim.lsp.buf.hover, "Hover")
      map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
      map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
      map({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, "Code Action")
      map({ "n", "v" }, "<Leader>cl", vim.lsp.codelens.run, "Run Codelens")
      map("n", "<Leader>cL", vim.lsp.codelens.refresh, "Refresh & Display Codelens")
      map("n", "<Leader>ci", "<Cmd>LspInfo<CR>", "Lsp Info")
      map("n", "<Leader>cr", vim.lsp.buf.rename, "Rename")
    end
    on_attach(keymaps_on_attach)
    on_dynamic_capability(keymaps_on_attach)

    -- LSP progress
    -- Ref: https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md#-examples
    on_progress(function(client, value)
      local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
        id = "lsp_progress",
        title = client.name,
        opts = function(notif)
          notif.icon = value.kind == "end" and " "
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end)

    -- Diagnostics
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    -- Inlay hints
    if opts.inlay_hints.enabled then
      on_supports_method("textDocument/inlayHint", function(_, bufnr)
        if
          vim.api.nvim_buf_is_valid(bufnr)
          and vim.bo[bufnr].buftype == ""
          and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[bufnr].filetype)
        then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end)
    end

    -- Code lens
    if opts.codelens.enabled and vim.lsp.codelens then
      on_supports_method("textDocument/codeLens", function(_, bufnr)
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = bufnr,
          callback = vim.lsp.codelens.refresh,
        })
      end)
    end

    -- LSP server setup
    local servers = opts.servers
    local has_blink, blink = pcall(require, "blink.cmp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_blink and blink.get_lsp_capabilities() or {},
      opts.capabilities or {}
    )

    local setup = function(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, servers[server] or {})
      if server_opts.enabled == false then
        return
      end
      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end
      require("lspconfig")[server].setup(server_opts)
    end

    -- Get all the servers that are available through mason-lspconfig.
    local has_mason, mlsp = pcall(require, "mason-lspconfig")
    local all_mslp_servers = {}
    if has_mason then
      all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
    end

    local ensure_installed = {}
    for server, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        if server_opts.enabled ~= false then
          -- Run manual setup if mason=false or if server cannot be installed with mason-lspconfig.
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end
    end

    if has_mason then
      mlsp.setup({
        ensure_installed = vim.tbl_deep_extend("force", ensure_installed, mlsp.ensure_installed or {}),
        handlers = { setup },
      })
    end
  end,
}
