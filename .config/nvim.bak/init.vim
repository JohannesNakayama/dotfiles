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
    Plug 'tpope/vim-fugitive'                           " git in vim
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
    Plug 'preservim/nerdtree'                           " file system explorer

    " TODO: figure out this plugin:
    " Plug 'numtostr/BufOnly.nvim', { 'on': 'BufOnly' }   " close all but current buffer

    " language support
    Plug 'derekwyatt/vim-scala', {'for': 'scala'}       " Scala programming language
    Plug 'JuliaEditorSupport/julia-vim'                 " Julia programming language
    Plug 'mattn/emmet-vim'                              " emmet for vim -> HTML support
    Plug 'udalov/kotlin-vim'                            " Kotlin programming language
    Plug 'dart-lang/dart-vim-plugin'                    " Dart programming language
    Plug 'tpope/vim-projectionist'

    " snippets
    " Plug 'SirVer/ultisnips'
    " Plug 'honza/vim-snippets'
    " Plug 'natebosch/dartlang-snippets'

    " colors
    Plug 'chrisbra/Colorizer'                           " color hex codes and color-names
    Plug 'drewtempelmeyer/palenight.vim'                " palenight color scheme
    Plug 'KeitaNakamura/neodark.vim'                    " neodark color scheme
    Plug 'rakr/vim-one'                                 " one color scheme
    Plug 'ajmwagar/vim-deus'                            " deus color scheme
    Plug 'arcticicestudio/nord-vim'                     " nord color scheme
    Plug 'zanglg/nova.vim'                              " nova color scheme

    " status line
    Plug 'itchyny/lightline.vim'                        " unintrusive status line
    Plug 'mengelbrecht/lightline-bufferline'            " tabs/buffers

    " vim repl
    " Plug 'karoliskoncevicius/vim-sendtowindow'

call plug#end()

let g:scala_scaladoc_indent = 1
let g:goyo_width = '60%'
let g:dart_format_on_save = 1
let g:dartfmt_options = ['--fix', '--line-length 120']
let g:NERDTreeGitStatusWithFlags = 1
let dart_html_in_string=v:true


" =======================================================================================
" ===================================== STATUS LINE =====================================
" =======================================================================================

" lightline config
let g:lightline = {
    \   'colorscheme': 'powerline',
    \   'active': {
    \     'left': [ [ 'mode', 'paste' ],
    \               [ 'readonly', 'filename', 'modified' ] ],
    \     'right': [ [ 'lineinfo' ],
    \                [ 'percent' ],
    \                [ 'fileformat', 'fileencoding', 'filetype' ] ],
    \   },
    \   'tabline': {
    \       'left': [ [ 'buffers' ] ],
    \       'right': [ [ 'gitbranch' ] ],
    \   },
    \   'component_function': {
    \       'filename': 'LightlineFilename',
    \       'gitbranch': 'FugitiveHead',
    \   },
    \   'component_expand' : {
    \       'buffers': 'lightline#bufferline#buffers',
    \   },
    \   'component_type': {
    \       'buffers': 'tabsel',
    \   },
    \ }

" trim (for paths in lightline)
" --> https://github.com/pirey/dotfiles/blob/b6707cd381c5d51f884ddbcac09a78a23129f6da/home/.config/nvim/plugin-options/lightline.vim#L46
function! s:trim(maxlen, str) abort
    let trimed = len(a:str) > a:maxlen ? a:str[0:a:maxlen] . '..' : a:str
    return trimed
endfunction

" display filenames in lightline
" --> https://github.com/pirey/dotfiles/blob/b6707cd381c5d51f884ddbcac09a78a23129f6da/home/.config/nvim/plugin-options/lightline.vim#L79
function! LightlineFilename() abort
    let l:prefix = expand('%:p') =~? "fugitive://" ? '(fugitive) ' : ''
    let l:maxlen = winwidth(0) - winwidth(0) / 2
    let l:relative = expand('%:.')
    let l:tail = expand('%:t')
    let l:noname = 'No Name'

    if winwidth(0) < 50
        return ''
    endif

    if winwidth(0) < 86
        return l:tail ==# '' ? l:noname : l:prefix . s:trim(l:maxlen, l:tail)
    endif

    return l:relative ==# '' ? l:noname : l:prefix . s:trim(l:maxlen, l:relative)
endfunction


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
set noshowmode                    " mode already displayed in status line
set showtabline=2                 " always show tabline
set updatetime=100                " decrease lag for gitgutter (in ms)
set splitbelow splitright         " window splits
set mouse=a                       " mouse support for simpler window management

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

" for coc.nvim (adapted from Github README)
set nobackup                      " coc vim may have problems with backup files
set nowritebackup
set signcolumn=yes

" required for vimwiki
syntax on                         " syntax highlighting
set nocompatible                  " no need for vi compatibility
filetype plugin on                " load plugin files for specific filetypes


" --- Appearance ------------
" ---------------------------

colorscheme nord                 " available colorschemes: palenight, neodark, one, deus, nord, nova
set background=dark              " available for the 'one' colorscheme

" transparent background
" hi Normal guibg=NONE ctermbg=NONE

" indentation rules for specific file types
au FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
au FileType r setlocal shiftwidth=2 softtabstop=2 expandtab
au FileType dart setlocal shiftwidth=2 softtabstop=2 expandtab




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

" " open new window in terminal mode
" nnoremap <Leader>t :OpenVimTerminal<CR>

" " mappings for window navigation
" nnoremap <c-i> <c-w>h
" nnoremap <c-l> <c-w>k
" nnoremap <c-a> <c-w>j
" nnoremap <c-e> <c-w>l

" " mappings for vim-sendtowindow
" let g:sendtowindow_use_defaults=0
" nmap <c-e><space> <Plug>SendRight
" xmap <c-e><space> <Plug>SendRightV
" nmap <c-i><space> <Plug>SendLeft
" xmap <c-i><space> <Plug>SendLeftV
" nmap <c-l><space> <Plug>SendUp
" xmap <c-l><space> <Plug>SendUpV
" nmap <c-a><space> <Plug>SendDown
" xmap <c-a><space> <Plug>SendDownV

" mappings for nerdtree
nnoremap <Leader>n :NERDTreeToggle<CR>

" " code completion (coc.nvim) key bindings
" inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
" vnoremap <Leader>a <Plug>(coc-codeaction-selected)
" nnoremap <Leader>a <Plug>(coc-codeaction-selected)


" ========================================================================================
" =================================== CUSTOM FUNCTIONS ===================================
" ========================================================================================

" " open a terminal from within vim
" " TODO: add parameter for split direction
" function OpenVimTerminal()
"     :new term://zsh
"     :resize 10
" endfunction
" command! OpenVimTerminal execute OpenVimTerminal()

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

