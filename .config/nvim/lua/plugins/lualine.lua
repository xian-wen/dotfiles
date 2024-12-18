return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    -- Hide the statusline on the starter page.
    vim.o.laststatus = 0
  end,
  opts = {
    options = {
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = { "snacks_dashboard" },
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        {
          "mode",
          -- Add Vim/Neovim logo before mode.
          fmt = function(str)
            local logo = " " --  / 
            return logo .. str
          end
        },
      },
    },
  },
}
