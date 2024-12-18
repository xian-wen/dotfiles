return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<C-n>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
    { "<C-p>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
    { "]b", "<Cmd>BufferLineMoveNext<CR>", desc = "Move Buffer Next" },
    { "[b", "<Cmd>BufferLineMovePrev<CR>", desc = "Move Buffer Prev" },
    { "<Leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close Buffers to the Left" },
    { "<Leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Close Buffers to the Right" },
    { "<Leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close Other Buffers" },
    { "<Leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<Leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Close Non-Pinned Buffers" },
    { "<Leader>bs", "<Cmd>BufferLinePick<CR>", desc = "Select Buffer" },
    { "<Leader>bS", "<Cmd>BufferLinePickClose<CR>", desc = "Close Selected Buffer" },
    { "<Leader>bd", "<Cmd>BufferLineSortByDirectory<CR>", desc = "Sort Buffers by Directory" },
    { "<Leader>bD", "<Cmd>BufferLineSortByRelativeDirectory<CR>", desc = "Sort Buffers by Relative Directory" },
    { "<Leader>be", "<Cmd>BufferLineSortByExtension<CR>", desc = "Sort Buffers by Extension" },
    { "<Leader>bt", "<Cmd>BufferLineSortByTabs<CR>", desc = "Sort Buffers by Tabs" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diag)
        local icons = { error = " ", warning = " " }
        local ret = (diag.error and icons.error .. diag.error .. " " or "")
          .. (diag.warning and icons.warning .. diag.warning or "")
        return vim.trim(ret)
      end,
      always_show_bufferline = false,
    },
  },
}
