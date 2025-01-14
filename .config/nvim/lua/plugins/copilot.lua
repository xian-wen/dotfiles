return {
  {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
      filetypes = { markdown = true },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        opts = {},
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 1,
      })
    end,
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
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        mode = { "n", "v" },
        desc = "Prompt Actions (CopilotChat)",
      },
      {
        "<Leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
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
