#!/bin/bash

# The various escape codes that we can use to color our prompt.
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
       PINK="\[\033[1;35m\]"
 LIGHT_BLUE="\[\033[1;36m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

# Determine the branch/state information for this git repository.
function set_git_branch {
  # Capture the output of the "git status" command.
  git_status="$(git status --porcelain -u -z -b 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  regex_not_added=" [MDA]"
  regex_added="[MDA] "
  if [[ ${git_status} =~ $regex_not_added ]]; then
    state="${LIGHT_RED}"
  elif [[ ${git_status} =~ $regex_added ]]; then
    state="${YELLOW}"
  else
    state="${GREEN}"
  fi

  new=""
  regex_new="\?\? "
  if [[ ${git_status} =~ $regex_new ]]; then
    new="*"
  fi

  # Set arrow icon based on status against remote.
  ahead=""
  ahead_pattern="ahead ([[:digit:]]+)"
  if [[ ${git_status} =~ ${ahead_pattern} ]]; then
    ahead=">"
  fi
  behind=""
  behind_pattern="behind ([[:digit:]]+)"
  if [[ ${git_status} =~ ${behind_pattern} ]]; then
    behind="<"
  fi

  # Capture the output of the "git status" command with branch.
  # Get the name of the branch.
  branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

  # Set the final branch string.
  BRANCH="[${state}${branch}${COLOR_NONE}${RED}${ahead}${behind}${new}${COLOR_NONE}] "
}

function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  duration=$(printf '%02dh:%02dm:%02ds' $(($timer_show/3600)) $(($timer_show%3600/60)) $(($timer_show%60)))
  LAST_COMMAND_DURATION="[${YELLOW}${duration}${COLOR_NONE}]"
  unset timer
}

trap 'timer_start' DEBUG

if [ "$PROMPT_COMMAND" == "" ]; then
  PROMPT_COMMAND="timer_stop"
else
  PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="${LIGHT_BLUE}›${COLOR_NONE}"
  else
      PROMPT_SYMBOL="${LIGHT_RED}›${COLOR_NONE}"
  fi
}

# Determine active Python virtualenv details.
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi
}

function set_node_version () {
  NODE_VERSION=""
  if has_nvm; then
    NODE_VERSION="${LIGHT_GREEN}<$(nvm current)>${COLOR_NONE} "
  fi
}

function set_k8s_context () {
  K8S_CONFIG_CONTEXT=""
  if has_kubectl; then
    K8S_CONFIG_CONTEXT="${LIGHT_GREEN}<$(kubectl config current-context)>${COLOR_NONE} "
  fi
}

function set_ruby_version () {
  ruby_version="$(ruby -v)"
  version_pattern="^ruby ([0-9\.p]+)"
  RUBY_VERSION=""
  if [[ ${ruby_version} =~ ${version_pattern} ]]; then
    RUBY_VERSION="${LIGHT_BLUE}<${BASH_REMATCH[1]}>${COLOR_NONE} "
  fi
}

function set_user_prompt () {
  if [ -n "${PROMPT_SHOW_USER}" ]; then
    if [ $(id -u) == '0' ]; then
      color="${RED}"
    else
      color="${PINK}"
    fi
    USER_PROMPT="${color}\u${COLOR_NONE} at "
  else
    USER_PROMPT=""
  fi
}

function set_bg_jobs () {
  if test "$(jobs)" ; then
    JOBS="[\j] "
  else
    JOBS=""
  fi
}

function has_t() {
  return `test -z $(command -v t >/dev/null 2>&1)`
}

function set_t_tasks () {
  if has_t; then
    tasks=$(t | wc -l | sed -e's/ *//')
  else
    tasks=0
  fi
  if test "${tasks}" -gt 0; then
    TASKS="(t: ${tasks}) "
  else
    TASKS=""
  fi
}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  # Set the PYTHON_VIRTUALENV variable.
  set_virtualenv

  set_ruby_version

  set_k8s_context

  set_user_prompt

  set_bg_jobs

  set_t_tasks
  # write history after each command
  history -a

  # Set the BRANCH variable.
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=''
  fi

  set_title "$(basename `pwd`)"

  # Set the bash prompt variable.
  PS1="⦧ ${PYTHON_VIRTUALENV}\\t ${USER_PROMPT}${RED}\\h${COLOR_NONE} ${BLUE}\\w${COLOR_NONE} ${K8S_CONFIG_CONTEXT}${BRANCH}${LAST_COMMAND_DURATION}
${JOBS}${TASKS}${PROMPT_SYMBOL} "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
