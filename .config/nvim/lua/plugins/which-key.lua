return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<Leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Keymaps (which-key)",
    },
    {
      "<C-w><Space>",
      function()
        require("which-key").show({ keys = "<C-w>", loop = true })
      end,
      desc = "Window Hydra Mode (which-key)",
    },
  },
  -- Automatically merge specs defined in other files.
  opts_extend = { "spec" },
  opts = {
    preset = "helix", -- false/classic/modern/helix
    spec = {
      {
        mode = { "n", "v" },
        { "<Leader><Tab>", group = "tabs" },
        { "<Leader>c", group = "code" },
        { "<Leader>d", group = "debug" },
        { "<Leader>dp", group = "profiler" },
        { "<Leader>f", group = "file/find" },
        { "<Leader>g", group = "git" },
        { "<Leader>gh", group = "hunks" },
        { "<Leader>q", group = "quit/session" },
        { "<Leader>s", group = "search" },
        { "<Leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<Leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
        { "]", group = "next" },
        { "[", group = "prev" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
        {
          "<Leader>b",
          group = "buffers",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        {
          "<Leader>w",
          group = "windows",
          proxy = "<C-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
        -- Better descriptions
        { "gx", desc = "Open with system app" },
      },

      {
        -- mode = { "n" },
        -- File in argument list
        { "]a", desc = "Next Arg File" },
        { "[a", desc = "Prev Arg File" },
        { "]A", desc = "Last Arg File" },
        { "[A", desc = "First Arg File" },
        -- Buffer
        -- { "]b", desc = "Next Buffer" },
        -- { "[b", desc = "Prev Buffer" },
        { "]B", desc = "Last Buffer" },
        { "[B", desc = "First Buffer" },
        -- Diagnostic
        -- { "]d", desc = "Next Diagnostic" },
        -- { "[d", desc = "Prev Diagnostic" },
        { "]D", desc = "Last Diagnostic" },
        { "[D", desc = "First Diagnostic" },
        -- Location List
        { "]l", desc = "Next Location" },
        { "[l", desc = "Prev Location" },
        { "]L", desc = "Last Location" },
        { "[L", desc = "First Location" },
        { "]<C-l>", desc = "Next Location File" },
        { "[<C-l>", desc = "Prev Location File" },
        -- Quickfix List
        { "]q", desc = "Next Quickfix" },
        { "[q", desc = "Prev Quickfix" },
        { "]Q", desc = "Last Quickfix" },
        { "[Q", desc = "First Quickfix" },
        { "]<C-q>", desc = "Next Quickfix File" },
        { "[<C-q>", desc = "Prev Quickfix File" },
        -- Tag
        -- { "]t", desc = "Next Tag" },
        -- { "[t", desc = "Prev Tag" },
        { "]T", desc = "Last Tag" },
        { "[T", desc = "First Tag" },
        { "]<C-t>", desc = "Next Tag Preview" },
        { "[<C-t>", desc = "Prev Tag Preview" },
        -- LSP
        { "K", desc = "Hover" },
      },
    },
  },
}
