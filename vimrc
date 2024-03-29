call plug#begin('~/.vim/bundle')

Plug 'gmarik/Vundle.vim'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'fatih/vim-go'
Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/taglist.vim' " vim-orgmode related
Plug 'tpope/vim-speeddating' " vim-orgmode related
Plug 'vim-scripts/utl.vim'  " vim-orgmode related
Plug 'inkarkat/vim-SyntaxRange'  " vim-orgmode related
Plug 'sainnhe/gruvbox-material'
Plug 'edkolev/tmuxline.vim'

call plug#end()
filetype plugin on

if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

set background=dark
set t_Co=256
colorscheme gruvbox-material

" Override global theme colors
hi Comment cterm=NONE term=bold ctermfg=245 guifg=#928374
hi clear Todo
hi Todo    term=bold cterm=bold ctermfg=175 gui=bold guifg=#dadada
hi hyperlink term=underline cterm=underline ctermfg=109 guifg=#83a598
hi Folded cterm=bold gui=bold

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme='gruvbox_material'
let g:airline_powerline_fonts=1
let g:airline#extensions#tmuxline#enabled = 1

set backupdir=~/.vimtmp/
set directory=~/.vimtmp/

" size of a hard tabstop
set tabstop=4

" Global indent size
set shiftwidth=4

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

" make "tab" insert indents insted of tabs at the beginning of a line
" always uses spaces instead of tab characters
set smarttab expandtab autoindent

" utf8
set encoding=utf-8 fileencoding=utf8

" line numbers
set number

" highlight search matches and incremental search
set hlsearch incsearch

" Tab navigation
map <Tab> :tabnext<CR>
map <S-Tab> :tabprevious<CR>

" Show path/file name on the bottom of the window
set ls=2

" Enable folding
set foldmethod=manual
set foldlevel=20

" ctrl-p plugin
let g:ctrlp_working_path_mode = 'ra'

" disable arrow navigation keys in Normal mode
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
nnoremap <expr> <Up> ((bufname("%") is# "[Command Line]")?("\<Up>"):(""))

" workaround to read alt key press on gnome-terminal
set ttimeout ttimeoutlen=500

" Specific filetypes ident

" Mac backspace / Fix default vim deletion behavior
set backspace=indent,eol,start

" Leader key
let mapleader = ","
let maplocalleader = ","

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=1

" show hidden files in NERDTree
let NERDTreeShowHidden=1

" Toggle NERDTree
nmap <silent> <leader>k :NERDTreeToggle<cr>

" Expand to the path of the file in the current buffer
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
let g:ale_lint_on_text_changed="normal"
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Linters
let g:ale_linters = {'yaml': ['yamllint',]}
let g:ale_yaml_yamllint_options =
    \'-d "{extends: default, rules: {line-length: {max: 119, level: warning}}}"'

" Make :help appear in a full-screen tab, instead of a window
"Only apply to .txt files...
augroup HelpInTabs
    autocmd!
    autocmd BufEnter  *.txt   call HelpInNewTab()
augroup END

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

" Print current date
" https://vim.fandom.com/wiki/Insert_current_date_or_time
nnoremap <F5> "=strftime("%a, %d %b %Y %H:%M:%S %z")<CR>P

" Automatically enable Spell for mardown and gitcommit files
augroup filetypedetect
    autocmd FileType gitcommit setlocal spell
augroup END

" TMUX integration customizations
let g:tmuxline_theme = 'zenburn'
let g:tmuxline_status_justify = 'left'
let g:tmuxline_preset = {
      \'a'      : '#S',
      \'cwin'   : ['#I', '#W', '#{?window_zoomed_flag,Z,}'],
      \'win'    : ['#I', '#W'],
      \'y'      : ['%H:%M', '%d-%m-%Y'],
      \'x'      : ['#(tmux-mem-cpu-load -q -m 0 -a 0 -t 0 -g 0 --interval 2)'],
      \'z'      : '#H',
      \'options' : {'message-style' : 'fg=colour235, bg=colour252, bold'},
      \}

" Reload tmuxline and tmux conf when entering vim to get the
" customizations loaded properly
if exists('$TMUX')
    autocmd VimEnter *
        \ if exists(':Tmuxline') |
            \ exe ':Tmuxline' |
            \ silent exec "!tmux source ~/.tmux.conf" |
        \ endif
endif

" ORGMODE Configuration
" ftplugin -> ~/.vim/ftplugin/org.vim
