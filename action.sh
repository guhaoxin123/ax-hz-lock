#!/system/bin/sh
echo "Q群:1058272764"
echo "ghxnb666"
echo "- Android 版本 : $(getprop ro.build.version.release)"
sleep 0.3
echo "- 内核版本: $(uname -r)"
sleep 0.3
echo "- 处理器 : $(getprop ro.product.board)"
sleep 0.3
echo "- CPU 信息: $(getprop ro.hardware)"
sleep 0.3
echo "- 内存大小: $(free | grep Mem | awk '{print $2}')"
max_rate=$(dumpsys display 2>/dev/null | grep -oE 'fps=[0-9.]+' | cut -d= -f2 | sort -nr | head -n 1)
[ -z "$max_rate" ] && max_rate=$(dumpsys SurfaceFlinger 2>/dev/null | grep -oE '[0-9.]+ *Hz' | grep -oE '[0-9.]+' | sort -nr | head -n 1)
[ -z "$max_rate" ] && max_rate=$(dumpsys display 2>/dev/null | grep -oE '[0-9.]+ *Hz' | grep -oE '[0-9.]+' | sort -nr | head -n 1)

if [ -n "$max_rate" ]; then
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
fi

rate=$(dumpsys display 2>/dev/null | grep -oE 'fps=[0-9.]+' | cut -d= -f2 | sort -nr | head -n 1)
[ -z "$rate" ] && rate=$(dumpsys SurfaceFlinger 2>/dev/null | grep -oE 'cur[: ]+[0-9.]+' | grep -oE '[0-9.]+' | sort -nr | head -n 1)
[ -z "$rate" ] && rate=$(dumpsys display 2>/dev/null | grep -oE '[0-9.]+ *Hz' | grep -oE '[0-9.]+' | sort -nr | head -n 1)
[ -z "$rate" ] && rate="未知"

cmd notification post -S bigtext -t "当前屏幕帧率" "Tag" "当前刷新率: ${rate} Hz" 2>/dev/null