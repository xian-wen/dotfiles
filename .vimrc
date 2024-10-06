" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Get rid of the -- INSERT --.
set noshowmode showcmd

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Set indent.
" https://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Unbind some useless/annoying default key bindings.
" 'Q' in normal mode enters Ex mode. You almost never want this.
nmap Q <Nop>

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
" inoremap <Left>  <ESC>:echoe "Use h"<CR>
" inoremap <Right> <ESC>:echoe "Use l"<CR>
" inoremap <Up>    <ESC>:echoe "Use k"<CR>
" inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Load the man filetype plugin.
runtime! ftplugin/man.vim    
" Use a vertical split instead of horizontal.
let g:ft_man_open_mode = 'vert'
" Use a new tab.
" let g:ft_man_open_mode = 'tab'
" Enable folding.
let g:ft_man_folding_enable = 1
" Add your desired folding style.
autocmd FileType man setlocal foldmethod=indent foldenable
" Make :Man {number} {name} behave like man {number} {name} by
" not running man {name} if no page is found.
let g:ft_man_no_sect_fallback = 1
" Use K command to open a manual page in a Vim window.
" set keywordprg=:Man

" vim-plug: vim plugin manager
" https://github.com/junegunn/vim-plug
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

" https://github.com/dense-analysis/ale
Plug 'dense-analysis/ale'
" https://github.com/jiangmiao/auto-pairs
Plug 'jiangmiao/auto-pairs'
" https://github.com/universal-ctags/ctags
Plug 'universal-ctags/ctags'
" https://github.com/konfekt/fastfold
Plug 'konfekt/fastfold'
" Post-update hook can be a lambda expression
" https://github.com/junegunn/fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf.vim'
" https://github.com/itchyny/lightline.vim 
Plug 'itchyny/lightline.vim'
" https://github.com/preservim/nerdcommenter
Plug 'preservim/nerdcommenter'
" https://github.com/preservim/nerdtree
Plug 'preservim/nerdtree'
" https://github.com/tmhedberg/simpylfold
Plug 'tmhedberg/simpylfold'
" https://github.com/craigemery/vim-autotag
Plug 'craigemery/vim-autotag'
" https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
" https://github.com/patstockwell/vim-monokai-tasty
Plug 'patstockwell/vim-monokai-tasty'
" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'
" https://github.com/ycm-core/YouCompleteMe
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' }

" Call plug#end to update &runtimepath and initialize the plugin system.
" - It automatically executes `filetype plugin indent on` and `syntax enable`
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" vim-monokai-tasty settings.
let g:vim_monokai_tasty_italic = 1                    " allow italics, set this before the colorscheme
let g:vim_monokai_tasty_machine_tint = 1              " use `mahcine` colour variant
let g:vim_monokai_tasty_highlight_active_window = 1   " make the active window stand out
colorscheme vim-monokai-tasty                         " set the colorscheme
" Optional themes for airline/lightline
" let g:lightline = { 'colorscheme': 'monokai_tasty' }  " lightline theme
" If you don't like a particular colour choice from `vim-monokai-tasty`, you can
" override it here. For example, to change the colour of the search hightlight:
hi Search guifg=#bada55 guibg=#000000 gui=bold ctermfg=green ctermbg=black cterm=bold
" If you want to know what the name of a particular hightlight is, you can use
" `:What`. It prints out the syntax group that the cursor is currently above.
" https://www.reddit.com/r/vim/comments/6z4aau/how_to_stop_vim_from_autohighlighting_italics_in/
command! What echomsg synIDattr(synID(line('.'), col('.'), 1), 'name')

" nerdtree settings.
" nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeShowHidden=1

" nerdcommenter settings.
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" auto-pairs settings.
" Enable fly mode.
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'

" fastfold settings.
" Open all folds by default.
set foldlevelstart=99
" Triggers for updating folds in the currently edited buffer.
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
" Files in which folds to be updated.
let g:markdown_folding = 1
let g:rst_fold_enabled = 1
let g:tex_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:zsh_fold_enable = 1
let g:ruby_fold = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:r_syntax_folding = 1
let g:rust_fold = 1
let g:php_folding = 1
let g:fortran_fold=1
let g:clojure_fold = 1
let g:baan_fold=1
" Syntax folding for C/C++.
autocmd FileType c,cpp setlocal foldmethod=syntax
" Indent folding for python (use simpylfold instead).
" autocmd FileType python setlocal foldmethod=indent
" Create a fold text object, mapped to iz and az.
xnoremap <silent> iz :<C-U>FastFoldUpdate<CR>]z<Up>$v[z<Down>^
xnoremap <silent> az :<C-U>FastFoldUpdate<CR>]zV[z

