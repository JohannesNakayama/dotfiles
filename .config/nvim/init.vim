" =======================================================================================
" ======================================= PLUGINS =======================================
" =======================================================================================

" automatic installation vim-plug
" --> https://github.com/junegunn/vim-plug/wiki/tips
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug
call plug#begin('~/.vim/plugged')

    " utilities
    Plug 'farmergreg/vim-lastplace'                     " cursor in position of last open
    Plug 'tpope/vim-sensible'                           " sane defaults
    Plug 'airblade/vim-gitgutter'                       " VCS change info per line (only git)
    Plug 'tpope/vim-commentary'                         " commenting
    Plug 'tpope/vim-surround'                           " surround text with quotes, parantheses, ...
    Plug 'PeterRincker/vim-argumentative'               " text object ',' / also provides argument movements with >, ],
    Plug 'tpope/vim-eunuch'                             " unix commands
    Plug 'zirrostig/vim-schlepp'                        " move selections / lines
    Plug 'tpope/vim-repeat'                             " enable dot-command for Plugins
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy completion
    Plug 'junegunn/fzf.vim'
    Plug 'vimwiki/vimwiki'                              " personal wiki
    Plug 'junegunn/goyo.vim'                            " writing focus mode
    Plug 'mg979/vim-visual-multi', {'branch': 'master'} " multiple cursors

    " TODO: figure out this plugin:
    " Plug 'numtostr/BufOnly.nvim', { 'on': 'BufOnly' }   " close all but current buffer

    " language support
    Plug 'derekwyatt/vim-scala', {'for': 'scala'}       " Scala programming language
    Plug 'JuliaEditorSupport/julia-vim'                 " Julia programming language
    Plug 'mattn/emmet-vim'                              " emmet for vim -> HTML support

    " colors
    Plug 'chrisbra/Colorizer'                           " color hex codes and color-names
    Plug 'drewtempelmeyer/palenight.vim'                " palenight color scheme
    Plug 'KeitaNakamura/neodark.vim'                    " neodark color scheme
    Plug 'rakr/vim-one'                                 " one color scheme
    Plug 'ajmwagar/vim-deus'                            " deus color scheme
    Plug 'arcticicestudio/nord-vim'                     " nord color scheme

    " status line
    Plug 'vim-airline/vim-airline'                      " status / tabline
    Plug 'vim-airline/vim-airline-themes'               " themes for the tabline

    " open repl in vim window
    " TODO: checkout vim-sendtowindow first
    " " vim send to repl
    " Plug 'urbainvaes/vim-ripple'
    " Plug 'machakann/vim-highlightedyank'                " Highlight code chunks sent to REPL
    " Plug 'urbainvaes/vim-tmux-pilot'                    " Streamline navigation (e.g. autoinsert in terminal)
    " let g:ripple_repls = {}
    " let g:ripple_repls["python"] = {
    "     \ "command": "ipython",
    "     \ "pre": "\<esc>[200~",
    "     \ "post": "\<esc>[201~",
    "     \ "addcr": 1,
    "     \ "filter": 0,
    "     \ }
    " let g:ripple_always_return = 1

    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme = 'nord'
    let g:scala_scaladoc_indent = 1
    let g:goyo_width = '60%'

call plug#end()




" ========================================================================================
" ==================================== BASIC SETTINGS ====================================
" ========================================================================================

set number                        " show line number
set cursorline                    " highlight current line
set hidden                        " switch unsaved buffers
set clipboard=unnamedplus         " vim clipboard = system clipboard
set confirm                       " ask for save on close
set nostartofline                 " keep column position when switching buffers
set termguicolors                 " true color support

set inccommand=nosplit            " live substitution preview
set gdefault                      " substitute all occurrences in line per default

set ignorecase                    " case of normal letters is ignored
set smartcase                     " smart case sensitive search
set hls                           " hightlight search results

set list
set listchars=tab:⊳\ ,trail:·     " display whitespaces

set breakindent                   " indent wrapped lines
set breakindentopt=shift:2        " ... by two spaces

set tabstop=4                     " tab size to 4
set shiftwidth=4                  " if return: indent by 4
set expandtab                     " always uses spaces instead of tab characters

" -- required for vimwiki
syntax on                         " syntax highlighting
set nocompatible                  " no need for vi compatibility
filetype plugin on                " load plugin files for specific filetypes


" --- Appearance ------------
" ---------------------------

colorscheme nord                  " available colorschemes: palenight, neodark, one, deus, nord
" set background=dark             " available for the 'one' colorscheme

" transparent background
hi Normal guibg=NONE ctermbg=NONE

" indentation rules for specific file types
au FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab




" =======================================================================================
" ===================================== KEYBINDINGS =====================================
" =======================================================================================

let mapleader="\<space>"

" uppercase current word
inoremap <c-u> <esc>viwUea

" git status using tig with vim terminal mode
" --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L209
if has('nvim')
    nmap <leader>gs :nohlsearch<CR>:term tig status<CR>i
else
    nmap <leader>gs :nohlsearch<CR>:silent !tig status<CR>:GitGutter(All)<CR>:redraw!<CR>
endif

" clear search highlighting
" --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L148
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" don't lose selection when indenting //<- fdietze/dotfiles
" --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L104
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" shortcut to edit init.vim from within (n)vim
" --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L135
nnoremap <Leader>vv :e $MYVIMRC<CR>

" shortcut to source init.vim from within (n)vim
" --> https://learnvimscriptthehardway.stevelosh.com/chapters/07.html
nnoremap <Leader>sv :source $MYVIMRC<CR>

" toggle Goyo
nnoremap <Leader>g :Goyo<CR>
nnoremap <Leader>G :Goyo!<CR>

" open file in git project conveniently in new buffer
" --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L188
nnoremap <Leader>e :ProjectFiles<CR>

" l/L: next/prev buffer
" L was: place cursor at bottom of screen
" --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L34
nnoremap <silent> l :bnext<CR>
vnoremap <silent> l :bnext<CR>
nnoremap <silent> L :bprev<CR>
vnoremap <silent> L :bprev<CR>

" efficient one-button save/close bindings
" --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L41
nnoremap ö :update<CR>
vnoremap ö <esc>:update<CR>gv
nnoremap ä :q<CR>
vnoremap ä <esc>:q<CR>
nnoremap ü :bd<CR>
vnoremap ü <esc>:bd<CR>
" TODO: figure out why the following doesn't work:
" nnoremap <Leader>ü :BufOnly<CR>
" vnoremap <Leader>ü <esc>:BufOnly<CR>gv




" ========================================================================================
" =================================== CUSTOM FUNCTIONS ===================================
" ========================================================================================

" create non-existing parent directories on save
" --> https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" broken somehow -> TODO: fix
" smart home
" --> https://vim.fandom.com/wiki/Smart_home
function! SmartHome()
  let first_nonblank = match(getline('.'), '\S') + 1
  if first_nonblank == 0
    return col('.') + 1 >= col('$') ? '0' : '^'
  endif
  if col('.') == first_nonblank
    return '0'  " if at first nonblank, go to start line
  endif
  return &wrap && wincol() > 1 ? 'g^' : '^'
endfunction
noremap <expr> <silent> <Home> SmartHome()
imap <silent> <Home> <C-O><Home>

" fuzzy search files from git root
" --> https://github.com/junegunn/fzf.vim/issues/47#issuecomment-160237795
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()

