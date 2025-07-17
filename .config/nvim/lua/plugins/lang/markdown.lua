return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "html",
        "latex",
        "markdown",
        "markdown_inline",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Run multiple formatters sequentially.
        ["markdown"] = { "markdownlint-cli2" },
        ["markdown.mdx"] = { "markdownlint-cli2" },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "markdownlint-cli2" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Run code action to add table of content.
        marksman = {},
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    keys = {
      {
        "<Leader>cm",
        "<Cmd>MarkdownPreviewToggle<CR>",
        ft = "markdown",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    keys = {
      {
        "<Leader>um",
        function()
          require("render-markdown").toggle()
        end,
        ft = "markdown",
        desc = "Markdown Preview",
      },
    },
    opts = {
      heading = {
        sign = false,
        icons = {},
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
    },
  },
}
