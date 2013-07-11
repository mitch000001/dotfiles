set nocp
" pathogen bundles
" setup all plugins
"let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
"if !filereadable(vundle_readme)
"    echo "Installing plugins..."
"    echo ""
"    silent !mkdir -p ~/.vim/bundle
"    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
"    let iCanHazVundle=0
"endif
filetype off
call pathogen#helptags()
call pathogen#infect()
syntax on
filetype plugin indent on
set autoread            " automatic update of files changed by other processes
set clipboard=unnamed   " enable clipboard cut&paste
" set nobackup            " don't make backup files
set encoding=utf-8      " for unicode glyphs
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

set ts=4
set sw=4
set sts=4
set et

set encoding=utf-8

" % matches on if/else, html tags, etc.
runtime macros/matchit.vim

" enable fancy powerline
" let g:Powerline_symbols = 'fancy'
if has("gui_running")
    " gui stuff
else
"    let g:Powerline_symbols = 'unicode'
endif

" Bash-like filename completion
set wildmenu
set wildmode=list:longest

au FileType ruby setl sw=2 sts=2 et autoindent
au FileType python setl sw=2 sts=2 et autoindent
autocmd Filetype gitcommit setlocal spell textwidth=72

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
