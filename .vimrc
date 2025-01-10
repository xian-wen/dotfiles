" Options
let g:mapleader = ' ' " value of <Leader>
let g:maplocalleader = ' ' " value of <LocalLeader>

source $VIMRUNTIME/defaults.vim " default options

set autoindent " take indent for new line from previous line
set autoread " autom. read file when changed outside of Vim
set autowrite " automatically write file if changed
set background=dark " "dark" or "light", used for highlight colors
set belloff=all " do not ring the bell for these reasons
set confirm " ask what to do about unsaved/read-only files
set cursorline " highlight the screen line of the cursor
set display=lastline " list of flags for how to display text
set encoding=utf-8 " encoding used internally
set expandtab " use spaces when <Tab> is inserted
set fillchars="vert:│,fold: ,foldopen:,foldclose:, foldsep: ,eob: " " characters to use for displaying special items
set foldlevel=99 " close folds with a level higher than this
set foldtext= " expression used to display for a closed fold
set formatoptions=tcroqnlj " how automatic formatting is to be done
set grepformat="%f:%l:%c:%m" " format of 'grepprg' output
set grepprg="rg --vimgrep" " program to use for :grep
set hidden " don't unload buffer when it is abandoned
set history=10000 " number of command-lines that are remembered
set ignorecase " ignore case in search patterns
set laststatus=2 " tells when last window has status lines
set linebreak " wrap long lines at a blank
set list " show <Tab> and <EOL>
set listchars="tab:> ,trail:-,nbsp:+"
set mouse=a " enable the use of mouse clicks
set mousemodel=popup_setpos " changes meaning of mouse buttons
set nojoinspaces " two spaces after a period with a join command
set noruler " show cursor line and column in the status line
set noshowmode " message on status line to show current mode
set nostartofline " commands move cursor to first non-blank in line
set nowrap " long lines wrap and continue on the next line
set number " print the line number in front of each line
set pumheight=10 " maximum number of items to show in the popup menu
set relativenumber " show relative line number in front of each line
set scrolloff=4 " minimum nr. of lines above and below cursor
set sessionoptions="buffers,curdir,folds,globals,help,skiprtp,tagpages,winsize" " options for :mksession
set shiftround " round indent to multiple of shiftwidth
set shiftwidth=2 " number of spaces to use for (auto)indent step
set shortmess+=ICF " list of flags, reduce length of messages
set shortmess-=S " list of flags, reduce length of messages
set sidescroll=1 " minimum number of columns to scroll horizontal
set sidescrolloff=8 " min. nr. of columns to left and right of cursor
set signcolumn=yes " when and how to display the sign column
set smartcase " no ignore case when pattern has uppercase
set smartindent " smart autoindenting for C programs
set smarttab " use 'shiftwidth' when inserting <Tab>
set smoothscroll " scroll by screen lines when 'wrap' is set
set softtabstop=-1 " number of spaces that <Tab> uses while editing
set splitbelow " new window from split is below the current one
set splitright " new window is put right of the current one
set switchbuf=uselast " sets behavior when switching to another buffer
set tabpagemax=50 " maximum number of tab pages for -p and "tab all"
set termguicolors " use GUI colors for the terminal
set timeoutlen=400 " time out time in milliseconds
set ttimeoutlen=50 " time out time for key codes in milliseconds
set undofile " save undo information in a file
set updatetime=200 " after this many milliseconds flush swap file
set viminfo+=! " use .viminfo file upon startup and exiting
set virtualedit=block " when to use virtual editing
set wildoptions="pum,tagfiles" " specifies how command line completion is done

" Mappings
" Try to prevent bad habits like using the arrow keys for movement.
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
" Buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
" Windows
nnoremap <C-Down> 2<C-w>-
nnoremap <C-Up> 2<C-w>+
nnoremap <C-Left> 2<C-w><lt>
nnoremap <C-Right> 2<C-w>>

" Load the man filetype plugin.
runtime! ftplugin/man.vim

" Add packages.
packadd! editorconfig
packadd! matchit

" vim-plug settings
" Automatic plugin installation with vim-plug.
" Ref: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-polyglot settings
" Disable syntax highlighting for markdown and default settings.
let g:polyglot_disabled = ['markdown', 'sensible']

" vim-plug: vim plugin manager
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/sonokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/tagbar'
Plug 'easymotion/vim-easymotion'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'yggdroot/indentline'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }

call plug#end()

" " gruvbox settings
" let g:gruvbox_transparent_bg = 1
" " Use autocmd to make sure all plugins are loaded before using gruvbox.
" autocmd VimEnter * ++nested colorscheme gruvbox

" " onedark settings
" colorscheme onedark

" sonokai settings
let g:sonokai_style = 'maia' " default/atlantis/andromeda/shusia/maia/espresso
let g:sonokai_transparent_background = 2
let g:sonokai_better_performance = 1
colorscheme sonokai

