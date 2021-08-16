let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin('~/.vim/plugged')
        Plug 'farmergreg/vim-lastplace'                     " cursor in position of last open
        Plug 'tpope/vim-sensible'                           " sane defaults
        Plug 'airblade/vim-gitgutter'                       " VCS change info per line (only git)
        Plug 'tpope/vim-commentary'                         " commenting
        Plug 'tpope/vim-surround'                           " surround text with quotes, parantheses, ...
        Plug 'PeterRincker/vim-argumentative'               " text object ',' / also provides argument movements with >, ],
        Plug 'tpope/vim-eunuch'                             " unix commands
        Plug 'zirrostig/vim-schlepp'                        " Move selections / lines
        Plug 'derekwyatt/vim-scala', {'for': 'scala'}       " Scala programming language
        Plug 'JuliaEditorSupport/julia-vim'                 " Julia programming language
        Plug 'rhysd/vim-gfm-syntax'                         " Github flavoured markdown with embedded language support
        Plug 'chrisbra/Colorizer'                           " color hex codes and color-names
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy completion
        Plug 'junegunn/fzf.vim'
        Plug 'drewtempelmeyer/palenight.vim'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'

        let g:airline#extensions#tabline#enabled = 1
call plug#end()

set number                        " show line number
set cursorline                    " highlight current line
set hidden                        " switch unsaved buffers
set clipboard=unnamedplus         " vim clipboard = system clipboard
set confirm                       " ask for save on close
set inccommand=nosplit            " live substitution preview
set ignorecase                    " smart case sensitive search
set smartcase                     "              "
set hls                           " hightlight search results
set list
set listchars=tab:⊳\ ,trail:·     " display whitespaces
set breakindent                   " indent wrapped lines
set breakindentopt=shift:2
set gdefault                      " substitute all occurrences in line per default
set tabstop=4                     " tab size to 4
set shiftwidth=4                  " if return: indent by 4
set expandtab                     " always uses spaces instead of tab characters
set nostartofline                 " keep column position when switching buffers
set background=dark
set termguicolors                 " true color support
colorscheme palenight

" don't lose selection when indenting
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

nnoremap <Leader>vv :e ~/.config/nvim/init.vim<CR>

" prefix for kedbindings
let mapleader="\<space>"

" l/L: next/prev buffer
" L was: place cursor at bottom of screen
nnoremap <silent> l :bnext<CR>
vnoremap <silent> l :bnext<CR>
nnoremap <silent> L :bprev<CR>
vnoremap <silent> L :bprev<CR>

" efficient one-button save/close bindings
nnoremap ö :update<CR>
vnoremap ö <esc>:update<CR>gv
nnoremap ä :q<CR>
vnoremap ä <esc>:q<CR>
nnoremap ü :bd<CR>
vnoremap ü <esc>:bd<CR>
nnoremap <Leader>ü :BufOnly<CR>
vnoremap <Leader>ü <esc>:BufOnly<CR>gv

nmap <leader>e :ProjectFiles<CR>

" create non-existing parent directories on save
" https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
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

" smart home
function! SmartHome()
  " https://vim.fandom.com/wiki/Smart_home
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

" https://github.com/junegunn/fzf.vim/issues/47#issuecomment-160237795
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()
