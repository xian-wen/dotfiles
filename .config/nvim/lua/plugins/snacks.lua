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
    { "<C-_>", "<Leader>ft", desc = "which_key_ignore", remap = true },
    { "<C-/>", "<C-_>", desc = "Terminal (Root Dir)", remap = true },
    { "<C-_>", "<Cmd>close<CR>", mode = "t", desc = "which_key_ignore" },
    { "<C-/>", "<C-_>", mode = "t", desc = "Hide Terminal", remap = true },
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
          open = function(url)
            vim.fn.setreg("+", url)
          end,
          notify = false,
        })
      end,
      mode = { "n", "x" },
      desc = "Git Browse (copy)",
    },
    -- Indent
    {
      "<Leader>ug",
      function()
        if Snacks.indent.enabled then
          Snacks.indent.disable()
        else
          Snacks.indent.enable()
        end
      end,
      desc = "Toggle Indent Guides",
    },
    -- Lazygit
    {
      "<Leader>gg",
      function()
        Snacks.lazygit({ cwd = require("util").git_root() })
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
        Snacks.lazygit.log({ cwd = require("util").git_root() })
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
    -- Notifier
    {
      "<Leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<Leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    -- Scratch
    {
      "<Leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<Leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    -- Terminal
    {
      "<Leader>ft",
      function()
        Snacks.terminal(nil, { cwd = require("util").root() })
      end,
      desc = "Terminal (Root Dir)",
    },
    {
      "<Leader>fT",
      function()
        Snacks.terminal()
      end,
      desc = "Terminal (cwd)",
    },
    -- Zen
    {
      "<Leader>uz",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<Leader>uZ",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    -- Neovim News
    {
      "<Leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
  },
  opts = {
    bigfile = {},
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
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = "<Leader>ff" },
          { icon = " ", key = "n", desc = "New File", action = "<Leader>bn" },
          { icon = " ", key = "g", desc = "Find Text", action = "<Leader>sg" },
          { icon = " ", key = "r", desc = "Recent Files", action = "<Leader>fr" },
          { icon = " ", key = "c", desc = "Config", action = "<Leader>fc" },
          { icon = " ", key = "s", desc = "Restore Session", action = "<Leader>qs" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = "<Leader>L" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    gitbrowse = {
      config = function(opts)
        table.insert(opts.remote_patterns, 1, { "^ssh://git@ssh%.(.*)$", "https://%1" })
      end,
    },
    indent = {
      animate = { enabled = false },
    },
    lazygit = {},
    notifier = {},
    quickfile = {},
    scratch = {},
    statuscolumn = {},
    terminal = {
      win = {
        keys = {
          -- nav_<dir> cannot be avoided, otherwise <Esc><Esc> cannot be back to normal mode.
          nav_h = { "<C-h>", term_nav("h"), mode = "t", expr = true, desc = "Go to Left Window" },
          nav_j = { "<C-j>", term_nav("j"), mode = "t", expr = true, desc = "Go to Lower Window" },
          nav_k = { "<C-k>", term_nav("k"), mode = "t", expr = true, desc = "Go to Upper Window" },
          nav_l = { "<C-l>", term_nav("l"), mode = "t", expr = true, desc = "Go to Right Window" },
        },
      },
    },
    words = {},
    zen = {
      -- Full screen.
      win = {
        width = 0,
        height = 0,
      },
    },
  },
}
