return {
  "lewis6991/gitsigns.nvim",
  -- Same as LazyFile.
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },
    current_line_blame_opts = { delay = 500 },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end
      -- Navigation
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next Hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev Hunk")
      map("n", "]H", function()
        gs.nav_hunk("last")
      end, "Last Hunk")
      map("n", "[H", function()
        gs.nav_hunk("first")
      end, "First Hunk")
      -- Actions
      map({ "n", "v" }, "<Leader>ghs", "<Cmd>Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<Leader>ghr", "<Cmd>Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<Leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<Leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<Leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<Leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<Leader>ghb", function()
        gs.blame_line({ full = true })
      end, "Blame Line")
      map("n", "<Leader>ghB", gs.blame, "Blame Buffer")
      map("n", "<Leader>ghd", gs.diffthis, "Diff This")
      map("n", "<Leader>ghD", function()
        gs.diffthis("~")
      end, "Diff This ~")
      map("n", "<Leader>uG", gs.toggle_signs, "Toggle Git Signs")
      -- Text object
      map({ "o", "x" }, "ih", "<Cmd><C-u>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  },
}
