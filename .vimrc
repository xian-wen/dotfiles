" Change value of <Leader> and <LocalLeader>.
let g:mapleader = ' '
let g:maplocalleader = ' '

" Get the defaults that most users want.
if !has('nvim')
  source $VIMRUNTIME/defaults.vim
endif

" Use 24-bit color.
if has('termguicolors')
  set termguicolors
endif

" Make the background transparent.
" hi Normal guibg=NONE ctermbg=NONE

" Disable the default Vim startup message.
set shortmess+=I

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" Get rid of the -- INSERT --.
set noshowmode showcmd

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set number relativenumber

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

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Set indent.
" https://stackoverflow.com/questions/1878974/redefine-tab-as-4-spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

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
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Load the man filetype plugin.
runtime! ftplugin/man.vim

" vim-plug settings.
" Automatic plugin installation with vim-plug.
" Ref: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-polyglot settings.
" Syntax highlighting for markdown is weird, so disable it,
" which must be defined before polyglot is loaded.
let g:polyglot_disabled = ['markdown']
" Disable default settings.
" let g:polyglot_disabled = ['sensible']

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

" gruvbox settings.
" set background=dark
" let g:gruvbox_transparent_bg = 1
" Use autocmd to make sure all plugins are loaded before using gruvbox.
" autocmd VimEnter * ++nested colorscheme gruvbox

" onedark settings.
" colorscheme onedark

" sonokai settings.
let g:sonokai_style = 'maia' " default/atlantis/andromeda/shusia/maia/espresso
let g:sonokai_transparent_background = 2
let g:sonokai_better_performance = 1
colorscheme sonokai

" vim-airline settings.
let g:airline_theme='sonokai'
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_left_alt_sep='|'
let g:airline_right_sep=''
let g:airline_right_alt_sep='|'
let g:airline_section_z = airline#section#create(['%3p%%', '  %3l/%3L', ':%-3v'])
let g:airline_skip_empty_sections = 1
" Define extensions to be loaded to improve performance.
" let g:airline_extensions = []
let g:airline#extensions#tabline#enabled = 1
" Display the tail of the filename, for file of the same name,
" display it along with the containing parent directory.
let g:airline#extensions#tabline#formatter = 'unique_tail'
" Tab n can be switched to by mouse, `<n>gt`, or `:tabn<n>`.
" let g:airline#extensions#tabline#tab_nr_type = 0 " # of splits (default)
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
" let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
" Buffer n cannot be switched to by mouse, use `:b<n>`.
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_highlighting_cache = 1

" vim-devicons settings.
" Turn on/off file node glyph decorations (not particularly useful)
let g:WebDevIconsUnicodeDecorateFileNodes = 1
" Enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" Enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1
" Solve issues after resourcing.
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" gutentags_plus settings.
" Enable gtags module.
let g:gutentags_modules = ['ctags', 'gtags_cscope']
" Config project root markers.
let g:gutentags_project_root = ['.root']
" Generate datebases in my cache directory, prevent gtags files polluting my project.
let g:gutentags_cache_dir = expand('~/.cache/tags')
" Enable advanced commands for debugging.
let g:gutentags_define_advanced_commands = 1
" Change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
" Define new maps.
let g:gutentags_plus_nomap = 1
" Find symbol (reference) under cursor.
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
" Find symbol definition under cursor.
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
" Find functions called by this function.
noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
" Find functions calling this function.
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
" Find text string under cursor.
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
" Find egrep pattern under cursor.
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
" Find file name under cursor.
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" Find files #including the file name under cursor.
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" Find places where current symbol is assigned.
noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
" Find current word in ctags database.
noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>

" fzf settings.
" Default fzf layout
" - Popup window (center of the current window)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }
" - down / up / left / right
let g:fzf_layout = { 'down': '40%' }
" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
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
" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" nerdtree settings.
nnoremap <silent> <F3> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = max([30, winwidth(0) / 5])
let g:NERDTreeShowHidden = 1
" Natural sort nodes, i.e., foo1, foo2, foo10 instead of foo1, foo10, foo2.
let g:NERDTreeNaturalSort = 1
" Display a one-line menu.
let g:NERDTreeMinimalMenu = 1

