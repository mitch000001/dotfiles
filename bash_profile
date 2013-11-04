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
alias gs='git st'
alias gf='git fetch'
alias ga='git add'
alias gaa='git add -A'
alias grm='git rm'
alias gbr='git br'
alias gst='git st -sb'
alias gss='git ss'
alias gsh='git show'
alias gta='git tag'
alias glg='git lg'
alias glg5='git lg -5'
alias glg15='git lg -15'
alias gco='git co'
alias gcom='git co master'
alias gcob='git co -b'
alias gci='git ci'
alias gcim='git ci -m'
alias gca='git ca'
alias gcl='git cl'
alias gcp='git cp'
alias gdf='git df'
alias gdfs='git dfs'
alias gpr='git pull --rebase'
alias gpu='git push'
alias gpp='gpr && gpu'
alias gus='git rs HEAD'
alias gtodo='git grep -e "# TODO:" -e "# XXX:"'
alias gnuke='git reset --hard && git clean -f'

# Completion for the git aliases:
__git_complete gco _git_checkout
__git_complete gcob _git_checkout
__git_complete g __git_main
__git_complete gpu _git_push
__git_complete gpp _git_push
__git_complete gpr _git_pull
__git_complete glg _git_log
__git_complete glg5 _git_log
__git_complete glg15 _git_log
__git_complete gci _git_commit
__git_complete gcim _git_commit

