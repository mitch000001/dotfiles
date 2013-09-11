set nocp
" pathogen bundles
" setup all plugins
let dot_vim_update=expand('~/.vim/update')
if !filereadable(dot_vim_update)
    echo "Installing plugins..."
    echo ""
    silent !git clone git@github.com:mitch000001/dotvim ~/.vim --recursive
endif
silent !~/.vim/update
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on

set autoread            " automatic update of files changed by other processes
set clipboard=unnamed   " enable clipboard cut&paste
" set nobackup            " don't make backup files
set encoding=utf-8      " for unicode glyphs
set showcmd
set number
set hidden              " hide buffers in background when switching 
                        " the active buffer to another file
set history=1000
set title
set ruler
set hlsearch
set incsearch
set ignorecase          " ignore case when searching
set cursorline
" The offset when scrolling, i.e. the lines to show from cursor to bottom
set scrolloff=3
set smartindent
set laststatus=2        " Always show last status
set mouse=a             " Enable mouse support
set backspace=2

set ts=2
set sw=2
set sts=2
set et
set list                "show whitespace characters
set listchars=tab:▸\ ,trail:·,nbsp:·,eol:$

" Bash-like filename completion
set wildmenu
set wildmode=list:longest

colorscheme desert

" % matches on if/else, html tags, etc.
runtime macros/matchit.vim

" enable fancy powerline
if has("gui_running")
    " let g:Powerline_symbols = 'fancy'
    " gui stuff
else
    " let g:Powerline_symbols = 'unicode'
endif

" remove trailing whitespace
au BufWritePre * :%s/\s\+$//e

au FileType ruby setl sw=2 sts=2 et autoindent
au FileType Ruby setl sw=2 sts=2 et autoindent
au FileType python setl sw=2 sts=2 et autoindent
au FileType coffee setl sw=2 sts=2 et autoindent
au FileType haml setl sw=2 sts=2 et autoindent
au Filetype gitcommit setlocal spell textwidth=72

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
