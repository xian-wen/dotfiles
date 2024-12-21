return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  keys = {
    -- Aliases
    { "<Leader>G", "<Leader>gg", desc = "Lazygit (Root Dir)", remap = true },
    { "<C-_>", "<Leader>ft", mode = { "n", "t" }, desc = "which_key_ignore", remap = true },
    { "<C-/>", "<C-_>", mode = { "n", "t" }, desc = "Terminal (Root Dir)", remap = true },
    -- Lazygit
    {
      "<Leader>gg",
      function()
        Snacks.lazygit({ cwd = Snacks.git.get_root() })
      end,
      desc = "Lazygit (Root Dir)",
    },
    {
      "<Leader>gG",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit (cwd)",
    },
    {
      "<Leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<Leader>gl",
      function()
        Snacks.lazygit.log({ cwd = Snacks.git.get_root() })
      end,
      desc = "Lazygit Log (Root Dir)",
    },
    {
      "<Leader>gL",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
    -- Terminal
    {
      "<Leader>ft",
      function()
        Snacks.terminal(nil, { cwd = Snacks.git.get_root() })
      end,
      mode = { "n", "t" },
      desc = "Terminal (Root Dir)",
    },
    {
      "<Leader>fT",
      function()
        Snacks.terminal()
      end,
      mode = { "n", "t" },
      desc = "Terminal (cwd)",
    },
  },
  opts = {
    dashboard = {
      preset = {
        header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
        ]],
      },
    },
      },
    },
    lazygit = {},
    statuscolumn = {},
    terminal = {},
  },
}
