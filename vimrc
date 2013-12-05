"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        VIMRC of Michael Wagner                            "
"                  Read, use and share at your own pleasure                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: PLUGIN INITIALIZATION {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN REPOSITORY INITIALIZATION {{{2
let s:dot_vim_update=expand('~/.vim/update')
if !filereadable(s:dot_vim_update)
  echom "Installing plugins..."
  echom ""
  " Fetching .vim folder repository
  silent !git clone --recursive git@github.com:mitch000001/dotvim ~/.vim
endif
" Update plugins using repository script
execute ":silent !" . s:dot_vim_update

" }}}
" PATHOGEN INITIALIZATION {{{2
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" }}}
" BUILDIN MACROS {{{2
" % matches on if/else, html tags, etc.
runtime macros/matchit.vim

" }}}
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: BASIC CONFIGURATION SETUP {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
syntax on
filetype plugin indent on

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: VARIABLES {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DIRECTORY VARIABLES {{{2
let s:vim_backup_dir=expand('$HOME/.vim_backup')
let s:vim_swap_dir=expand('$HOME/.vim_swap')

" }}}
" PLUGIN CONFIGURATION {{{2
" RSPEC CONFIGURATION {{{3
let g:rspec_command = "Dispatch bundle exec rspec {spec}"

" }}}
" NERDTREE CONFIGURATION {{{3
" Change current working dir when loaded and when root dir changes
let NERDTreeChDirMode=2

" }}}
" CTRL-P CONFIGURATION {{{3
" How to set CtrlP's local working directory.
" Search for VCS-files to set CWD ('r')
"   use CWD outside of CTRL-P as fallback ('w')
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_show_hidden = 1             " Show hidden files when using CTRL-P
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)|vendor/bundle|public/javascripts/compiled|node_modules|venv$',
      \ 'file': '\v\.(exe|so|dll|pyc)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
let g:ctrlp_clear_cache_on_exit = 1    " Clear cache in exit

" }}}
" POWERLINE CONFIGURATION {{{3
" enable fancy powerline
if has("gui_running")
  " let g:Powerline_symbols = 'fancy'
  " gui stuff
else
  " let g:Powerline_symbols = 'unicode'
endif

" }}}
" }}}
let g:max_line_width = 80
let g:xml_syntax_folding = 1
let g:current_database = ""
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: OPTIONS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LEADER KEYS {{{2
let mapleader = ","       " A more german keyboard friendly mapleader

" }}}
" BACKUP AND SWAP {{{2
" set nobackup            " don't make backup files

if !isdirectory(s:vim_backup_dir)
  execute ":silent !mkdir " . s:vim_backup_dir
endif

let &backupdir=s:vim_backup_dir " set the backupdir to a custom folder

if !isdirectory(s:vim_swap_dir)
  execute ":silent !mkdir " . s:vim_swap_dir
endif

let &directory=s:vim_swap_dir " set the swapdir to a custom folder
" }}}

set autoread          " automatic update of files changed by other processes
set autowrite         " Automatically save before commands like :next and :make

set clipboard=unnamed " enable clipboard cut&paste

set encoding=utf-8    " for unicode glyphs
set showcmd           " Show (partial) command in status line.
set showmatch         " Show matching brackets.
set showmode          " Display the mode you're in.

" show line numbers
set number

" hide buffers in background when switching
" the active buffer to another file
set hidden

" Toggle paste mode
set pastetoggle=<F2>

" remember more commands and search history
set history=10000

" © [2]
" persist state between vim session
set viminfo=!,'20,<50,s10,h

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
set sidescrolloff=5

set virtualedit=block
set smartindent
set laststatus=2        " Always show last status
set mouse=a             " Enable mouse support
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set smarttab        " sw at the start of the line, sts everywhere else
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab           " expand all tabs to spaces
set list                " show whitespace characters
" Custom displaying of special characters
" define custom characters for line endings etc
set listchars=tab:▸\ ,trail:·,nbsp:·,eol:¬
" define characters to indicate long lines when 'wrap' is off
set listchars+=extends:»,precedes:«

"" Buffer options
" Open files e.g. from quicksearch within last selected window buffer
set switchbuf=useopen

" Bash-like filename completion in command line
set wildmenu
set wildmode=longest,list

set foldmethod=marker " Enable folding with custom markers

set tags+=.git/tags

"}}}1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: FUNCTIONS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleCursorColumn() " {{{2
  if (&l:cursorcolumn == 1)
    setlocal nocursorcolumn
  else
    setlocal cursorcolumn
  endif
endfunction " }}}

function! ToggleColorColumn() " {{{2
  if (&l:colorcolumn != "")
    let &l:colorcolumn=""
  else
    let &l:colorcolumn=g:max_line_width
  endif
endfunction " }}}

function! NumberToggle() " {{{2
  if (&relativenumber == 1)
    set number norelativenumber
  else
    set number relativenumber
  endif
endfunction " }}}

function! ToggleRemoveTrailingWhitespace() " {{{2
  if b:Remove_trailing_whitespace
    augroup whitespace
      au!
    augroup END
    let b:Remove_trailing_whitespace=0
    echom "Remove trailing whitespace is off"
  else
    augroup whitespace
      autocmd BufWritePre <buffer> :%s/\s\+$//e
    augroup END
    let b:Remove_trailing_whitespace=1
    echom "Remove trailing whitespace is on"
  endif
endfunction " }}}

function! EnableRemoveTrailingWhitespace() " {{{2
  let b:Remove_trailing_whitespace=1
  autocmd whitespace BufWritePre <buffer> :%s/\s\+$//e
endfunction " }}}

function! CurrentFilePath() " {{{2
  let l:file_path = resolve(expand("%:p"))
  echo l:file_path
  return l:file_path
endfunction " }}}

function! TabEditCurrentFile() " {{{2
  execute "tabedit " . CurrentFilePath()
endfunction " }}}

function! IndentFile() " {{{2
  let l:current_line = line('.')
  let l:current_position = col('.')
  normal! gg=G
  call cursor(l:current_line, l:current_position)
endfunction " }}}

function! CurrentDatabase() " {{{2
  if (!exists("g:current_database"))
    let g:current_database = input("Enter database name: ", "", "file")
    echom "\nDatabase set to " . g:current_database
    echom "\nYou can override this setting per buffer with variable 'b:current_database'"
  endif
  if (exists("b:current_database"))
    return b:current_database
  else
    return g:current_database
  endif
endfunction " }}}

" © [2]
function! EvaluateRubyFile() " {{{2
  if (expand('%') =~# '_test\.rb$')
    compiler rubyunit
    setlocal makeprg=testrb\ "%:p"
  elseif (expand('%') =~# '_spec\.rb$')
    compiler rspec
    setlocal makeprg=rspec\ "%:p"
  else
    compiler ruby
    setlocal makeprg=ruby\ -wc\ \"%:p\"
  endif
endfunction " }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunTestFile(...) " {{{2
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
endfunction " }}}

function! RunNearestTest() " {{{2
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number)
endfunction " }}}

function! SetTestFile() " {{{2
  " Set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction " }}}

function! RunTests(filename) " {{{2
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
endfunction " }}}

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: COMMANDS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! ToggleRemoveTrailingWhitespace :call ToggleRemoveTrailingWhitespace()
command! ToggleColorColumn :call ToggleColorColumn()
command! ToggleCursorColumn :call ToggleCursorColumn()
command! NumberToggle :call NumberToggle()
command! CurrentFilePath :call CurrentFilePath()
command! GenerateBundleRi :silent !generate_bundle_ri

" Reload vimrc
command! RL :so $HOME/.vimrc

" Diff tab management: open the current git diff in a tab ©[1]
command! GdiffInTab execute "tabedit " . CurrentFilePath() . "|vsplit|Gdiff"
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: MAPPINGS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL MODE {{{2
" Set '/' and '?' in visual mode to search for the current selection
" The \V tells the regex engine that only '\' has a special meaning
vnoremap / y/\V<C-R>"<CR>
vnoremap ? y?\V<C-R>"<CR>
" }}}

" NORMAL MODE {{{2
" LEADER MAPPINGS {{{3
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>u :GundoToggle<CR>
nnoremap <silent> <Leader>. :ToggleColorColumn<CR>
nnoremap <silent> <Leader>| :ToggleCursorColumn<CR>
nnoremap <leader><Space> :ToggleRemoveTrailingWhitespace<cr>
nnoremap <Leader>= :call IndentFile()<CR>
nnoremap <Leader>0 :silent call NumberToggle()<CR>
nnoremap <Leader>f :Ack!<space>
nnoremap <Leader>F :Ack<space>
nnoremap <Leader>a :Ack!<CR>
nnoremap <Leader>A :Ack<CR>
nnoremap <Leader>r :Ack!<space>'"'<CR>
nnoremap <Leader>R :Ack<space>'"'<CR>

" Produce blank lines easily
nnoremap <Leader>o o<ESC>0d$
nnoremap <Leader>O O<ESC>0d$

" Catch all paste commands and wrap in pastemode
" inoremap <D-V> <C-O>:set paste<CR><D-V><C-O>:set nopaste<CR>
" imap <D-V> :echo "PASTE"
" inoremap <C-V> <C-O>:set paste<CR><C-V><C-O>:set nopaste<CR>

" ©[1]
nnoremap <leader>d :GdiffInTab<cr>
nnoremap <leader>D :tabclose<cr>
" Rspec.vim mappings
map <Leader>t :call RunNearestSpec()<CR>
map <Leader>T :call RunCurrentSpecFile()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>S :call RunAllSpecs()<CR>

" ©[1]
nnoremap <leader>c :w\|:!script/features<cr>
nnoremap <leader>w :w\|:!script/features --profile wip<cr>
" }}}

nnoremap <F9> :Dispatch<CR>
" Same behaviour in normal mode as a pager
nnoremap <Space> <C-D>
" }}}

" INSERT MODE {{{2
" A faster way to exit insert mode
inoremap jk <esc>
" }}}

" ALL MODES {{{2
" © [2]
map <F3>    :cnext<CR>
map <F4>    :cc<CR>
map <F5>    :cprev<CR>
map <F6>    :cclose<CR>
map <F8>    :wall<Bar>make<CR>
map <C-F4>  :bdelete<CR>
" }}}

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: COLORS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme desert
" set background=dark
" solarized options
" let g:solarized_termcolors = 256
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
" colorscheme solarized

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: AUTOCOMMANDS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup whitespace " {{{2
  autocmd!
  " remove trailing whitespace
  " autocmd BufWritePre * :%s/\s\+$//e
augroup END " }}}

augroup BufEnterCommands " {{{2
  autocmd!
  autocmd BufEnter * :call EnableRemoveTrailingWhitespace()
  autocmd BufEnter * :setlocal colorcolumn=""
augroup END " }}}

augroup FiletypeOptions " {{{2
  autocmd!
  " © [2]
  autocmd FileType sh,zsh,csh,tcsh inoremap <silent> <buffer> <C-X>! #!/bin/<C-R>=&ft<CR>
  autocmd FileType perl,python,ruby inoremap <silent> <buffer> <C-X>! #!/usr/bin/env<Space><C-R>=&ft<CR>
  autocmd FileType ruby setlocal shiftwidth=2 softtabstop=2 expandtab autoindent
  autocmd FileType ruby let b:dispatch = "bundle exec rspec %"
  autocmd FileType Ruby setlocal shiftwidth=2 softtabstop=2 expandtab autoindent
  autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab autoindent
  autocmd FileType coffee setlocal shiftwidth=2 softtabstop=2 expandtab autoindent
  autocmd FileType haml setlocal shiftwidth=2 softtabstop=2 expandtab autoindent
  autocmd Filetype gitcommit setlocal spell textwidth=72 foldmethod=syntax foldlevel=1
  autocmd FileType java setlocal shiftwidth=4 softtabstop=4 expandtab autoindent
  autocmd FileType java silent! compiler javac | setlocal makeprg=javac\ %
  autocmd FileType xml setlocal shiftwidth=2 softtabstop=2 expandtab autoindent
  autocmd FileType xml setlocal foldmethod=syntax
  autocmd FileType xml setlocal foldlevel=2
  autocmd FileType ruby call EvaluateRubyFile()
  " Use this with 'K' and you feel the force! © [2]
  autocmd FileType vim setlocal keywordprg=:help nojoinspaces
  autocmd FileType help setlocal keywordprg=:help nojoinspaces
  autocmd FileType csv %ArrangeColumn
  autocmd FileType sqlite execute "setlocal makeprg=sqlite3\ " . g:current_database
  autocmd User Bundler if &makeprg !~ 'bundle' | setlocal makeprg^=bundle\ exec\  | endif
augroup END " }}}

augroup LineNumber " {{{2
  autocmd!
  autocmd InsertEnter * :set number norelativenumber
  autocmd InsertLeave * :set number relativenumber
  autocmd FocusLost   * :set number norelativenumber
  autocmd FocusGained * :set number relativenumber
augroup END " }}}

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: FOOTNOTES {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [1] Copyright by Gary Bernhardt
"     https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
" [2] Copyright by Tim Pope
"     https://github.com/tpope/tpope/blob/master/.vimrc
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:tw=78:ts=8:ft=vim:
