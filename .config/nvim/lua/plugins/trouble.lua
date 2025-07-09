return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      {
        "]q",
        function()
          local trouble = require("trouble")
          if trouble.is_open() then
            trouble.next({
              skip_groups = true,
              jump = true,
            })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix",
      },
      {
        "[q",
        function()
          local trouble = require("trouble")
          if trouble.is_open() then
            trouble.prev({
              skip_groups = true,
              jump = true,
            })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Prev Trouble/Quickfix",
      },
      { "<Leader>cs", "<Cmd>Trouble symbols toggle<CR>", desc = "LSP Symbols (Trouble)" },
      { "<Leader>cS", "<Cmd>Trouble lsp toggle<CR>", desc = "LSP Definitions/References/... (Trouble)" },
      { "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
      { "<Leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
      { "<Leader>xL", "<Cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
      { "<Leader>xQ", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
    },
    opts = {
      focus = true,
      modes = {
        lsp = {
          win = { position = "right" },
        },
        symbols = { focus = true },
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    keys = {
      { "<Leader>xt", "<Cmd>Trouble todo toggle<CR>", desc = "Todo (Trouble)" },
      {
        "<Leader>xT",
        "<Cmd>Trouble todo toggle filter.tag={TODO,FIX,FIXME}<CR>",
        desc = "Todo/Fix/Fixme (Trouble)",
      },
    },
  },
}
