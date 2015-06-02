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
runtime ftplugin/man.vim

" }}}
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: BASIC CONFIGURATION SETUP {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
filetype plugin indent off
filetype plugin indent on
syntax on
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: VARIABLES {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GLOBAL CONFIGURATION {{{2
let g:max_line_width = 80
" }}}
" DIRECTORY VARIABLES {{{2
let s:vim_backup_dir=expand('$HOME/.vim_backup')
let s:vim_swap_dir=expand('$HOME/.vim_swap')
let s:vim_spelldict_file=expand('$HOME/.vim_spelldict.add')
let s:nerdtreebookmarks=expand('$HOME/.vim_bookmarks')
" }}}
" PLUGIN CONFIGURATION {{{2
let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
let g:liquid_highlight_types = g:markdown_fenced_languages + ['jinja=liquid', 'html+erb=eruby.html', 'html+jinja=liquid.html']
" GO CONFIGURATION {{{3
let g:go_fmt_command = "goimports"
let g:gofmt_command = "goimports"
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_build_constraints = 1
" }}}
" COFFEESCRIPT CONFIGURATION {{3
" let g:coffee_lint_options = '-f lint.json'
" }}}
" RSPEC CONFIGURATION {{{3
let g:rspec_command = "Dispatch bundle exec rspec {spec}"

" }}}
" NERDTREE CONFIGURATION {{{3
" Change current working dir when loaded and when root dir changes
let NERDTreeChDirMode=2
let NERDTreeBookmarksFile=s:nerdtreebookmarks
" }}}
" CTRL-P CONFIGURATION {{{3
" How to set CtrlP's local working directory.
" Search for VCS-files to set CWD ('r')
"   use CWD outside of CTRL-P as fallback ('w')
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_show_hidden = 1             " Show hidden files when using CTRL-P
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn|idea|bundle)|vendor/bundle|public/javascripts/compiled|target|tmp|node_modules|log|venv$',
      \ 'file': '\v\.(exe|so|dll|pyc|class)$',
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
" JSON CONFIGURATION {{{3
" Hide quotation marks from json keys and values
let g:vim_json_syntax_conceal = 0
" }}}
" ACK CONFIGURATION {{{3
let g:ack_default_options = " -s -H --nocolor --nogroup --column"
" }}}
" XML CONFIGURATION {{{2
let xml_use_xhtml = 1
" }}}
" SQL DATABASE QUERY CONFIGURATION {{{2
let g:SQL_database = ""
let g:SQL_program_arguments = ""
let g:SQL_result_file = "results.csv"
" }}}
" FILETYPE VARIABLES {{{2
let g:xml_syntax_folding = 1
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: OPTIONS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
scriptencoding utf-8
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
" BUFFER HANDLING {{{2
set autoread          " automatic update of files changed by other processes
set autowrite         " Automatically save before commands like :next and :make
" hide buffers in background when switching
" the active buffer to another file
set hidden
" Open files e.g. from quicksearch within last selected window buffer
set switchbuf=useopen
" }}}
" INTERACTION HELPERS {{{2
set clipboard=unnamed " enable clipboard cut&paste
set pastetoggle=<F2>  " Toggle paste mode
set mouse=a             " Enable mouse support
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" }}}
" STATUS LINE CONFIGURATION {{{2
set showcmd           " Show (partial) command in status line.
set showmode          " Display the mode you're in.
set ruler             " Print the current line and the current column
set laststatus=2        " Always show last status
" }}}
" SERACH CONFIG {{{2
set hlsearch
set incsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" }}}
" VISUAL EFFECTS {{{2
set showmatch         " Show matching brackets.
set number            " show line numbers
set cursorline          " highlight current cursorline
set virtualedit=block
" The offset when scrolling, i.e. the lines to show from cursor to bottom
set scrolloff=3
set sidescrolloff=5
" }}}
" DEFAULT INDENTATION RULES {{{2
set smartindent
set smarttab        " sw at the start of the line, sts everywhere else
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab           " expand all tabs to spaces
" }}}
" APPEARANCE OF SPECIAL CHARACTERS {{{2
set list                " show whitespace characters
" Custom displaying of special characters
" define custom characters for line endings etc
set listchars=tab:ˉ\ ,trail:·,nbsp:·,eol:¬
" define characters to indicate long lines when 'wrap' is off
set listchars+=extends:»,precedes:«
" }}}
" HISTORY {{{2
" remember more commands and search history
set history=10000
" © [2]
" persist state between vim session
set viminfo=!,'20,<50,s10,h
"}}}
" TERMINAL OPTIONS {{{2
set title
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
" set t_ti= t_te=
" }}}
" COMPLETION {{{2
" Bash-like filename completion in command line
set wildmenu
set wildmode=longest,list
" }}}
" FOLDING {{{2
set foldmethod=marker " Enable folding with custom markers
" }}}
" SPELLING {{{2
" let &spellfile=s:vim_spelldict_file
" }}}2
set encoding=utf-8    " for unicode glyphs

set tags+=.git/tags   " Add tags file from git hooks

set exrc              " load local exrc files

"}}}1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: FUNCTIONS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! ToggleListChars() " {{{2
  if (&l:list == 1)
    setlocal nolist
  else
    setlocal list
  endif
endfunction " }}}

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
    augroup Whitespace
      au!
    augroup END
    let b:Remove_trailing_whitespace=0
    echom "Remove trailing whitespace is off"
  else
    augroup Whitespace
      autocmd BufWritePre <buffer> :%s/\s\+$//e
    augroup END
    let b:Remove_trailing_whitespace=1
    echom "Remove trailing whitespace is on"
  endif
endfunction " }}}

function! EnableRemoveTrailingWhitespace() " {{{2
  let b:Remove_trailing_whitespace=1
  autocmd Whitespace BufWritePre <buffer> :%s/\s\+$//e
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

function! SetSQLMakePrg() " {{{2
  let make_prg_prefix = input("Enter SQL makefile: ")
  let make_prg = escape(make_prg_prefix . "< % > " . g:SQL_result_file, ' -<>\')
  setlocal makeprg=makeprg
  echom "MakeProgram set to " . &makeprg
endfunction " }}}

function! SetCurrentDatabase() " {{{2
  if (!exists("g:SQL_database") || g:SQL_database == "")
    let g:SQL_database = input("Enter database name: ", "", "file")
    echom "\nDatabase set to " . g:SQL_database
  endif
  return g:SQL_database
endfunction " }}}

function! GetMakePrgVariable(filetype) " {{{2
  if (a:filetype == "mysql")
    let make_prg_prefix = "mysql"
  elseif (a:filetype == "sqlite")
    let make_prg_prefix = "sqlite3"
  else
    let make_prg_prefix = "make"
  endif
  let make_prg = make_prg_prefix . " " . g:SQL_program_arguments . " " . g:SQL_database . "< % > " . g:SQL_result_file
  let make_prg = escape(make_prg, ' -<>\')
  return make_prg
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

function! EvaluateGoFile() " {{{2
  if (expand('%') =~# '_test\.go$')
    setlocal makeprg=go\ test\ "%:p"
  else
    setlocal makeprg=go\ run\ \"%:p\"
  endif
endfunction " }}}

function! ToggleGoTestFile() " {{{2
  if (&filetype == 'go')
    if (expand('%') =~# '_test\.go$')
      let s:filename = expand("%:t:r")
      let s:splits = split(s:filename, '_')[0:-2]
      execute "edit " . expand("%:h") . "/" . join(s:splits, '_') . ".go"
    else
      let s:filename = expand("%:p:r") . "_test.go"
      execute "edit " . s:filename
    endif
  else
    echom 'No Go file!'
  endif
endfunction " }}}

function! GoDefgd() "{{{2
  let s:cword = expand("<cword>")
  echom s:cword
  !echo s:cword
  let @/ = s:cword
  GoDef
endfunction
"}}}

" Helper for aligning table-like array as I use in Sequel-based tests. {{{2
function! AlignTable()
  '<,'>Tabularize /,
  '<,'>Tabularize /[
  '<,'>Tabularize /]
endfunction "}}}
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
  let test_line_number = line('.')
  call RunTestFile(":" . test_line_number)
endfunction " }}}

function! SetTestFile() " {{{2
  " Set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction " }}}

function! RunTests(filename) " {{{2
  " TODO: change execution of specific filetype to make program
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles() " {{{2
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()
" }}}
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

command! SetSQLMakeProgram :call SetSQLMakePrg()

command! ToggleGoTestFile :call ToggleGoTestFile()

" Reload vimrc
command! RL :silent so $HOME/.vimrc

" Diff tab management: open the current git diff in a tab ©[1]
command! GdiffInTab execute "tabedit " . CurrentFilePath() . "|vsplit|Gdiff"
" Open RFC files ©[2]
command! -bar -count=0 RFC :silent tabe http://www.ietf.org/rfc/rfc<count>.txt|setl ro noma
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: MAPPINGS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VISUAL MODE {{{2
" Set '/' and '?' in visual mode to search for the current selection
" The \V tells the regex engine that only '\' has a special meaning
vnoremap / y/\V<C-R>"<CR>
vnoremap ? y?\V<C-R>"<CR>
vnoremap <leader>a :call AlignTable()<cr>
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
nnoremap <Leader>o o<ESC>0d$k
nnoremap <Leader>O O<ESC>0d$j

" Catch all paste commands and wrap in pastemode
" inoremap <D-V> <C-O>:set paste<CR><D-V><C-O>:set nopaste<CR>
" imap <D-V> :echo "PASTE"
" inoremap <C-V> <C-O>:set paste<CR><C-V><C-O>:set nopaste<CR>

" ©[1]
nnoremap <leader>d :GdiffInTab<cr>
nnoremap <leader>D :tabclose<cr>
" Rspec.vim mappings
map <Leader>t :call RunNearestTest()<CR>
map <Leader>T :call RunTestFile()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>S :call RunTests('')<CR>

" ©[1]
nnoremap <leader>c :w\|:!script/features<cr>
nnoremap <leader>w :w\|:!script/features --profile wip<cr>
" }}}

nnoremap <F9> :Dispatch<CR>
" Same behaviour in normal mode as a pager
nnoremap <Space> <C-D>
" © [2]
if exists(":nohls")
  nnoremap <silent> <C-L> :nohls<CR><C-L>
endif
nnoremap <Leader>- :call ToggleListChars()<CR>
nnoremap <leader># Vi(:call AlignTable()<cr>
" }}}

" INSERT MODE {{{2
" A faster way to exit insert mode
inoremap jk <esc>
inoremap kj <esc>
" }}}

" ALL MODES {{{2
" © [2]
map <F3>    :cnext<CR>
map <F4>    :copen<CR>
map <F5>    :cprev<CR>
map <F6>    :cclose<CR>
map <F7>    :NERDTreeFind<CR>
map <F8>    :wall<Bar>make<CR>
map <silent> <F10> :let tagsfile = tempname()\|silent exe "!ctags -f ".tagsfile." \"%\""\|let &l:tags .= "," . tagsfile\|unlet tagsfile<CR>
map <C-F4>  :bdelete<CR>
" }}}

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: COLORS {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme desert
hi DiffText ctermbg=4
hi DiffChange ctermbg=11
hi DiffDelete ctermbg=9 ctermfg=8
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

augroup Misc "{{{2
  autocmd User Fugitive
        \ if filereadable(fugitive#buffer().repo().dir('fugitive.vim')) |
        \   source `=fugitive#buffer().repo().dir('fugitive.vim')` |
        \ endif
augroup END "}}}

augroup Whitespace " {{{2
  autocmd!
  " remove trailing whitespace
  " autocmd BufWritePre * :%s/\s\+$//e
augroup END " }}}

augroup BufEnterCommands " {{{2
  autocmd!
  autocmd BufEnter * :call EnableRemoveTrailingWhitespace()
  autocmd BufEnter * :setlocal colorcolumn=""
augroup END " }}}

augroup FileTypeCheck "{{{2
  autocmd!
  autocmd BufNewFile,BufRead *.txt,README,INSTALL,NEWS,TODO if &ft == ""|set ft=text|endif
augroup END "}}}

augroup FileTypeOptions " {{{2
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
  autocmd Filetype gitconfig setlocal textwidth=72 noexpandtab
  autocmd FileType java setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab autoindent
  autocmd FileType java silent! compiler javac | setlocal makeprg=javac\ %
  autocmd FileType xml setlocal shiftwidth=2 softtabstop=2 expandtab autoindent
  autocmd FileType xml setlocal foldmethod=syntax
  autocmd FileType xml setlocal foldlevel=2
  autocmd FileType ruby call EvaluateRubyFile()
  " Use this with 'K' and you feel the force! © [2]
  autocmd FileType vim setlocal keywordprg=:help nojoinspaces
  autocmd FileType help setlocal keywordprg=:help nojoinspaces
  autocmd FileType man setlocal nojoinspaces nolist
  autocmd FileType csv ArrangeColumn
  autocmd FileType mysql execute "setlocal makeprg=" . GetMakePrgVariable('mysql')
  autocmd FileType sqlite execute "setlocal makeprg=" . GetMakePrgVariable('sqlite')
  autocmd FileType go autocmd BufWritePre <buffer> GoFmt
  autocmd FileType go compiler go
  autocmd FileType go setlocal makeprg=go\ test\ ./...
  autocmd FileType go setlocal noexpandtab softtabstop=4 tabstop=4 shiftwidth=4 autoindent nolist
  autocmd FileType go nnoremap gd GoDef
  autocmd FileType go nnoremap gD GoDef
  autocmd FileType go command! A ToggleGoTestFile
  autocmd FileType godoc setlocal noexpandtab softtabstop=4 tabstop=4 shiftwidth=4 autoindent nolist
  " © [2]
  autocmd User Bundler if (&makeprg !~ 'bundle' && &ft == 'ruby') | setlocal makeprg^=bundle\ exec\  | endif
  autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
  autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif
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
" SECTION: FINAL INITIALIZATIONS {{{1
syntax on
filetype plugin indent on
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
