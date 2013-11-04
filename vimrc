" Delete all previous set autocommands
" Useful when reloading the rc while editing
autocmd!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN INITIALIZATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let dot_vim_update=expand('~/.vim/update')
if !filereadable(dot_vim_update)
    echom "Installing plugins..."
    echom ""
    silent !git clone git@github.com:mitch000001/dotvim ~/.vim --recursive
endif
silent !~/.vim/update

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocp
filetype off
syntax on
filetype plugin indent on

set autoread            " automatic update of files changed by other processes
set clipboard=unnamed   " enable clipboard cut&paste
" set nobackup            " don't make backup files

" set the backupdir to a custom folder
let vim_backup_dir=expand('~/.vim_backup')
if !isdirectory(vim_backup_dir)
  silent !mkdir ~/.vim_backup
endif
set backupdir=~/.vim_backup/
let vim_swap_dir=expand('~/.vim_swap')
if !isdirectory(vim_swap_dir)
  silent !mkdir ~/.vim_swap
endif
set directory=~/.vim_swap/
set encoding=utf-8      " for unicode glyphs
set showcmd  " Display incomplete commands
set showmode " Display the mode you're in."

" show line numbers
set number

" hide buffers in background when switching
" the active buffer to another file
set hidden

" remember more commands and search history
set history=10000
set title
set ruler
set hlsearch
set incsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
" set t_ti= t_te=

set cursorline          " highlight current cursorline

" The offset when scrolling, i.e. the lines to show from cursor to bottom
set scrolloff=3
set smartindent
set laststatus=2        " Always show last status
set mouse=a             " Enable mouse support
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set ts=2
set sw=2
set sts=2
set et
set list                " show whitespace characters
" Custom displaying of special characters
set listchars=tab:▸\ ,trail:·,nbsp:·,eol:¬,extends:»,precedes:« " define characters when 'wrap' is off

" Buffer options
set switchbuf=useopen " Open files e.g. from quicksearch within last selected window buffer

" Bash-like filename completion
set wildmenu
set wildmode=longest,list
let g:max_line_width = 80

" Toggle ColorColumn
function! ToggleColorColumn()
  if &colorcolumn != ""
    let &l:colorcolumn=""
  else
    let &l:colorcolumn=g:max_line_width
  endif
endfunction

command! ToggleColorColumn :call ToggleColorColumn()

" Colors
colorscheme desert
" set background=dark
" solarized options
" let g:solarized_termcolors = 256
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
" colorscheme solarized

let g:rspec_command = "Dispatch bundle exec rspec {spec}"

" --------- "
"  Mappings "
" --------- "
"
" Set '/' in visual mode to search for the current selection
" The \V tells the regex engine that only '\' has a special meaning
vnoremap / y/\V<C-R>"<CR>
vnoremap ? y?\V<C-R>"<CR>
" A more german keyboard friendly mapleader
let mapleader = ","
" Rspec.vim mappings
map <Leader>t :call RunNearestSpec()<CR>
map <Leader>T :call RunCurrentSpecFile()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>u :GundoToggle<CR>
nnoremap <silent> <Leader>. :ToggleColorColumn<CR>
nnoremap <leader><Space> :ToggleRemoveTrailingWhitespace<cr>
nnoremap <Leader>f :Ack<space>
nnoremap <F9> :Dispatch<CR>

" Catch all paste commands and wrap in pastemode
"inoremap <D-V> <C-O>:set paste<CR><D-V><C-O>:set nopaste<CR>
imap <D-V> :echo "PASTE"
" inoremap <C-V> <C-O>:set paste<CR><C-V><C-O>:set nopaste<CR>
inoremap jk <esc>

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
" au BufWritePre * :%s/\s\+$//e
augroup whitespace
augroup END

function! ToggleRemoveTrailingWhitespace()
  if b:Remove_trailing_whitespace
    augroup whitespace
      au!
    augroup END
    let b:Remove_trailing_whitespace=0
    echom "Remove trailing whitespace is off"
  else
    augroup whitespace
      au BufWritePre <buffer> :%s/\s\+$//e
    augroup END
    let b:Remove_trailing_whitespace=1
    echom "Remove trailing whitespace is on"
  endif
endfunction
command! ToggleRemoveTrailingWhitespace call ToggleRemoveTrailingWhitespace()
function! RemoveTrailingWhitespaceEnable()
  let b:Remove_trailing_whitespace=1
  au whitespace BufWritePre <buffer> :%s/\s\+$//e
endfunction
command! RemoveTrailingWhitespaceEnable call RemoveTrailingWhitespaceEnable()

au BufEnter * :RemoveTrailingWhitespaceEnable
au BufEnter * :setlocal colorcolumn=""

au FileType ruby setl sw=2 sts=2 et autoindent let b:dispatch = "bundle exec rspec %'""
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

autocmd InsertEnter * :set nu nornu
autocmd InsertLeave * :set nu rnu
au FocusLost * :set nu nornu
au FocusGained * :set nu rnu

function! CurrentFilePath()
  return resolve(expand("%:p"))
endfunction
command! CurrentFilePath call CurrentFilePath()

function! TabEditCurrentFile()
  tabedit +execute 'e ' . CurrentFilePath()
endfunction

" Borrowed from Gary Bernhardt
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Diff tab management: open the current git diff in a tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! GdiffInTab tabedit %|vsplit|Gdiff
nnoremap <leader>d :GdiffInTab<cr>
nnoremap <leader>D :tabclose<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MapCR()
  nnoremap <cr> :call RunTestFile()<cr>
endfunction
"call MapCR()
nnoremap <leader>T :call RunNearestTest()<cr>
nnoremap <leader>a :call RunTests('')<cr>
nnoremap <leader>c :w\|:!script/features<cr>
nnoremap <leader>w :w\|:!script/features --profile wip<cr>

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number)
endfunction

function! SetTestFile()
  " Set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction

function! RunTests(filename)
  " Write the file and run tests for the given filename
  if expand("%") != ""
    :w
  end
  if match(a:filename, '\.feature$') != -1
    exec ":!script/features " . a:filename
  else
    " First choice: project-specific test script
    if filereadable("script/test")
      exec ":!script/test " . a:filename
      " Fall back to the .test-commands pipe if available, assuming someone
      " is reading the other side and running the commands
    elseif filewritable(".test-commands")
      let cmd = 'rspec --color --format progress --require "~/lib/vim_rspec_formatter" --format VimFormatter --out tmp/quickfix'
      exec ":!echo " . cmd . " " . a:filename . " > .test-commands"

      " Write an empty string to block until the command completes
      sleep 100m " milliseconds
      :!echo > .test-commands
      redraw!
      " Fall back to a blocking test run with Bundler
    elseif filereadable("Gemfile")
      exec ":!bundle exec rspec --color " . a:filename
      " Fall back to a normal blocking test run
    else
      exec ":!rspec --color " . a:filename
    end
  end
endfunction

