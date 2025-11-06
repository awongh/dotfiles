" Enable line numbers and relative numbers
set number

" Enable syntax highlighting and set colorscheme
syntax on
set termguicolors
colorscheme desert  " Change this to your preferred theme

" Better searching
set ignorecase      " Case-insensitive search
set smartcase       " Case-sensitive if search contains uppercase
set incsearch       " Highlight matches as you type
set hlsearch        " Highlight all search matches

" Tabs & Indentation
set tabstop=4       " Number of spaces for a tab
set shiftwidth=4    " Number of spaces for autoindent
set expandtab       " Convert tabs to spaces
set autoindent      " Copy indentation from previous line

" Enable mouse support
set mouse=a

" Keybindings
nnoremap <Space> :nohlsearch<CR>  " Clear search highlights with Space

" Enable clipboard integration (if supported)
set clipboard=unnamedplus

