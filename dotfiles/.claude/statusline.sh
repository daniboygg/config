#!/usr/bin/env bash
# Claude Code statusline: model, context window usage, session/weekly rate limits.
# Reads the statusLine JSON payload from stdin.

input=$(cat)

# ANSI colors (dimmed, since the statusline renders with dim styling).
c_grey=$'\033[90m'
c_grey_bold=$'\033[1;90m'
c_yellow=$'\033[33m'
c_reset=$'\033[0m'

# color_for pct -> grey by default, yellow only once usage hits the 90% warning threshold.
color_for() {
  local pct="$1"
  local pct_int="${pct%%.*}"
  if [ "$pct_int" -ge 90 ]; then
    echo "$c_yellow"
  else
    echo "$c_grey"
  fi
}

segments=()

model_name=$(echo "$input" | jq -r '.model.display_name // empty')
if [ -n "$model_name" ]; then
  segments+=("$(printf "%s%s%s" "$c_grey_bold" "$model_name" "$c_reset")")
fi

context_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$context_pct" ]; then
  color=$(color_for "$context_pct")
  segments+=("$(printf "%sContext:%s%%%s" "$color" "${context_pct%%.*}" "$c_reset")")
fi

five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

if [ -n "$five_hour" ]; then
  color=$(color_for "$five_hour")
  segments+=("$(printf "%sSession:%s%%%s" "$color" "${five_hour%%.*}" "$c_reset")")
fi

if [ -n "$seven_day" ]; then
  color=$(color_for "$seven_day")
  segments+=("$(printf "%sWeekly:%s%%%s" "$color" "${seven_day%%.*}" "$c_reset")")
fi

if [ "${#segments[@]}" -eq 0 ]; then
  printf "%s" "no usage data"
else
  out=""
  for i in "${!segments[@]}"; do
    if [ "$i" -gt 0 ]; then
      out+=" | "
    fi
    out+="${segments[$i]}"
  done
  printf "%s" "$out"
fi