" " Make the background transparent.
" hi Normal guibg=NONE ctermbg=NONE

" vim-airline settings
let g:airline_theme='sonokai'
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_left_alt_sep='|'
let g:airline_right_sep=''
let g:airline_right_alt_sep='|'
let g:airline_section_z = airline#section#create(['%2p%%', '  %3l/%3L', ':%-2v'])
let g:airline_skip_empty_sections = 1
" " Define only the specified extensions to be loaded to improve performance.
" let g:airline_extensions = []
let g:airline#extensions#tabline#enabled = 1
" Display the tail of the filename, for file of the same name,
" display it along with the containing parent directory.
let g:airline#extensions#tabline#formatter = 'unique_tail'
" Tab n can be switched to by mouse, `<n>gt`, or `:tabn<n>`.
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
" Buffer n cannot be switched to by mouse, use `:b<n>`.
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_highlighting_cache = 1

" vim-devicons settings
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
" Solve issues after resourcing.
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" gutentags_plus settings
let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_project_root = ['.root']
let g:gutentags_cache_dir = expand('~/.cache/tags')
" Change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
" Enable advanced commands for debugging.
let g:gutentags_define_advanced_commands = 1
" Disable default mappings.
let g:gutentags_plus_nomap = 1
" Find symbol (reference) under cursor.
noremap <silent> <Leader>gr :GscopeFind s <C-r><C-w><CR>
" Find symbol definition under cursor.
noremap <silent> <Leader>gd :GscopeFind g <C-r><C-w><CR>
" Find functions calling this function.
noremap <silent> <Leader>gc :GscopeFind c <C-r><C-w><CR>
" Find functions called by this function.
noremap <silent> <Leader>gC :GscopeFind d <C-r><C-w><CR>
" Find text string under cursor.
noremap <silent> <Leader>gt :GscopeFind t <C-r><C-w><CR>
" Find egrep pattern under cursor.
noremap <silent> <Leader>ge :GscopeFind e <C-r><C-w><CR>
" Find file name under cursor.
noremap <silent> <Leader>gf :GscopeFind f <C-r>=expand("<cfile>")<CR><CR>
" Find files #including the file name under cursor.
noremap <silent> <Leader>gi :GscopeFind i <C-r>=expand("<cfile>")<CR><CR>
" Find places where current symbol is assigned.
noremap <silent> <Leader>ga :GscopeFind a <C-r><C-w><CR>
" Find current word in ctags database.
noremap <silent> <Leader>gw :GscopeFind z <C-r><C-w><CR>

" fzf settings
" Customize fzf colors to match color scheme.
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }
" Enable per-command history.
" - CTRL-n and CTRL-p will be bound to 'next-history' and 'previous-history'
"   instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" nerdtree settings
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>
let g:NERDTreeWinSize = max([30, winwidth(0) / 5])
let g:NERDTreeShowHidden = 1
let g:NERDTreeNaturalSort = 1
let g:NERDTreeMinimalMenu = 1

" " vim-nerdtree-syntax-highlight settings
" " Mitigating lag issues for nerdtree.
" let g:NERDTreeLimitedSyntax = 1
" let g:NERDTreeHighlightCursorline = 0

" tagbar settings
nnoremap <silent> <Leader>t :TagbarToggle<CR>
let g:tagbar_width = max([30, winwidth(0) / 5])
let g:tagbar_autofocus = 1

