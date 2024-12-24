-- Terminal Mappings
local function term_nav(dir)
  return function(self)
    return self:is_floating() and "<C-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  keys = {
    -- Aliases
    { "<Leader>G", "<Leader>gg", desc = "Lazygit (Root Dir)", remap = true },
    { "<C-_>", "<Leader>ft", mode = { "n", "t" }, desc = "which_key_ignore", remap = true },
    { "<C-/>", "<C-_>", mode = { "n", "t" }, desc = "Terminal (Root Dir)", remap = true },
    -- Gitbrowse
    {
      "<Leader>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<Leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      mode = { "n", "x" },
      desc = "Git Browse (open)",
    },
    {
      "<Leader>gY",
      function()
        Snacks.gitbrowse({
          open = function(url) vim.fn.setreg("+", url) end,
          notify = false,
        })
      end,
      mode = { "n", "x" },
      desc = "Git Browse (copy)",
    },
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
    gitbrowse = {
      config = function(opts, defaults)
        table.insert(opts.remote_patterns, 1, { "^ssh://git@ssh%.(.*)$", "https://%1" })
      end,
    },
    indent = {
      animate = { enabled = false },
    },
    lazygit = {},
    statuscolumn = {},
    terminal = {
      win = {
        keys = {
          nav_h = { "<C-h>", term_nav("h"), mode = "t", expr = true, desc = "Go to Left Window" },
          nav_j = { "<C-j>", term_nav("j"), mode = "t", expr = true, desc = "Go to Lower Window" },
          nav_k = { "<C-k>", term_nav("k"), mode = "t", expr = true, desc = "Go to Upper Window" },
          nav_l = { "<C-l>", term_nav("l"), mode = "t", expr = true, desc = "Go to Right Window" },
        },
      },
    },
  },
}
