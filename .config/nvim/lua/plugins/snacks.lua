return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  keys = {
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
    { "<C-_>", "<Leader>ft", mode = { "n", "t" }, desc = "which_key_ignore", remap = true },
    { "<C-/>", "<C-_>", mode = { "n", "t" }, desc = "Terminal (Root Dir)", remap = true },
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
    statuscolumn = {},
    terminal = {
      win = {
        keys = {
          { "<Esc>", [[<C-\><C-n>]], mode = "t" },
        },
      },
    },
  },
}
