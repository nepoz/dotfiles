"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"Loading Plugins"
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/joshdick/onedark.vim.git'
Plug 'https://github.com/sheerun/vim-polyglot.git'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree'
Plug 'dense-analysis/ale'
call plug#end()

"screw compatibility"
set nocompatible

"indentation"
set autoindent
set expandtab
set tabstop=4

"Searching"
set ic
set smartcase
set hlsearch

"Performance"
set lazyredraw

"Text rendering"
set encoding=utf-8
set linebreak
syntax on
set wrap

"UI"
colorscheme onedark
let g:airline_theme='onedark'
let g:onedark_termcolors=256

set number
set noerrorbells
set title

"Linting:
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

"Code Folding"
set foldmethod=indent
set foldnestmax=3

"Convinience stuff"
set history=1000
set noswapfile
set spell
