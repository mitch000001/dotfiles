##############################################################################
# Environment command checks {{{1
##############################################################################
# Homebrew {{{2
function has_homebrew() {
  return `[[ $(command -v brew >/dev/null 2>&1; echo $?) -eq 0 ]]`
}
# }}}
# Go {{{2
function has_go() {
  return `[[ $(command -v go >/dev/null 2>&1; echo $?) -eq 0 ]]`
}
function has_gocd() {
  return 1 #`[[ $(command -v gocd >/dev/null 2>&1) -eq 0 ]]`
}
# }}}
# git {{{2
function has_git() {
  return `[[ $(command -v git >/dev/null 2>&1; echo $?) -eq 0 ]]`
}
# }}}
# flow {{{2
function has_rbenv() {
  return `[[ $(command -v flow >/dev/null 2>&1; echo $?) -eq 0 ]]`
}
#}}}
# rbenv {{{2
function has_rbenv() {
  return `[[ $(command -v rbenv >/dev/null 2>&1; echo $?) -eq 0 ]]`
}
# direnv {{{2
function has_direnv() {
  return `[[ $(command -v direnv >/dev/null 2>&1; echo $?) -eq 0 ]]`
}

# nvm {{{2
function has_nvm() {
  return `[[ $(command -v nvm >/dev/null 2>&1; echo $?) -eq 0 ]]`
}
# }}}
# nvim {{{2
function has_nvim() {
  return `[[ $(command -v nvim >/dev/null 2>&1; echo $?) -eq 0 ]]`
}
# }}}
# kubectl {{{2
function has_kubectl() {
  return `[[ $(command -v kubectl >/dev/null 2>&1; echo $?) -eq 0 ]]`
}
# }}}

