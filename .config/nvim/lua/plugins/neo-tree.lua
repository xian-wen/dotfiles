return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    { "<Leader>e", "<Leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
    { "<Leader>E", "<Leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    {
      "<Leader>fe",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = require("util").root(),
          reveal_force_cwd = true,
        })
      end,
      desc = "Explorer NeoTree (Root Dir)",
    },
    {
      "<Leader>fE",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = vim.uv.cwd(),
        })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    {
      "<Leader>ge",
      function()
        require("neo-tree.command").execute({
          source = "git_status",
          toggle = true,
        })
      end,
      desc = "Git Explorer",
    },
    {
      "<Leader>be",
      function()
        require("neo-tree.command").execute({
          source = "buffers",
          toggle = true,
        })
      end,
      desc = "Buffer Explorer",
    },
  },
  opts = {
    default_component_configs = {
      indent = { with_expanders = true },
      icon = {
        folder_empty = "",
        folder_empty_open = "",
        default = "󰈙",
      },
    },
    window = {
      width = 30,
      auto_expand_width = true,
      mappings = {
        ["<Space>"] = "none",
        ["l"] = "open",
        ["h"] = "close_node",
        ["a"] = {
          "add",
          config = { show_path = "relative" },
        },
        ["P"] = {
          "toggle_preview",
          config = { use_float = false },
        },
        ["O"] = {
          function(state)
            local node = state.tree:get_node()
            require("lazy.util").open(node.path, { system = true })
          end,
          desc = "Open with System Application",
        },
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            vim.fn.setreg("+", node.path, "c")
          end,
          desc = "Copy Path to Clipboard",
        },
      },
    },
    filesystem = {
      bind_to_cwd = false,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      use_libuv_file_watcher = true,
    },
    buffers = { show_unloaded = true },
  },
}
