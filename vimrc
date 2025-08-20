" Optimized vimrc - Performance and efficiency improvements
" =======================================================

" Plugin Management
call plug#begin('~/.vim/bundle')

" Core functionality
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                    " Modern fuzzy finder (replaces CtrlP)
Plug 'dense-analysis/ale'                  " Updated ALE repo
Plug 'tpope/vim-fugitive'                  " Git integration

" UI enhancements  
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/tagbar'                    " Updated tagbar repo

" Language support
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Colorscheme (single theme)
Plug 'sainnhe/gruvbox-material'

" Tmux integration
Plug 'edkolev/tmuxline.vim'

" Org-mode support (consolidated)
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'               " Required for org-mode
Plug 'vim-scripts/utl.vim'                 " Required for org-mode
Plug 'inkarkat/vim-SyntaxRange'            " Required for org-mode

call plug#end()

" Basic Vim Settings
" ==================
filetype plugin indent on
syntax enable

" Terminal and colors
if has('termguicolors')
    set termguicolors
endif
set background=dark
colorscheme gruvbox-material

" Performance optimizations
set lazyredraw                             " Don't redraw during macros
set ttyfast                                " Faster terminal connection
set ttimeout ttimeoutlen=10                " Faster escape sequences

" File handling
set backupdir=~/.vimtmp//                  " Double slash for unique filenames
set directory=~/.vimtmp//
set undodir=~/.vimtmp//
set undofile                               " Persistent undo

" Indentation (consistent settings)
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab smarttab autoindent
set smartindent                            " Better auto-indentation

" Search and navigation
set number                                 " Line numbers
set hlsearch incsearch
set ignorecase smartcase
set wildmenu wildmode=list:longest,full    " Better command completion

" UI improvements
set laststatus=2                           " Always show status line
set showcmd                                " Show command in status line
set cursorline                             " Highlight current line
set scrolloff=3                            " Keep context when scrolling
set backspace=indent,eol,start

" Encoding
set encoding=utf-8

" Folding
set foldmethod=syntax foldlevelstart=20    " Syntax-based folding, start open

" Clipboard (macOS)
if has('mac')
    set clipboard=unnamed
endif

" Key Mappings
" ============
let mapleader = ","
let maplocalleader = ","

" Navigation improvements
nnoremap j gj
nnoremap k gk
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Clear search highlighting
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Better regex search
nnoremap / /\v
vnoremap / /\v

" Tab navigation
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" File browser (netrw)
nnoremap <silent> <leader>y :Vex<CR>

" Netrw settings and mappings
augroup netrw_mapping
    autocmd!
    autocmd FileType netrw nnoremap <buffer> <silent> <ESC> <C-w>c
augroup END

" Visual selection search
vnoremap <silent> * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" Plugin Configuration
" ====================

" FZF (replaces CtrlP)
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Rg<CR>
nnoremap <silent> <leader>t :Tags<CR>
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" FZF fallbacks for systems without ripgrep
if !executable('rg')
    nnoremap <silent> <leader>f :Ag<CR>
    if !executable('ag')
        nnoremap <silent> <leader>f :grep -r "" . --include="*"<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
    endif
endif


" ALE Configuration (optimized)
let g:ale_lint_on_text_changed = 'never'   " Only lint on save/enter
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {
\   'go': ['gopls', 'govet'],
\   'yaml': ['yamllint'],
\   'python': ['pylsp', 'mypy'],
\}
let g:ale_fixers = {
\   'go': ['gofmt', 'goimports'],
\   'python': ['black', 'isort'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" Airline Configuration
let g:airline_theme = 'gruvbox_material'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tmuxline#enabled = 1

" Tagbar
nnoremap <silent> <F8> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_compact = 1
let g:tagbar_autofocus = 1

" Vim-Go (optimized settings)
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_fmt_command = 'goimports'
let g:go_auto_type_info = 1

" Essential highlighting only (performance)
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1

" Autocommands
" ============
augroup vimrc_autocommands
    autocmd!
    
    " Help in new tab
    autocmd BufEnter *.txt call s:HelpInNewTab()
    
    " Language-specific settings
    autocmd FileType gitcommit setlocal spell
    autocmd FileType markdown setlocal spell wrap linebreak
    autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
    autocmd FileType yaml,html,css,javascript setlocal tabstop=2 shiftwidth=2
    
    " Remove trailing whitespace on save
    autocmd BufWritePre * :%s/\s\+$//e
    
    " Return to last cursor position
    autocmd BufReadPost * 
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
        
augroup END

function! s:HelpInNewTab()
    if &buftype == 'help'
        execute "normal! \<C-W>T"
    endif
endfunction

" Tmuxline Configuration (original working setup with minimal fixes)
let g:tmuxline_status_justify = 'left'
let g:tmuxline_preset = {
      \'a'      : '#S',
      \'cwin'   : ['#I', '#W', '#{?window_zoomed_flag,Z,}'],
      \'win'    : ['#I', '#W'],
      \'y'      : ['%H:%M', '%d-%m-%Y'],
      \'x'      : ['#(tmux-mem-cpu-load -q -m 0 -a 0 -t 0 -g 0 --interval 3)'],
      \'z'      : '#H',
      \'options' : {'message-style' : 'fg=colour235, bg=colour252, bold'},
      \}
let g:tmuxline_theme = {
    \   'a'    : [ 000, 255 ],
    \   'b'    : [ 253, 239 ],
    \   'c'    : [ 244, 236 ],
    \   'x'    : [ 244, 236 ],
    \   'y'    : [ 253, 239 ],
    \   'z'    : [ 232, 231 ],
    \   'win'  : [ 231, 236, "none" ],
    \   'cwin' : [ 232, 231, "bold" ],
    \   'last' : [ 231, 236, "none" ],
    \   'bg'   : [ 244, 236 ],
    \ }

" Only reload tmuxline once when vim starts (prevents blinking)
if exists('$TMUX')
    augroup tmuxline_init
        autocmd!
        autocmd VimEnter * call timer_start(100, function('s:DelayedTmuxlineSetup'))
    augroup END
endif

function! s:DelayedTmuxlineSetup(timer)
    if exists(':Tmuxline')
        try
            silent! exe ':Tmuxline'
            silent! call system("tmux source ~/.tmux.conf")
        catch
            " Silently ignore errors to prevent vim startup issues
        endtry
    endif
endfunction

" Custom theme overrides (minimal)
highlight link Todo GruvboxYellowBold
highlight link Comment GruvboxGray