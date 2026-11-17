#!/system/bin/sh
lock_max_rate() {
  max_rate=$(dumpsys display 2>/dev/null | grep -oE 'fps=[0-9.]+' | cut -d= -f2 | sort -nr | head -n 1)
  [ -z "$max_rate" ] && max_rate=$(dumpsys SurfaceFlinger 2>/dev/null | grep -oE '[0-9.]+ *Hz' | grep -oE '[0-9.]+' | sort -nr | head -n 1)
  [ -z "$max_rate" ] && max_rate=$(dumpsys display 2>/dev/null | grep -oE '[0-9.]+ *Hz' | grep -oE '[0-9.]+' | sort -nr | head -n 1)
  [ -z "$max_rate" ] && return

  for key in peak_refresh_rate min_refresh_rate user_refresh_rate; do
    settings put system "$key" "$max_rate" 2>/dev/null
  done
  settings put secure peak_refresh_rate "$max_rate" 2>/dev/null
  settings put secure min_refresh_rate "$max_rate" 2>/dev/null
  settings put secure user_refresh_rate "$max_rate" 2>/dev/null
  settings put system vivo_screen_refresh_rate_mode 2 2>/dev/null
  settings put system refresh_rate_mode 2 2>/dev/null
  settings put secure refresh_rate_mode 2 2>/dev/null
  settings put system screen_refresh_rate "$max_rate" 2>/dev/null
  settings put secure screen_refresh_rate "$max_rate" 2>/dev/null
}

get_rate() {
  r=$(dumpsys display 2>/dev/null | grep -oE 'fps=[0-9.]+' | cut -d= -f2 | sort -nr | head -n 1)
  [ -z "$r" ] && r=$(dumpsys SurfaceFlinger 2>/dev/null | grep -oE 'cur[: ]+[0-9.]+' | grep -oE '[0-9.]+' | sort -nr | head -n 1)
  [ -z "$r" ] && r=$(dumpsys display 2>/dev/null | grep -oE '[0-9.]+ *Hz' | grep -oE '[0-9.]+' | sort -nr | head -n 1)
  [ -z "$r" ] && r="未知"
  echo "$r"
}

while true
do
  lock_max_rate
  rate=$(get_rate)
  cmd notification post -S bigtext -t "当前屏幕帧率" "Tag" "当前刷新率: ${rate} Hz" 2>/dev/null
  sleep 15
done