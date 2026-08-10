#!/usr/bin/env bash
# First line of the combined statusline — mirrors the interactive prompt built
# by set_bash_prompt() in ~/.bash.d/02-bash_prompt.sh.
#
# Rather than duplicate that logic, we SOURCE the same file the shell does and
# call its context helpers (set_ceph/openstack/k8s_context) + colours directly,
# so the fiddly bits (e.g. the OS_CLOUD mismatch "!" marker) stay single-source.
# We deliberately do NOT call set_bash_prompt itself: it has interactive side
# effects wrong for a statusline (set_title emits an OSC escape, history -a,
# ruby -v per render, a two-line prompt + input symbol).
#
# Layout:  ⦧ [venv] [ceph] [os_cloud] HH:MM:SS  host  /path  <k8s-ctx> (branch)
#
# Env-dependent segments reflect the environment Claude Code was launched with.
export LC_ALL=C

input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // ""')
[ -n "$cwd" ] || cwd=$PWD

# The prompt's context helpers depend on these predicates (defined in ~/.bashrc,
# which we don't want to source). Provide the ones we need.
has_kubectl() { command -v kubectl >/dev/null 2>&1; }

# Same colour + helper definitions the interactive shell loads, in the same
# order (01 then 02, so 02's bolder redefinitions win — as in the real prompt).
# shellcheck disable=SC1090
source ~/.bash.d/01-colors.sh 2>/dev/null
# shellcheck disable=SC1090
source ~/.bash.d/02-bash_prompt.sh 2>/dev/null

# Populate the context segments using the prompt's own logic.
set_virtualenv
set_ceph_context
set_openstack_context
set_k8s_context

# time · host · full path (with $HOME collapsed to ~, like \w)
now=$(date +%H:%M:%S)
host=$(hostname -s)
path=${cwd/#$HOME/\~}

# git branch + dirty/untracked markers (kept local: __git_ps1 would need
# git-prompt.sh sourced, which lives in ~/.bashrc, not bash.d).
git_seg=""
if git -C "$cwd" --no-optional-locks rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null \
           || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  dirty=""
  [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ] && dirty="*"
  untracked=""
  [ -n "$(git -C "$cwd" --no-optional-locks ls-files --others --exclude-standard 2>/dev/null)" ] \
    && untracked="%"
  git_seg="(${branch}${dirty}${untracked})"
fi

line="⦧ ${PYTHON_VIRTUALENV}${CEPH_CLUSTER_ENV}${OPENSTACK_CLUSTER_ENV}"
line+="${now} ${RED}${host}${COLOR_NONE} ${BLUE}${path}${COLOR_NONE} "
line+="${K8S_CONFIG_CONTEXT}${git_seg}"

# Strip readline non-printing markers (\[ \]) the prompt colours carry; they
# are meaningful only inside a real PS1.
line=${line//\\[/}
line=${line//\\]/}

printf '%b' "$line"
