################

# Volume
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n1)

# Date and time
date_formatted=$(date "+%a %F %H:%M")

#############
# Commands
#############

# Network

temp_file="/tmp/net_stats"
rx_bytes_now=$(cat /sys/class/net/wlan0/statistics/rx_bytes)
tx_bytes_now=$(cat /sys/class/net/wlan0/statistics/tx_bytes)
now_time=$(date +%s)

if [[ -f $temp_file ]]; then
    read last_rx last_tx last_time < $temp_file
    time_diff=$((now_time - last_time))
    [[ $time_diff -eq 0 ]] && time_diff=1  # Avoid divide by zero
    rx_rate=$(( (rx_bytes_now - last_rx) / time_diff ))
    tx_rate=$(( (tx_bytes_now - last_tx) / time_diff ))
    rx_kbps=$((rx_rate / 1024))
    tx_kbps=$((tx_rate / 1024))
else
    rx_kbps=0
    tx_kbps=0
fi

echo "$rx_bytes_now $tx_bytes_now $now_time" > $temp_file

# CPU usage (1 second sample)
#
# read first snapshot
read cpu user nice system idle iowait irq softirq steal guest < /proc/stat
prev_total=$((user+nice+system+idle+iowait+irq+softirq+steal))
prev_idle=$((idle+iowait))

sleep 1

# read second snapshot
read cpu user nice system idle iowait irq softirq steal guest < /proc/stat
total=$((user+nice+system+idle+iowait+irq+softirq+steal))
idle_all=$((idle+iowait))

# calculate deltas
diff_total=$((total-prev_total))
diff_idle=$((idle_all-prev_idle))

# CPU usage over last second
cpu_usage=$(( (100*(diff_total-diff_idle)/diff_total) ))

# RAM usage
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_percent=$(( 100 * mem_used / mem_total ))

# Battery or charger
battery_charge=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)


echo "| down ${rx_kbps}KB/s up ${tx_kbps}KB/s | cpu ${cpu_usage}% | mem ${mem_percent}% | vol ${volume}% | $battery_status ${battery_charge}% | $date_formatted |"
