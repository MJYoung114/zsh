" Basic Vim configuration (no plugins)

syntax on
filetype plugin indent on

set number
set nowrap
set hidden

" Tabs and indentation
set expandtab
set shiftwidth=2
set tabstop=2
set smartindent

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" UI
set ruler
set showcmd
set laststatus=2
set termguicolors

" Backups/Swap
set noswapfile
set nobackup
set nowritebackup

" Keep it simple; Neovim is preferred for advanced use