# }}}
##############################################################################
# Initialize scripts in bash.d {{{1
##############################################################################
for script in $HOME/.bash.d/*.sh; do
  if [[ -r $script ]]; then
    source $script
  fi
done

# }}}
##############################################################################
# Environment variables {{{1
##############################################################################
LOCAL_PROFILE=$HOME/.bash_profile.local
LOCAL_RC=$HOME/.bashrc.local

export EDITOR=vim
if has_nvim; then
  export EDITOR=nvim
fi

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Homebrew {{{2
if has_homebrew; then
  export HOMEBREW=$(brew --cellar)
fi
# }}}
export ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT-/usr/local/opt/android-sdk}"
export ANDROID_HOME=$ANDROID_SDK_ROOT
# Go specific variables {{{2
if has_go; then
  export GOPATH=$HOME
  export GOROOT=$(go env GOROOT)
  export GOBIN=$HOME/bin
fi
# }}}

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export VM_PATH=$HOME/Documents/Virtual_Machines.localized

# History config {{{2
export HISTIGNORE="&"
export HISTSIZE=2000
# }}}

# Customized shell prompt {{{2
PS1="\[$RED\]\D{%H:%M} \[$EGREEN\]\u@\h:\[$EBLUE\]\W\[$NO_COLOR\] "
PS1=$PS1"\$(__git_ps1 '(%s)') \[$RED\]$"
PS1=$PS1"\[$NO_COLOR\] "
# }}}
# }}}
##############################################################################
### Path definitions ### {{{1
# TODO: add brew to path or find out where it lives
# Homebrew Path additions {{{2
if has_homebrew; then
  export PATH=/usr/local/bin:$PATH
  export PATH=/usr/local/sbin:$PATH
  if brew ls nodejs >/dev/null 2>&1; then
    export PATH=/usr/local/share/npm/bin:$PATH
  fi
fi
export PATH=./node_modules/.bin:$PATH
# }}}
export PATH=$HOME/bin:$PATH
# Android tools {{{2
export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$PATH
# }}}
# Go specific PATH additions {{{2
if has_go; then
  export PATH=$PATH:$GOPATH/bin
fi
# }}}
# Google Cloud SDK PATH additions {{{2
# The next line updates PATH for the Google Cloud SDK.
if test -d $HOME/workspace/google-cloud-sdk; then
  source $HOME/workspace/google-cloud-sdk/path.bash.inc
fi
# }}}
# }}}
##############################################################################
### Added by the Heroku Toolbelt {{{1
##############################################################################
export PATH=/usr/local/heroku/bin:$PATH

#source ~/.adb.bash

# }}}
##############################################################################
# Functions {{{1
##############################################################################
# See http://unix.stackexchange.com/questions/4219/how-do-i-get-bash-completion-for-command-aliases for more details
function make-completion-wrapper () {
  local function_name="$2"
  local arg_count=$(($#-3))
  local comp_function_name="$1"
  shift 2
  local function="
  function $function_name {
      ((COMP_CWORD+=$arg_count))
      COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
      "$comp_function_name"
      return 0
  }"
  eval "$function"
}
# }}}
##############################################################################
# Bash completion {{{1
##############################################################################
if has_homebrew && [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
if has_homebrew && [[ $(command -v aws >/dev/null 2>&1) -eq 0 ]]; then
  complete -C aws_completer aws
fi
if has_gocd; then
  source $(gocd -shellinit)
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Google Cloud SDK bash completion {{{2
# The next line enables bash completion for gcloud.
if test -d $HOME/workspace/google-cloud-sdk; then
  source $HOME/workspace/google-cloud-sdk/completion.bash.inc
fi
# }}}
# }}}
##############################################################################
# direnv initialization {{{1
##############################################################################
if has_direnv; then
  eval "$(direnv hook bash)"
fi

# }}}
##############################################################################
##############################################################################
# rbenv initialization {{{1
##############################################################################
if has_rbenv; then
  eval "$(rbenv init -)"
fi

# }}}
##############################################################################
### Aliases {{{1
##############################################################################

# ls aliases {{{2
alias l='ls -la'
alias lh='l -h'
# List only dotfiles
alias l.='ls -la -d .[^.]*'
alias ls.='ls -d .[^.]*'
alias l.v='ls -l -d .[^.]*'
# }}}

# Workflow aliases {{{2
alias ..='cd ..'
alias ...='cd ../..'
#}}}

# Homebrew alias {{{2
if has_homebrew; then
  alias brewup='brew update && brew upgrade && brew cleanup'
fi
#}}}

# Ruby aliases {{{2
alias irb='irb -I `pwd` -r irb/completion'
alias b='bundle exec'
#make-completion-wrapper __bundle _bundle_exec bundle exec
#complete -F _bundle_exec b
alias bundle='bundle '
alias install='install --path=.bundle'
# }}}

# Reloading profile aliases {{{2
alias source_profile='source ~/.bash_profile'
alias rl='source_profile'
# }}}

# git aliases {{{2
if has_git; then
  alias g='git'
  __git_complete g __git_main
  alias gst='git status'
  alias gss='git status -sb'
  alias gf='git fetch'
  __git_complete gf _git_fetch
  alias ga='git add'
  __git_complete ga _git_add
  alias gap='git add -p'
  alias gaa='git add -A'
  __git_complete gaa _git_add
  alias grm='git rm'
  __git_complete grm _git_rm
  alias gbr='git branch'
  __git_complete gbr _git_branch
  alias gsh='git show'
  __git_complete gsh _git_show
  alias gta='git tag'
  __git_complete gta _git_tag
  alias glg='git lg'
  __git_complete glg _git_log
  alias glgm='git lg origin/master..HEAD'
  __git_complete glgm _git_log
  alias glga='git lga'
  __git_complete glga _git_log
  alias glg5='git lg -5'
  __git_complete glg5 _git_log
  alias glg15='git lg -15'
  __git_complete glg15 _git_log
  alias glga5='git lga -5'
  __git_complete glga5 _git_log
  alias glga15='git lga -15'
  __git_complete glga15 _git_log
  alias gco='git checkout'
  __git_complete gco _git_checkout
  alias g--='git checkout --'
  __git_complete gco _git_checkout
  alias gcom='git checkout master'
  alias gcob='git checkout -b'
  __git_complete gcob _git_checkout
  alias gci='git commit -v'
  __git_complete gci _git_commit
  alias gcim='git commit -m'
  __git_complete gcim _git_commit
  alias gd='git diff'
  __git_complete gd _git_diff
  alias gdf='git df'
  __git_complete gdf _git_diff
  alias gdfs='git diff --staged'
  __git_complete gdfs _git_diff
  alias gsave='git stash'
  __git_complete gsave _git_stash
  alias gspop='git stash pop'
  __git_complete gspop _git_stash
  alias gsl='git stash list'
  __git_complete gsl _git_stash
  alias gpr='git pull --rebase'
  __git_complete gpr _git_pull
  alias gpu='git push'
  __git_complete gpu _git_push
  alias gpp='gpr && gpu'
  __git_complete gpp _git_push
  alias grs='git reset HEAD'
  __git_complete grs _git_reset
  alias gtodo='git grep -n -e "# TODO" -e "#TODO" -e "// TODO" -e "//TODO" -e "# XXX:"'
  alias gnuke='git reset --hard && git clean -f'

  # Just Copy&Paste, no idea what these do...
  # TODO: Solve or remove
  alias gss='git ss'
  alias gca='git ca'
  alias gcl='git cl'
  alias gcp='git cp'
fi
# }}}

# alias for google cloud sdk {{{2
if test -d $HOME/workspace/google-cloud-sdk; then
  alias goapp=$HOME/workspace/google-cloud-sdk/platform/google_appengine/goapp
fi
# }}}
# }}}
##############################################################################
# ## Machine specific changes {{{1
if [ -f $LOCAL_PROFILE ]; then
  source $LOCAL_PROFILE
fi
if [ -f $LOCAL_RC ]; then
  source $LOCAL_RC
fi
# }}}
# vim: ft=sh