" vim-easymotion settings
" " Change the default <Leader><Leader> prefix to <Leader>.
" map <Leader> <Plug>(easymotion-prefix)
" Search by multiple chars, can be out of screen but in current window.
map / <Plug>(easymotion-sn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
" Search by one or two chars, can be out of window but in current screen.
" `s{char}{label}` or `s{char}{char}{label}`
nmap s <Plug>(easymotion-overwin-f2)
" Buffer Completion with Ctrl-d.
autocmd VimEnter * EMCommandLineNoreMap <C-d> <Over>(buffer-complete)
let g:EasyMotion_prompt = '{n}>>> '
let g:EasyMotion_smartcase = 1
let g:EasyMotion_verbose = 0

" coc settings
" Ref: https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.vim
" Automatically install extensions.
let g:coc_global_extensions = [
  \ 'coc-clangd',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-sh',
  \ 'coc-snippets'
  \ ]
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <Tab>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format.
" <C-g>u breaks current undo.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
  \: "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
" Use `[d` and `]d` to navigate diagnostics.
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <Leader>cr <Plug>(coc-rename)
" Formatting selected code.
nmap <Leader>cf <Plug>(coc-format-selected)
xmap <Leader>cf <Plug>(coc-format-selected)
" Update signature help on jump placeholder.
augroup coc_signature
  autocmd!
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Applying code actions to the selected code block.
" Example: `<Leader>caap` for current paragraph.
nmap <Leader>ca  <Plug>(coc-codeaction-selected)
xmap <Leader>ca  <Plug>(coc-codeaction-selected)
" Remap keys for applying code actions at the cursor position.
nmap <Leader>cac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer.
nmap <Leader>cas  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line.
nmap <Leader>caf  <Plug>(coc-fix-current)
" Remap keys for applying refactor code actions.
nmap <silent> <Leader>car <Plug>(coc-codeaction-refactor)
xmap <silent> <Leader>car <Plug>(coc-codeaction-refactor-selected)
" Run the Code Lens action on the current line.
nmap <Leader>cl <Plug>(coc-codelens-action)
" Map function and class text objects.
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
" Remap <C-f> and <C-b> to scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
" Enable airline support.
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#error_symbol = ' '
let g:airline#extensions#coc#warning_symbol = ' '
let g:airline#extensions#coc#show_coc_status = 1
" Change the error format (%C - error count, %L - line number).
let g:airline#extensions#coc#stl_format_err = '%C(L%L)'
" Change the warning format (%C - error count, %L - line number).
let g:airline#extensions#coc#stl_format_warn = '%C(L%L)'
" Mappings for CoCList.
nnoremap <silent><nowait> <Leader>cd :<C-u>CocList diagnostics<CR>
nnoremap <silent><nowait> <Leader>ce :<C-u>CocList extensions<CR>
nnoremap <silent><nowait> <Leader>cc :<C-u>CocList commands<CR>
" Find symbol of current document.
nnoremap <silent><nowait> <Leader>cs :<C-u>CocList outline<CR>
" Search workspace symbols.
nnoremap <silent><nowait> <Leader>cS :<C-u>CocList -I symbols<CR>
" Do default action for next item.
nnoremap <silent><nowait> <Leader>cn :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <Leader>cp :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <Leader>cR :<C-u>CocListResume<CR>

" indentline settings
" Change indent character to '|', '¦', '┆', or '┊'.
let g:indentLine_char = '│'
let g:indentLine_fileTypeExclude = ['man', 'text']
let g:indentLine_bufTypeExclude = ['help', 'terminal']
" Do not conceal quotation marks for json files.
let g:vim_json_syntax_conceal = 0

" nerdcommenter settings
" Add spaces after comment delimiters by default.
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation.
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region).
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting.
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not.
let g:NERDToggleCheckAllLines = 1
" Disable default mappings.
let g:NERDCreateDefaultMappings = 0
" Toggle the comment state of the selected line(s).
nmap gcc <Plug>NERDCommenterToggle
xmap gcc <Plug>NERDCommenterToggle
" Comment the current line or text selected in visual mode, force nesting.
nmap gcn <Plug>NERDCommenterNested
xmap gcn <Plug>NERDCommenterNested
" Comment the given lines using only one set of multipart delimiters.
nmap gcm <Plug>NERDCommenterMinimal
xmap gcm <Plug>NERDCommenterMinimal
" Toggle the comment state of the selected line(s) individually.
nmap gci <Plug>NERDCommenterInvert
xmap gci <Plug>NERDCommenterInvert
" Comment out the selected lines ``sexily''.
nmap gcs <Plug>NERDCommenterSexy
xmap gcs <Plug>NERDCommenterSexy
" Yank first before commenting the current line or text selected in visual mode.
nmap gcy <Plug>NERDCommenterYank
xmap gcy <Plug>NERDCommenterYank
" Comment the current line from the cursor to the end of line.
nmap gc$ <Plug>NERDCommenterToEOL
" Add comment delimiters to the end of line and go into insert mode between them.
nmap gcA <Plug>NERDCommenterAppend
" Add comment delimiters at the current cursor position and insert between.
imap gcI <Plug>NERDCommenterInsert
" Switch to the alternative set of delimiters.
nmap gca <Plug>NERDCommenterAltDelims
" Comment the current line or text selected in visual mode with delimiters
" aligned down the left side (gcl) or both sides (gcb).
nmap gcl <Plug>NERDCommenterAlignLeft
xmap gcl <Plug>NERDCommenterAlignLeft
nmap gcb <Plug>NERDCommenterAlignBoth
xmap gcb <Plug>NERDCommenterAlignBoth

" vim-visual-multi settings
let g:VM_theme = 'iceblue'
" " Change the default '\\' leader to vim <Leader>.
" let g:VM_leader = '<Leader>'
let g:VM_silent_exit = 1
" Hide warnings, run :VMDebug to see if there are conflicts.
let g:VM_show_warnings = 0
" Initialize the variable to change mappings.
let g:VM_maps = {}
let g:VM_maps['Find Under'] = '<Leader>m'
let g:VM_maps['Find Subword Under'] = '<Leader>m'
let g:VM_maps["Add Cursor Down"] = '<C-j>'
let g:VM_maps["Add Cursor Up"] = '<C-k>'
