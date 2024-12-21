return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  keys = {
    -- Aliases
    { "<C-_>", "<Leader>ft", mode = { "n", "t" }, desc = "which_key_ignore", remap = true },
    { "<C-/>", "<C-_>", mode = { "n", "t" }, desc = "Terminal (Root Dir)", remap = true },
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
    statuscolumn = {},
    terminal = {},
  },
}
