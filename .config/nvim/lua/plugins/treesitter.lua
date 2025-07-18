return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<C-Space>", mode = { "n", "x" }, desc = "Increment Selection" },
        { "<BS>", mode = "x", desc = "Decrement Selection" },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    -- Load treesitter early when opening a file from the cmdline.
    lazy = vim.fn.argc(-1) == 0,
    -- Same as { "LazyFile", "VeryLazy" }.
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    init = function(plugin)
      -- Add treesitter queries to the rtp and its custom query predicates early.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    opts_extend = { "ensure_installed" },
    opts = {
      -- Built-in parsers are also installed since they may not be compatible with
      -- the queries from the 'nvim-treesitter' plugin.
      -- Ref: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#changing-the-parser-install-directory
      ensure_installed = {
        "diff",
        "lua",
        "luadoc",
        "luap",
        "printf",
        "query",
        "regex",
        "vim",
        "vimdoc",
      },
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-Space>",
          scope_incremental = false,
          node_decremental = "<BS>",
        },
      },
      indent = { enable = true },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]p"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]P"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[p"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[P"] = "@parameter.inner",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
