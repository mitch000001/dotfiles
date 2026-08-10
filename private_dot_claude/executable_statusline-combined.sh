#!/usr/bin/env bash
# Combined statusline: reads the Status hook JSON once and feeds a copy to each
# component script, stacking their output on two lines.
#   line 1: statusline-command.sh — time user@host:dir (git)
#   line 2: statusline-cost.sh     — model · dir · $cost · +added/-removed
#           + statusline-ticket.sh — · 🎫 <YouTrack key> when one is in the transcript
# Both component scripts consume stdin via `cat`, so the JSON is captured here
# and replayed to each (stdin can only be read once).
input=$(cat)

printf '%s' "$input" | bash ~/.claude/statusline-command.sh
echo
cost=$(printf '%s' "$input" | bash ~/.claude/statusline-cost.sh)
ticket=$(printf '%s' "$input" | bash ~/.claude/statusline-ticket.sh)
printf '%s%s' "$cost" "$ticket"
