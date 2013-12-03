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
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export HOMEBREW=/usr/local/Cellar
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT

export HISTIGNORE="&"

PS1="\[$EGREEN\]\u@\h:\[$EBLUE\]\W\[$NO_COLOR\] "
PS1=$PS1"\$(__git_ps1 '(%s)') \[$RED\]$"
PS1=$PS1"\[$NO_COLOR\] "

# }}}
##############################################################################
### Path definitions ### {{{1
# Homebrew Path additions
export PATH=/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=~/bin:$PATH

# }}}
##############################################################################
### Added by the Heroku Toolbelt {{{1
##############################################################################
export PATH="/usr/local/heroku/bin:$PATH"
export PATH=/usr/local/heroku/bin:$PATH

#source ~/.adb.bash

# }}}
##############################################################################
# Bash completion {{{1
##############################################################################
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# }}}
##############################################################################
# rbenv initialization {{{1
##############################################################################
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# }}}
##############################################################################
### Aliases {{{1
##############################################################################

# ls aliases {{{2
alias l='ls -la'
alias lh='l -h'
# List only dotfiles
alias l.='l -d .[^.]*'
alias ls.='ls -d .[^.]*'
alias l.v='ls -l -d .[^.]*'
# }}}

# Workflow aliases {{{2
alias ..='cd ..'
alias ...='cd ../..'
#}}}

# Ruby aliases {{{2
alias irb='irb -I `pwd` -r irb/completion'
alias b='bundle exec'
alias bundle='bundle '
alias install='install --path=vendor/bundle'
# }}}

# Reloading profile aliases {{{2
alias source_profile='source ~/.bash_profile'
alias rl='source_profile'
# }}}

# git aliases {{{2
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
alias gci='git commit -v'
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

# Just Copy&Paste, no idea what these do...
# TODO: Solve or remove
alias gss='git ss'
alias gca='git ca'
alias gcl='git cl'
alias gcp='git cp'
# }}}

# }}}
##############################################################################
# RVM initialization {{{1
##############################################################################
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# }}}
##############################################################################
