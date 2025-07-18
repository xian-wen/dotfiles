return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "cpp",
      },
    },
  },

  {
    "p00f/clangd_extensions.nvim",
    opts = {
      inlay_hints = { inline = false },
      ast = {
        -- These require codicons (https://github.com/microsoft/vscode-codicons).
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
    -- Configured in `nvim-lspconfig`.
    config = function() end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          keys = {
            { "<Leader>ch", "<Cmd>ClangdSwitchSourceHeader<CR>", desc = "Switch Source/Header (C/C++)" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          root_markers = {
            -- Build system markers
            {
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja",
            },
            -- Complilation DB fallback
            {
              "compile_commands.json",
              "compile_flags.txt",
            },
            -- VCS fallback
            ".git",
          },
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
      setup = {
        clangd = function(_, opts)
          local clangd_ext_opts = require("util").opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      },
    },
  },
}
