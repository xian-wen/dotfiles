return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
    opts_extend = {
      "sources.default",
      "sources.compat",
    },
    opts = {
      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept", "fallback" },
        cmdline = { preset = "super-tab" },
      },
      completion = {
        menu = {
          draw = {
            -- Use treesitter to highlight the label text.
            treesitter = { "lsp" },
            -- nvim-cmp style menu
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        -- Add any nvim-cmp sources here to enable them with blink.compat.
        compat = {},
        min_keyword_length = function(ctx)
          -- Disable menu popup when typing abbreviations like `:xa`.
          return ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil and 3 or 0
        end,
      },
    },
    config = function(_, opts)
      -- Setup compat sources.
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend("force", {
          name = source,
          module = "blink.compat.source",
        }, opts.sources.providers[source] or {})
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end
      -- Unset custom prop to pass blink.cmp validation.
      opts.sources.compat = nil

      -- Check if we need to override symbol kinds.
      for _, provider in pairs(opts.sources.providers or {}) do
        if provider.kind then
          local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1
          CompletionItemKind[kind_idx] = provider.kind
          CompletionItemKind[provider.kind] = kind_idx
          local transform_items = provider.transform_items
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = kind_idx or item.kind
            end
            return items
          end
          -- Unset custom prop to pass blink.cmp validation.
          provider.kind = nil
        end
      end

      -- Add icons.
      opts.appearance = opts.appearance or {}
      opts.appearance.kind_icons =
        vim.tbl_extend("force", opts.appearance.kind_icons or {}, require("config").icons.kinds)

      require("blink.cmp").setup(opts)
    end,
  },

  {
    "saghen/blink.compat",
    version = "*",
    opts = {},
  },
}
