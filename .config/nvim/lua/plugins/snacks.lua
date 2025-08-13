-- Terminal mappings
local function term_nav(dir)
  return function(self)
    return self:is_floating() and "<C-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bigfile = {},
      input = {},
      quickfile = {},
      statuscolumn = {},
    },
  },

  -- Dashboard
  {
    "folke/snacks.nvim",
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
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = "<Leader>ff" },
            { icon = " ", key = "n", desc = "New File", action = "<Leader>bn" },
            { icon = " ", key = "p", desc = "Projects", action = "<Leader>fp" },
            { icon = " ", key = "g", desc = "Find Text", action = "<Leader>sg" },
            { icon = " ", key = "r", desc = "Recent Files", action = "<Leader>fr" },
            { icon = " ", key = "c", desc = "Config", action = "<Leader>fc" },
            { icon = " ", key = "s", desc = "Restore Session", action = "<Leader>qs" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = "<Leader>L" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },

  -- Explorer
  {
    "folke/snacks.nvim",
    keys = {
      { "<Leader>e", "<Leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
      { "<Leader>E", "<Leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
      {
        "<Leader>fe",
        function()
          Snacks.picker.explorer({ cwd = require("util").root() })
        end,
        desc = "Explorer Snacks (Root Dir)",
      },
      {
        "<Leader>fE",
        function()
          Snacks.picker.explorer()
        end,
        desc = "Explorer Snacks (cwd)",
      },
    },
    opts = {
      explorer = {},
      picker = {
        sources = {
          explorer = {
            hidden = true,
            layout = {
              preview = {
                enabled = false,
                main = true,
              },
            },
          },
        },
      },
    },
  },

  -- Gitbrowse
  {
    "folke/snacks.nvim",
    keys = {
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
    },
    opts = {
      gitbrowse = {
        config = function(opts)
          table.insert(opts.remote_patterns, 1, { "^ssh://git@ssh%.(.*)$", "https://%1" })
        end,
      },
    },
  },

  -- Indent
  {
    "folke/snacks.nvim",
    keys = {
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
    },
    opts = {
      indent = {
        enabled = false,
        animate = { enabled = false },
        filter = function(buf)
          local exclude = { "help" }
          return vim.g.snacks_indent ~= false
            and vim.b[buf].snacks_indent ~= false
            and vim.bo[buf].buftype == ""
            and not vim.tbl_contains(exclude, vim.bo[buf].filetype)
        end,
      },
    },
  },

  -- Lazygit
  {
    "folke/snacks.nvim",
    keys = {
      { "<Leader>G", "<Leader>gg", desc = "Lazygit (Root Dir)", remap = true },
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
    },
    opts = {
      lazygit = {},
    },
  },

  -- Notifier
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<Leader>uN",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
    },
    opts = {
      notifier = {},
    },
  },

  -- Picker
  {
    "folke/snacks.nvim",
    keys = {
      { "<Leader>,", "<Leader>fb", desc = "Buffers", remap = true },
      { "<Leader>/", "<Leader>sg", desc = "Grep (Root Dir)", remap = true },
      { "<Leader>:", "<Leader>sc", desc = "Command History", remap = true },
      {
        "<Leader><Space>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Files",
      },
      {
        "<Leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notifications",
      },
      -- Find
      {
        "<Leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<Leader>fB",
        function()
          Snacks.picker.buffers({
            hidden = true,
            nofile = true,
          })
        end,
        desc = "Buffers (all)",
      },
      {
        "<Leader>fc",
        function()
          Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "Config Files",
      },
      {
        "<Leader>ff",
        function()
          Snacks.picker.files({ cwd = require("util").root() })
        end,
        desc = "Files (Root Dir)",
      },
      {
        "<Leader>fF",
        function()
          Snacks.picker.files({ filter = { cwd = true } })
        end,
        desc = "Files (cwd)",
      },
      {
        "<Leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Git Files",
      },
      {
        "<Leader>fp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<Leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      {
        "<Leader>fR",
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = "Recent (cwd)",
      },
      -- Git
      {
        "<Leader>gb",
        function()
          Snacks.picker.git_log_line()
        end,
        desc = "Git Blame Line",
      },
      {
        "<Leader>gd",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (hunks)",
      },
      {
        "<Leader>gf",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git Log File",
      },
      {
        "<Leader>gl",
        function()
          Snacks.picker.git_log({ cwd = require("util").git_root() })
        end,
        desc = "Git Log (Root Dir)",
      },
      {
        "<Leader>gL",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Log (cwd)",
      },
      {
        "<Leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      {
        "<Leader>gS",
        function()
          Snacks.picker.git_stash()
        end,
        desc = "Git Stash",
      },
      -- Grep
      {
        "<Leader>sb",
        function()
          Snacks.picker.lines()
        end,
        desc = "Buffer Lines",
      },
      {
        "<Leader>sB",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep Buffers",
      },
      {
        "<Leader>sg",
        function()
          Snacks.picker.grep({ cwd = require("util").root() })
        end,
        desc = "Grep (Root Dir)",
      },
      {
        "<Leader>sG",
        function()
          Snacks.picker.grep({ filter = { cwd = true } })
        end,
        desc = "Grep (cwd)",
      },
      {
        "<Leader>sp",
        function()
          Snacks.picker.lazy()
        end,
        desc = "Lazy Plugin Specs",
      },
      {
        "<Leader>sw",
        function()
          Snacks.picker.grep_word({ cwd = require("util").root() })
        end,
        mode = { "n", "x" },
        desc = "Grep word (Root Dir)",
      },
      {
        "<Leader>sW",
        function()
          Snacks.picker.grep_word({ filter = { cwd = true } })
        end,
        mode = { "n", "x" },
        desc = "Grep word (cwd)",
      },
      -- Search
      {
        '<Leader>s"',
        function()
          Snacks.picker.registers()
        end,
        desc = "Registers",
      },
      {
        "<Leader>s/",
        function()
          Snacks.picker.search_history()
        end,
        desc = "Search History",
      },
      {
        "<Leader>sa",
        function()
          Snacks.picker.autocmds()
        end,
        desc = "Autocmds",
      },
      {
        "<Leader>sc",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<Leader>sC",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },
      {
        "<Leader>sd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<Leader>sD",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
      },
      {
        "<Leader>sh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help",
      },
      {
        "<Leader>sH",
        function()
          Snacks.picker.highlights()
        end,
        desc = "Highlights",
      },
      {
        "<Leader>si",
        function()
          Snacks.picker.icons()
        end,
        desc = "Icons",
      },
      {
        "<Leader>sj",
        function()
          Snacks.picker.jumps()
        end,
        desc = "Jumps",
      },
      {
        "<Leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<Leader>sl",
        function()
          Snacks.picker.loclist()
        end,
        desc = "Location List",
      },
      {
        "<Leader>sm",
        function()
          Snacks.picker.marks()
        end,
        desc = "Marks",
      },
      {
        "<Leader>sM",
        function()
          Snacks.picker.man()
        end,
        desc = "Man",
      },
      {
        "<Leader>sR",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      {
        "<Leader>sq",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix List",
      },
      {
        "<Leader>su",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undo",
      },
      -- LSP
      {
        "<Leader>cc",
        function()
          Snacks.picker.lsp_config()
        end,
        desc = "LSP Config",
      },
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "LSP Definitions",
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = "LSP Declarations",
      },
      {
        "gI",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "LSP Implementations",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "LSP References",
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "LSP T[y]pe Definitions",
      },
      {
        "<Leader>ss",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
      },
      {
        "<Leader>sS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
      },
      -- UI
      {
        "<Leader>uc",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorschemes",
      },
    },
    opts = {
      picker = {
        sources = {
          todo_comments = { show_empty = true },
        },
        win = {
          input = {
            keys = {
              ["<A-c>"] = { "toggle_cwd", mode = { "n", "i" } },
              ["<A-s>"] = { "flash", mode = { "n", "i" } },
              ["s"] = { "flash" },
              ["<A-t>"] = { "trouble_open", mode = { "n", "i" } },
            },
          },
        },
        actions = {
          toggle_cwd = function(picker)
            local root = require("util").root({ buf = picker.input.filter.current_buf })
            local cwd = vim.fs.normalize(vim.uv.cwd() or ".")
            local current = picker:cwd()
            picker:set_cwd(current == root and cwd or root)
            picker:find()
          end,
          flash = function(picker)
            require("flash").jump({
              pattern = "^",
              label = { after = { 0, 0 } },
              search = {
                mode = "search",
                exclude = {
                  function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                  end,
                },
              },
              action = function(match)
                local idx = picker.list:row2idx(match.pos[1])
                picker.list:_move(idx, true, true)
              end,
            })
          end,
          trouble_open = function(...)
            return require("trouble.sources.snacks").actions.trouble_open.action(...)
          end,
        },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    keys = {
      {
        "<Leader>st",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "Todo",
      },
      {
        "<Leader>sT",
        function()
          Snacks.picker.todo_comments({
            keywords = { "TODO", "FIX", "FIXME" },
          })
        end,
        desc = "Todo/Fix/Fixme",
      },
    },
  },

  -- Rename
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<Leader>cR",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File",
      },
    },
  },

  -- Scratch
  {
    "folke/snacks.nvim",
    keys = {
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
    },
    opts = {
      scratch = {},
    },
  },

  -- Terminal
  {
    "folke/snacks.nvim",
    keys = {
      { "<C-_>", "<Leader>ft", desc = "which_key_ignore", remap = true },
      { "<C-/>", "<C-_>", desc = "Terminal (Root Dir)", remap = true },
      { "<C-_>", "<Cmd>close<CR>", mode = "t", desc = "which_key_ignore" },
      { "<C-/>", "<C-_>", mode = "t", desc = "Hide Terminal", remap = true },
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
    },
    opts = {
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
    },
  },

  -- Win
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<Leader>N",
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
        desc = "Neovim News",
      },
    },
    opts = {
      win = {},
    },
  },

  -- Words
  {
    "folke/snacks.nvim",
    keys = {
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
      },
      {
        "<A-n>",
        function()
          Snacks.words.jump(vim.v.count1, true)
        end,
        desc = "Next Reference",
      },
      {
        "<A-p>",
        function()
          Snacks.words.jump(-vim.v.count1, true)
        end,
        desc = "Prev Reference",
      },
    },
    opts = {
      words = {},
    },
  },

  -- Zen
  {
    "folke/snacks.nvim",
    keys = {
      { "<Leader>z", "<Leader>uz", desc = "Toggle Zen Mode", remap = true },
      { "<Leader>Z", "<Leader>uZ", desc = "Toggle Zoom", remap = true },
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
    },
    opts = {
      zen = {
        -- Full screen.
        win = { width = 0 },
      },
    },
  },
}
