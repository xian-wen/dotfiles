return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    -- Hide the statusline on the starter page.
    vim.o.laststatus = 0
  end,
  opts = function()
    local icons = require("config").icons
    return {
      options = {
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "snacks_dashboard" },
        },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return icons.vim .. str
            end,
          },
        },
        lualine_b = {
          "branch",
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.ERROR,
              warn = icons.diagnostics.WARN,
              info = icons.diagnostics.INFO,
              hint = icons.diagnostics.HINT,
            },
          },
        },
      },
    }
  end,
}
