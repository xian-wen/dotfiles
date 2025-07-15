return {
  {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    cond = vim.g.ai_cmp == "copilot",
    event = "BufReadPost",
    cmd = "Copilot",
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    build = "make tiktoken",
    cmd = "CopilotChat",
    keys = {
      { "<Leader>C", "<Leader>aa", mode = { "n", "v" }, desc = "CopilotChat", remap = true },
      { "<Leader>a", "", mode = { "n", "v" }, desc = "+ai" },
      {
        "<Leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        mode = { "n", "v" },
        desc = "Toggle (CopilotChat)",
      },
      {
        "<Leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        mode = { "n", "v" },
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
        mode = { "n", "v" },
        desc = "Quick Chat (CopilotChat)",
      },
    },
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        window = { width = 0.4 },
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
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
}
