export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

PS1='\u@\h:\W '
PS1=$PS1"\$(__git_ps1 '(%s)')$"

#source ~/.adb.bash

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
export HOMEBREW=/usr/local/Cellar
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT

export HISTIGNORE="&"

alias ..='cd ..'
alias l='ls -la'
alias lh='l -h'
alias ...='cd ../..'
alias irb='irb -I `pwd` -r irb/completion'
alias b='bundle exec'
alias gs='git st'

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
