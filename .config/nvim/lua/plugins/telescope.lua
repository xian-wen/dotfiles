return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    cmd = "Telescope",
    keys = {
      -- Alias
      { "<Leader>,", "<Leader>fb", desc = "Buffers", remap = true },
      { "<Leader>/", "<Leader>sg", desc = "Live Grep (Root Dir)", remap = true },
      { "<Leader>:", "<Leader>sc", desc = "Command History", remap = true },
      { "<Leader><Space>", "<Leader>ff", desc = "Find Files (Root Dir)", remap = true },
      -- Find
      {
        "<Leader>fb",
        function()
          require("telescope.builtin").buffers({
            sort_lastused = true,
            sort_mru = true,
          })
        end,
        desc = "Buffers",
      },
      {
        "<Leader>fc",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.stdpath("config"),
            follow = true,
            hidden = true,
            no_ignore = true,
          })
        end,
        desc = "Find Config Files",
      },
      {
        "<Leader>ff",
        function()
          require("telescope.builtin").find_files({
            cwd = Snacks.git.get_root(),
            follow = true,
            hidden = true,
            no_ignore = true,
          })
        end,
        desc = "Find Files (Root Dir)",
      },
      {
        "<Leader>fF",
        function()
          require("telescope.builtin").find_files({
            follow = true,
            hidden = true,
            no_ignore = true,
          })
        end,
        desc = "Find Files (cwd)",
      },
      {
        "<Leader>fg",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Git Files",
      },
      {
        "<Leader>fr",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Recent Files",
      },
      {
        "<Leader>fR",
        function()
          require("telescope.builtin").oldfiles({ cwd_only = true })
        end,
        desc = "Recent Files (cwd)",
      },
      -- Git
      {
        "<Leader>gc",
        function()
          require("telescope.builtin").git_commits()
        end,
        desc = "Git Commits",
      },
      {
        "<Leader>gs",
        function()
          require("telescope.builtin").git_status()
        end,
        desc = "Git Status",
      },
      -- Search
      {
        '<Leader>s"',
        function()
          require("telescope.builtin").registers()
        end,
        desc = "Registers",
      },
      {
        "<Leader>sa",
        function()
          require("telescope.builtin").autocommands()
        end,
        desc = "Autocommands",
      },
      {
        "<Leader>sb",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "Current Buffer Fuzzy",
      },
      {
        "<Leader>sc",
        function()
          require("telescope.builtin").command_history()
        end,
        desc = "Command History",
      },
      {
        "<Leader>sC",
        function()
          require("telescope.builtin").commands()
        end,
        desc = "Commands",
      },
      {
        "<Leader>sd",
        function()
          require("telescope.builtin").diagnostics({ bufnr = 0 })
        end,
        desc = "Document Diagnostics",
      },
      {
        "<Leader>sD",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Workspace Diagnostics",
      },
      {
        "<Leader>sg",
        function()
          require("telescope.builtin").live_grep({ cwd = Snacks.git.get_root() })
        end,
        desc = "Live Grep (Root Dir)",
      },
      {
        "<Leader>sG",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep (cwd)",
      },
      {
        "<Leader>sh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help",
      },
      {
        "<Leader>sH",
        function()
          require("telescope.builtin").highlights()
        end,
        desc = "Highlights",
      },
      {
        "<Leader>sj",
        function()
          require("telescope.builtin").jumplist()
        end,
        desc = "Jumplist",
      },
      {
        "<Leader>sk",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "Key Maps",
      },
      {
        "<Leader>sl",
        function()
          require("telescope.builtin").loclist()
        end,
        desc = "Location List",
      },
      {
        "<Leader>sm",
        function()
          require("telescope.builtin").marks()
        end,
        desc = "Marks",
      },
      {
        "<Leader>sM",
        function()
          require("telescope.builtin").man_pages()
        end,
        desc = "Man",
      },
      {
        "<Leader>so",
        function()
          require("telescope.builtin").vim_options()
        end,
        desc = "Options",
      },
      {
        "<Leader>sR",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume",
      },
      {
        "<Leader>sq",
        function()
          require("telescope.builtin").quickfix()
        end,
        desc = "Quickfix List",
      },
      {
        "<Leader>sw",
        function()
          require("telescope.builtin").grep_string({
            cwd = Snacks.git.get_root(),
            word_match = "-w",
          })
        end,
        desc = "Word (Root Dir)",
      },
      {
        "<Leader>sW",
        function()
          require("telescope.builtin").grep_string({ word_match = "-w" })
        end,
        desc = "Word (cwd)",
      },
      {
        "<Leader>sw",
        function()
          require("telescope.builtin").grep_string({ cwd = Snacks.git.get_root() })
        end,
        mode = "v",
        desc = "Selection (Root Dir)",
      },
      {
        "<Leader>sW",
        function()
          require("telescope.builtin").grep_string()
        end,
        mode = "v",
        desc = "Selection (cwd)",
      },
      {
        "<Leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "LSP Document Symbols",
      },
      {
        "<Leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end,
        desc = "LSP Dynamic Workspace Symbols",
      },
      -- Colorscheme
      {
        "<Leader>uC",
        function()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Change Colorscheme",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      local action_layout = require("telescope.actions.layout")
      local action_generate = require("telescope.actions.generate")
      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              preview_width = 0.5,
              prompt_position = "top",
            },
          },
          mappings = {
            i = {
              ["<A-p>"] = action_layout.toggle_preview,
              -- Toggle help with <C-/> or <C-_>.
              ["<C-_>"] = action_generate.which_key({
                max_height = 0.9,
                keybind_width = 15,
                name_width = 40,
              }),
              ["<C-d>"] = false,
              -- Map <C-u> to clear the prompt.
              ["<C-u>"] = false,
              ["<C-Down>"] = actions.preview_scrolling_down,
              ["<C-Up>"] = actions.preview_scrolling_up,
              ["<Down>"] = actions.cycle_history_next,
              ["<Up>"] = actions.cycle_history_prev,
            },
            n = {
              ["<A-p>"] = action_layout.toggle_preview,
              -- Toggle help with <?>, i.e., <S-/>.
              ["?"] = action_generate.which_key({
                max_height = 0.9,
                keybind_width = 15,
                name_width = 40,
              }),
              ["q"] = actions.close,
            },
          },
        },
      }
    end,
  },

  -- Flash telescope config
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      if not package.loaded.flash then
        return
      end
      local function flash(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          i = { ["<C-s>"] = flash },
          n = { ["s"] = flash },
        },
      })
    end,
  },
}