" vim-nerdtree-syntax-highlight settings.
" Mitigating lag issues for nerdtree.
" let g:NERDTreeLimitedSyntax = 1
" let g:NERDTreeHighlightCursorline = 0

" tagbar settings.
nnoremap <silent> <F8> :TagbarToggle<CR>
let g:tagbar_width = max([30, winwidth(0) / 5])
let g:tagbar_autofocus = 1

" vim-easymotion settings.
" Change the default <Leader><Leader> prefix to <Leader>.
map <Leader> <Plug>(easymotion-prefix)
" Search by one, or two, or multiple chars, can be out of screen but in current window.
map / <Plug>(easymotion-sn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
" Search by one or two chars, can be out of window but in current screen.
" `s{char}{label}` or `s{char}{char}{label}`
nmap s <Plug>(easymotion-overwin-f2)
" Buffer Completion with Ctrl-D.
autocmd VimEnter * EMCommandLineNoreMap <C-d> <Over>(buffer-complete)
" Simple command line prompt.
let g:EasyMotion_prompt = '{n}>>> '
" Turn on case-insensitive feature.
let g:EasyMotion_smartcase = 1
" Do not display "EasyMotion: Cancelled", etc.
let g:EasyMotion_verbose = 0

" indentline settings.
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
  return !col || getline('.')[col - 1]  =~# '\s'
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
" Use <C-space> to trigger completion.
inoremap <silent><expr> <C-Space> coc#refresh()
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
nmap <Leader>r <Plug>(coc-rename)
" Formatting selected code.
nmap <Leader>f  <Plug>(coc-format-selected)
xmap <Leader>f  <Plug>(coc-format-selected)
" Update signature help on jump placeholder.
augroup coc_signature
  autocmd!
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Applying code actions to the selected code block.
" Example: `<Leader>aap` for current paragraph.
nmap <Leader>a  <Plug>(coc-codeaction-selected)
xmap <Leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying code actions at the cursor position.
nmap <Leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer.
nmap <Leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line.
nmap <Leader>af  <Plug>(coc-fix-current)
" Remap keys for applying refactor code actions.
nmap <silent> <Leader>rf <Plug>(coc-codeaction-refactor)
xmap <silent> <Leader>rf  <Plug>(coc-codeaction-refactor-selected)
" Run the Code Lens action on the current line.
nmap <Leader>l <Plug>(coc-codelens-action)
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
let g:airline#extensions#coc#stl_format_err = '%C(L%L)'
let g:airline#extensions#coc#stl_format_warn = '%C(L%L)'
" Mappings for CoCList.
nnoremap <silent><nowait> <Leader>d :<C-u>CocList diagnostics<CR>
nnoremap <silent><nowait> <Leader>e :<C-u>CocList extensions<CR>
nnoremap <silent><nowait> <Leader>C :<C-u>CocList commands<CR>
nnoremap <silent><nowait> <Leader>s :<C-u>CocList outline<CR>
nnoremap <silent><nowait> <Leader>S :<C-u>CocList -I symbols<CR>
nnoremap <silent><nowait> <Leader>n :<C-u>CocNext<CR>
nnoremap <silent><nowait> <Leader>p :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <Leader>R :<C-u>CocListResume<CR>

" Change indent character to '|', '¦', '┆', or '┊'.
" let g:indentLine_char = '┊'
let g:indentLine_fileTypeExclude = ['text']
let g:indentLine_bufTypeExclude = ['help', 'terminal']
" Do not conceal quotation marks for json files.
let g:vim_json_syntax_conceal = 0

" nerdcommenter settings.
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" vim-visual-multi settings.
let g:VM_theme = 'iceblue'
" Change the default '\\' leader to vim <Leader>.
" let g:VM_leader = "\<Leader>"
" Do not display a message when exiting VM.
let g:VM_silent_exit = 1
" Do not display a warning when entering VM and there are mapping conflicts.
" You can still run :VMDebug to see if there are conflicts.
let g:VM_show_warnings = 0
