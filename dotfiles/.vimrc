" General
set nu rnu	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=++ 	" Wrap-broken line prefix
let textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace

set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally

set expandtab           " enter spaces when tab is pressed
set textwidth=120       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line


" Advanced
set confirm	" Prompts for confirmation
set ruler	" Show row and column ruler information
set autowriteall	" Auto-write all file changes
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
set clipboard=unnamedplus " Use system keyboard
syntax on               " syntax highlighting
set showcmd             " show (partial) command in status line

" Split layouts
set splitbelow

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes
set splitright


" Compatibility
set nocompatible

" alternate split keys for insert m(alt + arrow keys)
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" tab shortcuts (control h/L)
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>

let mapleader = " "
" easier write
nmap <leader>w :w<Enter>

" yar build
nmap <leader>b :!yarn build<Enter>

" silence search highlighting
nnoremap <leader>sh :nohlsearch<Bar>:echo<CR>
"paste from outside buffer
nnoremap <leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <leader>p <Esc>:set paste<CR>gv"+p:set nopaste<CR>
"copy to outside buffer
vnoremap <leader>y "+y
"paste from 0 register
"Useful because `d` overwrites the <quote> register
nnoremap <leader>P "0p
vnoremap <leader>P "0p


" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.c set expandtab
au BufRead,BufNewFile *.h set expandtab
au BufRead,BufNewFile Makefile* set noexpandtab
