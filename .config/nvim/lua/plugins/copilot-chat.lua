return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    build = "make tiktoken",
    cmd = "CopilotChat",
    keys = {
      { "<Leader>C", "<Leader>aa", mode = { "n", "x" }, desc = "CopilotChat", remap = true },
      { "<Leader>a", "", mode = { "n", "x" }, desc = "+ai" },
      {
        "<Leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        mode = { "n", "x" },
        desc = "Toggle (CopilotChat)",
      },
      {
        "<Leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        mode = { "n", "x" },
        desc = "Prompt Actions (CopilotChat)",
      },
      {
        "<Leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        mode = { "n", "x" },
        desc = "Quick Chat (CopilotChat)",
      },
      {
        "<Leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        mode = { "n", "x" },
        desc = "Clear (CopilotChat)",
      },
    },
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        window = { width = 0.4 },
        headers = {
          user = "  " .. user .. " ",
          assistant = "  Copilot ",
          tool = "󰊳  Tool ",
        },
      }
    end,
    config = function(_, opts)
      require("CopilotChat").setup(opts)
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end,
      })
    end,
  },

  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        providers = {
          path = {
            -- Path sources triggered by "/" interfere with CopilotChat commands.
            enabled = function()
              return vim.bo.filetype ~= "copilot-chat"
            end,
          },
        },
      },
    },
  },
}
