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
let g:airline_powerline_fonts = 1
call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'tpope/vim-fugitive'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'mxw/vim-jsx'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'fladson/vim-kitty', { 'branch' : 'main' }
Plug 'junegunn/fzf', {'dir': '~/.config/.fzf', 'do': './install --all'}
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
set nohlsearch
set nobackup
set undodir=~/.vim/undodir

" set up keybinds for easy toggling between splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" set keybind for toggling nerdtree
nnoremap <C-e> :NERDTreeToggle<CR>

"set some more plugin vars etc

" format with prettier followed by eslint for JS
let g:prettier#autoformat = 0
let g:ale_fixers = {
      \  '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript' : ['prettier', 'eslint'],
      \'python' : ['yapf'],
      \}

let g:ale_fix_on_save = 1

autocmd BufWritePre *.js,*.jsx,*.mjs,*.css,*.less,*.scss, PrettierAsync

" Call NerdTree only when we don't call with a file in the command
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

autocmd BufWritePre *.js Neoformat

" coc conf
source ~/.config/nvim/coc.vim
