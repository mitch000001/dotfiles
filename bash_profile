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

PS1='\u@\h:\W '
PS1=$PS1"\$(__git_ps1 '(%s)')$"

### Path definitions ###
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH=/usr/local/sbin:/usr/local/heroku/bin:/usr/local/share/npm/bin:/usr/local/bin:/Users/mitch/.rbenv/shims:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/MacGPG2/bin

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
alias l.v='ls -l -d .[^.]*'

alias ..='cd ..'
alias ...='cd ../..'
alias irb='irb -I `pwd` -r irb/completion'
alias b='bundle exec'

alias source_profile='source ~/.bash_profile'
alias rl='source_profile'

# git aliases
alias gs='git st'
alias g='git'
alias ga='g add'
alias gaa='g add -A'
alias grm='g rm'
alias gbr='g br'
alias gst='g st -sb'
alias gss='g ss'
alias gsh='g show'
alias gta='g tag'
alias glg='g lg'
alias glg5='g lg -5'
alias glg15='g lg -15'
alias gco='g co'
alias gcom='g co master'
alias gcob='gco -b'
alias gci='g ci'
alias gcim='g ci -m'
alias gca='g ca'
alias gcl='g cl'
alias gcp='g cp'
alias gdf='g df'
alias gdfs='g dfs'
alias gpr='g pull --rebase'
alias gpu='g push'
alias gpp='gpr && gpu'
alias gus='g rs HEAD'
alias gtodo='git grep -e "# TODO:" -e "# XXX:"'
alias gnuke='git reset --hard && git clean -f'

# Completion for the git aliases:
__git_complete gco _git_checkout
__git_complete g __git_main

