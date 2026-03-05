return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    -- Same as { "LazyFile", "VeryLazy" }.
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
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
      indent = { enable = true },
      folds = { enable = true },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter")
      local ts = require("util.treesitter")
      local util = require("util")

      -- Setup treesitter.
      TS.setup(opts)
      ts.get_installed(true) -- initialize the installed langs

      -- Install missing parsers.
      local install = vim.tbl_filter(function(lang)
        return not ts.have(lang)
      end, opts.ensure_installed or {})
      if #install > 0 then
        TS.install(install, { summary = true }):await(function()
          ts.get_installed(true) -- refresh the installed langs
        end)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        callback = function(ev)
          local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
          if not ts.have(ft) then
            return
          end
          ---@param feat string
          ---@param query string
          local enabled = function(feat, query)
            local f = opts[feat] or {}
            return f.enable ~= false
              and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
              and ts.have(ft, query)
          end
          -- Highlights
          if enabled("highlight", "highlights") then
            pcall(vim.treesitter.start, ev.buf)
          end
          -- Indents
          if enabled("indent", "indents") then
            -- ts is local, cannot be used in set_default
            util.set_default("indentexpr", "v:lua.require('util.treesitter').indentexpr()")
          end
          -- Folds
          if enabled("folds", "folds") then
            if util.set_default("foldmethod", "expr") then
              util.set_default("foldexpr", "v:lua.require('util.treesitter').foldexpr()")
            end
          end
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        -- Create buffer-local keymaps.
        keys = {
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]p"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]P"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[p"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[P"] = "@parameter.inner" },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)

      local attach = function(buf)
        local ts = require("util.treesitter")
        local ft = vim.bo[buf].filetype
        if not (vim.tbl_get(opts, "move", "enable") and ts.have(ft, "textobjects")) then
          return
        end
        ---@type table<string, table<string, string>>
        local moves = vim.tbl_get(opts, "move", "keys") or {}
        for method, keymaps in pairs(moves) do
          for key, query in pairs(keymaps) do
            local queries = type(query) == "table" and query or { query }
            local parts = {}
            for _, q in ipairs(queries) do
              local part = q:gsub("@", ""):gsub("%..*", "")
              part = part:sub(1, 1):upper() .. part:sub(2)
              table.insert(parts, part)
            end
            local desc = table.concat(parts, " or ")
            desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
            desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
            vim.keymap.set({ "n", "x", "o" }, key, function()
              if vim.wo.diff and key:find("[cC]") then
                return vim.cmd("normal! " .. key)
              end
              require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
            end, {
              buffer = buf,
              desc = desc,
              silent = true,
            })
          end
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_textobjects", { clear = true }),
        callback = function(ev)
          attach(ev.buf)
        end,
      })

      vim.tbl_map(attach, vim.api.nvim_list_bufs())
    end,
  },
}
