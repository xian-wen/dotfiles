return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "mason-lspconfig.nvim",
  },
  -- Same as LazyFile.
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts_extend = { "servers.*.keys" },
  opts = function()
    local icons = require("config").icons.diagnostics
    return {
      -- Options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
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
      folds = { enabled = true },
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
      -- Set the default configuration for an LSP client (or all clients if the special name "*" is used).
      servers = {
        -- Configuration for all LSP servers
        ["*"] = {
          capabilities = {
            workspace = {
              fileOperations = {
                didRename = true,
                willRename = true,
              },
            },
          },
          keys = {
            { "gd", vim.lsp.buf.definition, desc = "Go to Definition", has = "definition" },
            { "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
            { "gI", vim.lsp.buf.implementation, desc = "Go to Implementation" },
            { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
            { "gy", vim.lsp.buf.type_definition, desc = "Go to T[y]pe Definition" },
            { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
            { "<C-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
            { "<Leader>ci", "<Cmd>LspInfo<CR>", desc = "LSP Info" },
            { "<Leader>ca", vim.lsp.buf.code_action, mode = { "n", "x" }, desc = "Code Action", has = "codeAction" },
            { "<Leader>cl", vim.lsp.codelens.run, mode = { "n", "x" }, desc = "Run Codelens", has = "codeLens" },
            { "<Leader>cL", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", has = "codeLens" },
            { "<Leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
          },
        },
        -- stylua is now also an LSP.
        stylua = { enabled = false },
        -- Ref: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
        -- Ref: https://luals.github.io/wiki/settings
        lua_ls = {
          -- mason = false, -- set to false to not use mason to install
          -- keys = {}, -- add any additional keymaps for specific lsp servers
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
      ---@type table<string, fun(server: string, opts: vim.lsp.Config): boolean?>
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
  config = vim.schedule_wrap(function(_, opts)
    -- Keymaps
    for server, server_opts in pairs(opts.servers) do
      if type(server_opts) == "table" and server_opts.keys then
        require("util.lsp").map({ name = server ~= "*" and server or nil }, server_opts.keys)
      end
    end

    -- Inlay hints
    if opts.inlay_hints.enabled then
      Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
        if
          vim.api.nvim_buf_is_valid(buffer)
          and vim.bo[buffer].buftype == ""
          and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
        then
          vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end
      end)
    end

    -- Folds
    if opts.folds.enabled then
      Snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function()
        local util = require("util")
        if util.set_default("foldmethod", "expr") then
          util.set_default("foldexpr", "v:lua.vim.lsp.foldexpr()")
        end
      end)
    end

    -- Code lens
    if opts.codelens.enabled and vim.lsp.codelens then
      Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = buffer,
          callback = vim.lsp.codelens.refresh,
        })
      end)
    end

    -- Diagnostics
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    -- Capabilities
    if opts.capabilities then
      opts.servers["*"] = vim.tbl_deep_extend("force", opts.servers["*"] or {}, {
        capabilities = opts.capabilities,
      })
    end

    if opts.servers["*"] then
      vim.lsp.config("*", opts.servers["*"])
    end

    -- Get all the servers that are available through mason-lspconfig.
    local have_mason = require("util").has("mason-lspconfig.nvim")
    local mason_all = have_mason
        and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
      or {} --[[ @as string[] ]]
    local mason_exclude = {} ---@type string[]

    ---@return boolean? exclude automatic setup
    local configure = function(server)
      if server == "*" then
        return false
      end
      local sopts = opts.servers[server]
      sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts
      if sopts.enabled == false then
        mason_exclude[#mason_exclude + 1] = server
        return
      end
      local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
      local setup = opts.setup[server] or opts.setup["*"]
      if setup and setup(server, sopts) then
        mason_exclude[#mason_exclude + 1] = server
      else
        vim.lsp.config(server, sopts) -- configure the server
        if not use_mason then
          vim.lsp.enable(server)
        end
      end
      return use_mason
    end

    local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
    if have_mason then
      require("mason-lspconfig").setup({
        ensure_installed = vim.list_extend(
          install,
          require("util").opts("mason-lspconfig.nvim").ensure_installed or {}
        ),
        automatic_enable = { exclude = mason_exclude },
      })
    end
  end),
}
