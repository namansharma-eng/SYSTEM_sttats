
# ---------------------------------------------
# server_stats.sh (Ubuntu)
# ---------------------------------------------

echo "======================================"
echo "        UBUNTU SERVER STATS            "
echo "======================================"
echo

echo "---- CPU USAGE ----"
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
CPU_USAGE=$(echo "100 - $CPU_IDLE" | bc)
echo "Total CPU Usage: $CPU_USAGE %"
echo

echo "---- MEMORY USAGE ----"
read MEM_TOTAL MEM_USED MEM_FREE <<< $(free -m | awk 'NR==2{print $2, $3, $4}')
MEM_PERCENT=$(echo "scale=2; $MEM_USED*100/$MEM_TOTAL" | bc)

echo "Total Memory : ${MEM_TOTAL} MB"
echo "Used Memory  : ${MEM_USED} MB"
echo "Free Memory  : ${MEM_FREE} MB"
echo "Memory Usage: ${MEM_PERCENT}%"
echo

echo "---- DISK USAGE ----"
df -h /
echo

echo "---- TOP 5 PROCESSES BY CPU ----"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

echo "---- TOP 5 PROCESSES BY MEMORY ----"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo


echo "---- EXTRA STATS ----"


echo "OS Version:"
lsb_release -d
echo

echo "Uptime:"
uptime -p
echo


echo "Load Average:"
uptime | awk -F'load average:' '{print $2}'
echo

echo "Logged-in Users:"
who | wc -l
echo

echo "Failed Login Attempts:"
sudo grep "Failed password" /var/log/auth.log | wc -l

echo
echo "======================================"
echo "        END OF REPORT                  "
echo "======================================"
