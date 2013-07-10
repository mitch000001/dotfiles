set nocp
" pathogen bundles
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#helptags()
call pathogen#infect()
syntax on
filetype plugin indent on
set showcmd
set number
set hidden
set history=1000
set title
set ruler
set hlsearch
set incsearch
set cursorline
" The offset when scrolling, i.e. the lines to show from cursor to bottom
set scrolloff=3
set smartindent
set laststatus=2          " Always show last status
set mouse=a             " Enable mouse support

set autoread            " automatic update of files changed by other processes
set clipboard=unnamed   " enable clipboard cut&paste

set ts=4
set sw=4
set sts=4
set et

set encoding=utf-8

" % matches on if/else, html tags, etc.
runtime macros/matchit.vim

" Bash-like filename completion
set wildmenu
set wildmode=list:longest

au FileType ruby setl sw=2 sts=2 et autoindent
au FileType python setl sw=2 sts=2 et autoindent
autocmd Filetype gitcommit setlocal spell textwidth=72

let NERDTreeChDirMode=2

let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|vendor/bundle|public/javascripts/compiled|node_modules|venv$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_clear_cache_on_exit = 1

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
au FocusLost * :set number
au FocusGained * :set relativenumber
