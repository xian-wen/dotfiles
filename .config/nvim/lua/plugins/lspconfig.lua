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
        -- stylua is now also an LSP.
        stylua = {},
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
  config = vim.schedule_wrap(function(_, opts)
    local lsp = require("util.lsp")
    lsp.setup()

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
      map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
      map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
      map("n", "<Leader>ci", "<Cmd>LspInfo<CR>", "LSP Info")
      map({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, "Code Action")
      map({ "n", "v" }, "<Leader>cl", vim.lsp.codelens.run, "Run Codelens")
      map("n", "<Leader>cL", vim.lsp.codelens.refresh, "Refresh & Display Codelens")
      map("n", "<Leader>cr", vim.lsp.buf.rename, "Rename")
    end
    lsp.on_attach(keymaps_on_attach)
    -- Avoid setup keymaps multiple times.
    -- lsp.on_dynamic_capability(keymaps_on_attach)

    -- Inlay hints
    if opts.inlay_hints.enabled then
      lsp.on_supports_method("textDocument/inlayHint", function(_, bufnr)
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
      lsp.on_supports_method("textDocument/codeLens", function(_, bufnr)
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          buffer = bufnr,
          callback = vim.lsp.codelens.refresh,
        })
      end)
    end

    -- Diagnostics
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    -- Capabilities
    if opts.capabilities then
      vim.lsp.config("*", { capabilities = opts.capabilities })
    end

    -- Get all the servers that are available through mason-lspconfig.
    local have_mason = require("util").has("mason-lspconfig.nvim")
    local mason_all = have_mason
        and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
      or {}
    local mason_exclude = {}

    ---@return boolean? exclude automatic setup
    local configure = function(server)
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
