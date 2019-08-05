set nocompatible              " be iMproved, required
filetype off                  " required by vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'w0rp/ale'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'fatih/vim-go'

call vundle#end() " required by vundle
filetype plugin indent on " required by vundle

set backupdir=~/vimfiles/tmpfiles
set directory=~/vimfiles/tmpfiles

" size of a hard tabstop
set tabstop=4

" size of an "indent"
set shiftwidth=4

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

" make "tab" insert indents insted of tabs at the beginning of a line
" always uses spaces instead of tab characters
" auto indent
set smarttab expandtab autoindent

" utf8
set encoding=utf-8 fileencoding=utf8

" moving tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" line numbers
set number

" highlight search matches and incremental search
set hlsearch incsearch

" Tab navigation
map <Tab> :tabnext<CR>
map <S-Tab> :tabprevious<CR>

" Colorscheme
set t_Co=256
syntax enable
set background=dark
colorscheme gruvbox

" Show path/file name on the bottom of the window
set ls=2

" Enable folding
set foldmethod=manual
set foldlevel=20

" ctrl-p plugin
let g:ctrlp_working_path_mode = 'ra'

" disable arrow navigation keys in Normal mode
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
nnoremap <expr> <Up> ((bufname("%") is# "[Command Line]")?("\<Up>"):(""))

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme='base16_monokai'
let g:airline_powerline_fonts=1

" workaround to read alt key press on gnome-terminal
set ttimeout ttimeoutlen=500

" Python syntax
let g:python_self_cls_highlight = 1

" Specific filetypes ident
autocmd FileType yaml setlocal ts=2 sts=2 sw=2
autocmd FileType yml setlocal ts=2 sts=2 sw=2

" Mac backspace / Fix default vim deletion behavior
set backspace=indent,eol,start

" leader key
let mapleader = ","

" Leader Mappings
nmap <leader>z :call VimuxRunCommand("make test")<cr>
nmap <leader>r :call VimuxRunCommand("make run")<cr>
nmap <leader>p :call VimuxRunCommand("make lint")<cr>

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=1

" show hidden files in NERDTree
let NERDTreeShowHidden=1

" Toggle NERDTree
nmap <silent> <leader>k :NERDTreeToggle<cr>

" expand to the path of the file in the current buffer
nmap <silent> <leader>y :NERDTreeFind<cr>

" Ignore files
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

" CtrlP ignore patterns
let g:ctrlp_custom_ignore = {
            \ 'dir': '\.git$\|node_modules$\|\.hg$\|\venv$|\venv$\',
            \ 'file': '\.exe$\|\.so$'
            \ }
let g:ctrlp_show_hidden = 1

" Mac Clipboard issue
set clipboard+=unnamed

" TAGBAR
nmap <F8> :TagbarToggle<CR>
let g:tagbar_left=1
let g:tagbar_compact=1

nmap <silent> <leader>p :CtrlPTag<CR>
nmap <silent> <leader>t :TagbarOpen jf<CR>

" Search for visually selected text with //
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'

" A.L.E
" let g:ale_lint_on_text_changed="normal"
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Make :help appear in a full-screen tab, instead of a window
"Only apply to .txt files...
augroup HelpInTabs
    autocmd!
    autocmd BufEnter  *.txt   call HelpInNewTab()
augroup END

"Only apply to help files...
function! HelpInNewTab ()
    if &buftype == 'help'
        "Convert the help window to a tab...
        execute "normal \<C-W>T"
    endif
endfunction

" Use vim improved regex search
nnoremap / /\v

" Turn on case-insensitive matches (but only when pattern is all-lowercase)
set ignorecase
set smartcase

" Make delete key in Normal mode remove the persistently highlighted matches
nmap <silent> <BS> :nohlsearch<CR>
