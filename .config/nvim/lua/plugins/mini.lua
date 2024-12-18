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
          register = { cr = false },
        },
        [">"] = {
          action = "close",
          pair = "<>",
          neigh_pattern = "[^\\].",
          register = { cr = false },
        },
      },
    },
  },
}
