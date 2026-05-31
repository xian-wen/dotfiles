return {
  {
    "folke/sidekick.nvim",
    keys = {
      {
        "<Tab>",
        function()
          -- If there is a next edit suggestion (NES), jump to it, otherwise apply it if any.
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Sidekick NES",
      },
      {
        "<C-.>",
        function()
          require("sidekick.cli").focus()
        end,
        mode = { "n", "t", "i", "x" },
        desc = "Sidekick Focus",
      },
      { "<Leader>a", "", mode = { "n", "v" }, desc = "+ai" },
      {
        "<Leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<Leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      {
        "<Leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<Leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      {
        "<Leader>as",
        function()
          require("sidekick.cli").select()
          -- Or to select only installed tools:
          -- require("sidekick.cli").select({ filter = { installed = true } })
        end,
        desc = "Select CLI",
      },
      {
        "<Leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "n", "x" },
        desc = "Send This",
      },
      {
        "<Leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
    },
    opts = function()
      Snacks.toggle({
        name = "Sidekick NES",
        get = function()
          return require("sidekick.nes").enabled
        end,
        set = function(state)
          require("sidekick.nes").enable(state)
        end,
      }):map("<Leader>uS")
    end,
  },

  -- copilot-language-server
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local sk = require("util").opts("sidekick.nvim")
      if vim.tbl_get(sk, "nes", "enabled") ~= false then
        opts.servers = opts.servers or {}
        opts.servers.copilot = opts.servers.copilot or {}
      end
    end,
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local icons = require("config").icons
      local copilot_icons = {
        Error = { " ", "DiagnosticError" },
        Inactive = { " ", "MsgArea" },
        Warning = { " ", "DiagnosticWarn" },
        Normal = { icons.ai.copilot, "Special" },
      }
      -- Copilot status
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local status = require("sidekick.status").get()
          return status and vim.tbl_get(copilot_icons, status.kind, 1)
        end,
        cond = function()
          return require("sidekick.status").get() ~= nil
        end,
        color = function()
          local status = require("sidekick.status").get()
          local hl = status and (status.busy and "DiagnosticWarn" or vim.tbl_get(copilot_icons, status.kind, 2))
          return { fg = Snacks.util.color(hl) }
        end,
      })
      -- Cli session status
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local status = require("sidekick.status").cli()
          return icons.ai.sidekick .. (#status > 1 and #status or "")
        end,
        cond = function()
          return #require("sidekick.status").cli() > 0
        end,
        color = function()
          return { fg = Snacks.util.color("Special") }
        end,
      })
    end,
  },

  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              ["<A-a>"] = { "sidekick_send", mode = { "n", "i" } },
            },
          },
        },
        actions = {
          sidekick_send = function(...)
            return require("sidekick.cli.picker.snacks").send(...)
          end,
        },
      },
    },
  },
}
