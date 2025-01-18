return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = false,
      },
      -- transparent_mode = true,
    },
  },

  {
    "navarasu/onedark.nvim",
    opts = {
      style = "deep", -- dark/darker/cool/deep/warm/warmer/light
      -- transparent = true,
      -- lualine = {
      --   transparent = true,
      -- },
    },
  },

  {
    "sainnhe/sonokai",
    init = function()
      local g = vim.g
      g.sonokai_style = "maia" -- default/atlantis/andromeda/shusia/maia/espresso
      -- g.sonokai_transparent_background = 1
      g.sonokai_better_performance = 1
    end,
    opts = {},
  },

  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night", -- moon/storm/night/day
      -- transparent = true,
      -- styles = {
      --   sidebars = "transparent", -- dark/transparent/normal
      --   floats = "transparent", -- dark/transparent/normal
      -- },
    },
  },
}
