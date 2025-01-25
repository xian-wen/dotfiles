return {
  "CopilotC-Nvim/CopilotChat.nvim",
  keys = {
    {
      "<Leader>C",
      function()
        return require("CopilotChat").toggle()
      end,
      mode = { "n", "v" },
      desc = "Toggle (CopilotChat)",
    },
  },
}
