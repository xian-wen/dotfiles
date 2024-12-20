return {
  {
    "echasnovski/mini.icons",
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      mappings = {
        ["<"] = {
          action = "open",
          pair = "<>",
          neigh_pattern = "[^\\].",
        },
        [">"] = {
          action = "close",
          pair = "<>",
          neigh_pattern = "[^\\].",
        },
      },
    },
  },

  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",

        suffix_next = 'n',
        suffix_last = 'p',
      },
    },
  },
}
