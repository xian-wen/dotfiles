local g = vim.g
local o = vim.opt

g.mapleader = " " -- value of <Leader>
g.maplocalleader = " " -- value of <LocalLeader>

g.loaded_node_provider = 0 -- disable node provider
g.loaded_perl_provider = 0 -- disable perl provider
g.loaded_python3_provider = 0 -- disable python3 provider
g.loaded_ruby_provider = 0 -- disable ruby provider

g.c_syntax_for_h = 1 -- use C syntax for *.h files, see `:h c.vim`

o.autowrite = true -- automatically write file if changed
o.clipboard = "unnamedplus" -- use the clipboard as the unnamed register
o.confirm = true -- ask what to do about unsaved/read-only files
o.cursorline = true -- highlight the screen line of the cursor
o.expandtab = true -- use spaces when <Tab> is inserted
o.fillchars = { -- characters to use for displaying special items
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  eob = " ",
}
o.foldexpr = "v:lua.require('util').foldexpr()" -- expression used when 'foldmethod' is "expr"
o.foldlevel = 99 -- close folds with a level higher than this
o.foldmethod = "expr" -- folding type
o.foldtext = "" -- expression used to display for a closed fold
o.formatexpr = "v:lua.vim.lsp.formatexpr()" -- expression used with "gq" command
o.formatoptions = "tcroqnlj" -- how automatic formatting is to be done
o.grepformat = "%f:%l:%c:%m" -- format of 'grepprg' output
o.grepprg = "rg --vimgrep" -- program to use for :grep
o.ignorecase = true -- ignore case in search patterns
o.jumpoptions = "view" -- specifies how jumping is done
o.laststatus = 3 -- tells when last window has status lines
o.linebreak = true -- wrap long lines at a blank
o.list = true -- show <Tab> and <EOL>
o.mouse = "a" -- enable the use of mouse clicks
o.number = true -- print the line number in front of each line
o.pumblend = 10 -- enable pseudo-transparency for the popup-menu
o.pumheight = 10 -- maximum number of items to show in the popup menu
o.relativenumber = true -- show relative line number in front of each line
o.ruler = false -- show cursor line and column in the status line
o.scrolloff = 4 -- minimum nr. of lines above and below cursor
o.sessionoptions = { -- options for :mksession
  "buffers",
  "curdir",
  "folds",
  "globals",
  "help",
  "skiprtp",
  "tabpages",
  "winsize",
}
o.shiftround = true -- round indent to multiple of shiftwidth
o.shiftwidth = 2 -- number of spaces to use for (auto)indent step
o.shortmess:append("I") -- list of flags, reduce length of messages
o.showmode = false -- message on status line to show current mode
o.sidescrolloff = 8 -- min. nr. of columns to left and right of cursor
o.signcolumn = "yes" -- when and how to display the sign column
o.smartcase = true -- no ignore case when pattern has uppercase
o.smartindent = true -- smart autoindenting for C programs
o.smoothscroll = true -- scroll by screen lines when 'wrap' is set
o.softtabstop = -1 -- number of spaces that <Tab> uses while editing
o.splitbelow = true -- new window from split is below the current one
o.splitright = true -- new window is put right of the current one
o.timeoutlen = 300 -- time out time in milliseconds
o.undofile = true -- save undo information in a file
o.updatetime = 200 -- after this many milliseconds flush swap file
o.virtualedit = "block" -- when to use virtual editing
o.wrap = false -- long lines wrap and continue on the next line
