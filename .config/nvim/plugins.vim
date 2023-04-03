" =======================================================================================
" === PLUGINS ===========================================================================
" =======================================================================================

" --- Automatically install vim-plug [1]
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- Call vim-plug
call plug#begin('~/.vim/plugged')

    " --- Utilities
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

    Plug 'neoclide/coc.nvim', {'branch': 'release'}     " code completion

    Plug 'preservim/nerdtree'                           " file system explorer

    " TODO: figure out this plugin:
    " Plug 'numtostr/BufOnly.nvim', { 'on': 'BufOnly' }   " close all but current buffer

    " --- Language support

    Plug 'derekwyatt/vim-scala', {'for': 'scala'}       " Scala programming language
    let g:scala_scaladoc_indent = 1

    Plug 'JuliaEditorSupport/julia-vim'                 " Julia programming language
    Plug 'mattn/emmet-vim'                              " emmet for vim
    Plug 'udalov/kotlin-vim'                            " Kotlin programming language
    Plug 'tpope/vim-projectionist'
    Plug 'LnL7/vim-nix'                                 " Nix language
    Plug 'rust-lang/rust.vim'                           " Rust programming language

    " --- Snippets
    " Plug 'SirVer/ultisnips'
    " Plug 'honza/vim-snippets'

    " --- Colors
    Plug 'chrisbra/Colorizer'                           " color hex codes and color-names
    Plug 'drewtempelmeyer/palenight.vim'                " palenight color scheme
    Plug 'KeitaNakamura/neodark.vim'                    " neodark color scheme
    Plug 'rakr/vim-one'                                 " one color scheme
    Plug 'ajmwagar/vim-deus'                            " deus color scheme
    Plug 'arcticicestudio/nord-vim'                     " nord color scheme
    Plug 'zanglg/nova.vim'                              " nova color scheme

    " --- Status line
    Plug 'itchyny/lightline.vim'                        " unintrusive status line
    Plug 'mengelbrecht/lightline-bufferline'            " tabs/buffers

call plug#end()

" --- Nerdtree
let g:NERDTreeGitStatusWithFlags = 1

" --- Width of goyo distraction-free mode
let g:goyo_width = '60%'

" --- Coc extensions
" let g:coc_global_extensions = [
"     \ 'coc-snippets',
"     \ 'coc-json',
"     \ 'coc-emmet',
"     \ 'coc-css',
"     \ 'coc-html',
"     \ 'coc-prettier',
"     \ 'coc-sql',
"     \ ]

" --- Lightline config
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

" --- Trim (for paths in lightline) [2]
function! s:trim(maxlen, str) abort
    let trimed = len(a:str) > a:maxlen ? a:str[0:a:maxlen] . '..' : a:str
    return trimed
endfunction

" --- Display filenames in lightline [3]
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


" --- REFERENCES -----------------------------------------------------------------------
" --------------------------------------------------------------------------------------

" [1] Automatically install vim-plug:
" -- https://github.com/junegunn/vim-plug/wiki/tips
" [2] Trim paths for lightline:
" -- https://github.com/pirey/dotfiles/blob/b6707cd381c5d51f884ddbcac09a78a23129f6da/home/.config/nvim/plugin-options/lightline.vim#L46
" [3] Display filenames in lightline:
" -- https://github.com/pirey/dotfiles/blob/b6707cd381c5d51f884ddbcac09a78a23129f6da/home/.config/nvim/plugin-options/lightline.vim#L79

