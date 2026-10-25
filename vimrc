" leader key - change this to something else later
"let mapleader = ','

set t_Co=256

set term=xterm-256color

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" set filetype things
" https://vi.stackexchange.com/questions/10124/what-is-the-difference-between-filetype-plugin-indent-on-and-filetype-indent
filetype plugin indent on

syntax enable

" searching things
set hlsearch
set showmatch


" ==================================================================
" ==================================================================
" ==================================================================
" ==================================================================
" ==================================================================
" ==================================================================
" ==================================================================
" ==================================================================

"                             PLUGINS

" ==================================================================
" ==================================================================
" ==================================================================

call plug#begin('~/.vim/plugged')

" Reload .vimrc
" Run :PlugInstall to install plugins.




Plug 'adelarsq/vim-matchit'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'

Plug 'tomlion/vim-solidity'

Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'kien/rainbow_parentheses.vim', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }

Plug 'leafgarland/typescript-vim'



" Initialize plugin system
call plug#end()

" ==================================================================
" ==================================================================
" ==================================================================
" ==================================================================
" ==================================================================
" ==================================================================
" ==================================================================

" color stuff
set background=dark
colorscheme solarized
let g:solarized_termcolors=256

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd " Show (partial) command in status line.
set showmatch " Show matching brackets.
set ignorecase " Do case insensitive matching
set smartcase " Do smart case matching
set incsearch " Incremental search
"set autowrite " Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned

" show line numbers
set number

" set tabs to spaces
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2                                            " insert mode tab and backspace use 2 spaces
set expandtab                                                " expand tabs to spaces

set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set clipboard+=unnamed
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set showcmd
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=sgr
endif

" newline without insert!
" map e o<CR><Esc>

" tabs to spaces!!
" :%s/\t/  /g

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

let NERDTreeShowHidden=1

" Toggle display of the tree with <Leader> + n:
nmap <leader>n :NERDTreeToggle<CR>

" Locate the focused file in the tree with <Leader> + j:
nmap <leader>j :NERDTreeFind<CR>

" Always open the tree when booting Vim, but don’t focus it:
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

filetype plugin on

" matchit plugin html closing tag match
set matchpairs+=<:>

" turn off auto comments on the next line
set formatoptions-=cro
setl noai nocin nosi inde=

" https://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" delete/backspace keys
set backspace=indent,eol,start

setlocal foldmethod=syntax
" folding: zo
" folding with {{{
set fdm=marker

" }}}

" command t
map <Esc>[A <Up>
map <Esc>[B <Down>
map <Esc>[C <Right>
map <Esc>[D <Left>

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
