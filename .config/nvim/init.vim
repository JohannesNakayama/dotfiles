" Inspired in parts by https://github.com/fdietze/dotfiles/ and others. See bottom of the document for references.


" --- Source additional scripts
source $HOME/.config/nvim/plugins.vim


" ========================================================================================
" === BASIC SETTINGS =====================================================================
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

" --- For coc.nvim (adapted from Github README)
set nobackup                      " coc vim may have problems with backup files
set nowritebackup
set signcolumn=yes

" --- Required for vimwiki
syntax on                         " syntax highlighting
set nocompatible                  " no need for vi compatibility
filetype plugin on                " load plugin files for specific filetypes


" --- APPEARANCE -----------------------------------------------------------------------
" --------------------------------------------------------------------------------------

" --- Available colorschemes:
"     - palenight
"     - neodark
"     - one
"     - deus
"     - nord
"     - nova
colorscheme nova

" --- Dark background available for the 'one' colorscheme
set background=dark

" --- Transparent background (uncomment to enable)
" hi Normal guibg=NONE ctermbg=NONE

" --- Indentation rules for specific file types
au FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
au FileType r setlocal shiftwidth=2 softtabstop=2 expandtab
au FileType dart setlocal shiftwidth=2 softtabstop=2 expandtab
au FileType nix setlocal shiftwidth=2 softtabstop=2 expandtab



" =======================================================================================
" === KEYBINDINGS =======================================================================
" =======================================================================================

let mapleader="\<space>"

" --- Git status using tig with vim terminal mode [1]
if has('nvim')
    nmap <leader>gs :nohlsearch<CR>:term tig status<CR>i
else
    nmap <leader>gs :nohlsearch<CR>:silent !tig status<CR>:GitGutter(All)<CR>:redraw!<CR>
endif

" --- Clear search highlighting [2]
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" --- Don't lose selection when indenting [3]
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" --- Shortcut to edit init.vim from within (n)vim [4]
nnoremap <Leader>vv :e $MYVIMRC<CR>

" --- Shortcut to source init.vim from within (n)vim [5]
nnoremap <Leader>sv :source $MYVIMRC<CR>

" --- Toggle Goyo
nnoremap <Leader>g :Goyo<CR>
nnoremap <Leader>G :Goyo!<CR>

" --- Open file in git project conveniently in new buffer [6]
nnoremap <Leader>e :ProjectFiles<CR>

" --- Cycle through buffers [7]
"     l/L: next/prev buffer
"     L was: place cursor at bottom of screen
nnoremap <silent> l :bnext<CR>
vnoremap <silent> l :bnext<CR>
nnoremap <silent> L :bprev<CR>
vnoremap <silent> L :bprev<CR>

" --- Efficient one-button save/close bindings [8]
nnoremap ö :update<CR>
vnoremap ö <esc>:update<CR>gv
nnoremap ä :q<CR>
vnoremap ä <esc>:q<CR>
nnoremap ü :bd<CR>
vnoremap ü <esc>:bd<CR>
" TODO: figure out why the following doesn't work:
" nnoremap <Leader>ü :BufOnly<CR>
" vnoremap <Leader>ü <esc>:BufOnly<CR>gv

" --- Toggle nerdtree
nnoremap <Leader>n :NERDTreeToggle<CR>

" --- Code completion (coc.nvim) key bindings
" inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : \"\<CR>"
" vnoremap <Leader>a <Plug>(coc-codeaction-selected)
" nnoremap <Leader>a <Plug>(coc-codeaction-selected)


" ========================================================================================
" === CUSTOM FUNCTIONS ===================================================================
" ========================================================================================

" --- Open a terminal from within vim
" " TODO: add parameter for split direction
" function OpenVimTerminal()
"     :new term://zsh
"     :resize 10
" endfunction
" command! OpenVimTerminal execute OpenVimTerminal()

" --- Create non-existing parent directories on save [9]
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

" --- Smart home [10]
" TODO: fix (broken somehow)
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

" --- Fuzzy search files from git root [11]
function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()


" --- REFERENCES -----------------------------------------------------------------------
" --------------------------------------------------------------------------------------

" [1] Git status using tig with vim terminal mode:
" -- https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L209
" [2] Clear search highlighting:
" -- https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L148
" [3] Don't lose selection when indenting:
" -- https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L104
" [4] Shortcut to edit init.vim from within (n)vim:
" -- https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L135
" [5] Shortcut to source init.vim from within (n)vim:
" -- https://learnvimscriptthehardway.stevelosh.com/chapters/07.html
" [6] Open file in git project conveniently in new buffer:
" -- https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L188
" [7] Cycle through buffers:
" -- https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L34
" [8] Efficient one-button save/close bindings (these are meant for the neo2 layout):
" -- https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L41
" [9] Create non-existing parent directories on save:
" -- https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
" [10] Smart home:
" -- https://vim.fandom.com/wiki/Smart_home
" [11] Fuzzy search files from git root:
" -- https://github.com/junegunn/fzf.vim/issues/47#issuecomment-160237795

