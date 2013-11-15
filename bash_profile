# Initialize scripts in bash.d
for script in $HOME/.bash.d/*.sh; do
  if [[ -r $script ]]; then
    source $script
  fi
done

# Environment variables
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export HOMEBREW=/usr/local/Cellar
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT

export HISTIGNORE="&"

PS1="\[$EGREEN\]\u@\h:\[$EBLUE\]\W\[$NO_COLOR\] "
PS1=$PS1"\$(__git_ps1 '(%s)') \[$RED\]$"
PS1=$PS1"\[$NO_COLOR\] "

### Path definitions ###
# Homebrew Path additions
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=~/bin:$PATH

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH=/usr/local/heroku/bin:$PATH

#source ~/.adb.bash

# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# rbenv initialization
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

### Aliases ###

alias l='ls -la'
alias lh='l -h'
# List only dotfiles
alias l.='l -d .[^.]*'
alias ls.='ls -d .[^.]*'
alias l.v='ls -l -d .[^.]*'

alias ..='cd ..'
alias ...='cd ../..'
alias irb='irb -I `pwd` -r irb/completion'
alias b='bundle exec'

alias source_profile='source ~/.bash_profile'
alias rl='source_profile'

# git aliases
alias g='git'
__git_complete g __git_main
alias gs='git status'
alias gst='git status -sb'
alias gf='git fetch'
__git_complete gf __git_fetch
alias ga='git add'
__git_complete ga _git_add
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
alias glga='git lga'
__git_complete glga _git_log
alias glg5='git lg -5'
__git_complete glg5 _git_log
alias glg15='git lg -15'
__git_complete glg15 _git_log
alias gco='git checkout'
__git_complete gco _git_checkout
alias gcom='git checkout master'
alias gcob='git checkout -b'
__git_complete gcob _git_checkout
alias gci='git commit'
__git_complete gci _git_commit
alias gcim='git commit -m'
__git_complete gcim _git_commit
alias gd='git diff'
__git_complete gd _git_diff
alias gdf='git df'
__git_complete gdf _git_diff
alias gdfs='git dfs'
__git_complete gdfs _git_diff
alias gpr='git pull --rebase'
__git_complete gpr _git_pull
alias gpu='git push'
__git_complete gpu _git_push
alias gpp='gpr && gpu'
__git_complete gpp _git_push
alias grs='git reset HEAD'
__git_complete grs _git_reset
alias gtodo='git grep -e "# TODO:" -e "# XXX:"'
alias gnuke='git reset --hard && git clean -f'

alias gss='git ss'
alias gca='git ca'
alias gcl='git cl'
alias gcp='git cp'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
