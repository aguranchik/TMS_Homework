#!/bin/bash

echo -e "Всего запущенных процессов\t `ps aux | wc -l`"
echo -e "Использование  CPU        \t `uptime | awk '{print $10,$11,$12}'`"
echo -e "Загрузка CPU              \t `ps -aux | awk '{print $3}' | grep -v "%CPU" | awk '{p+=$1} END {print p "%"}'`"
echo -e "Доступная память          \t `free -h | grep Mem | awk '{print $4}'`"
echo -e "Подключений к порту:$1    \t `netstat -tun | awk '{print $4}' | grep ":$1" | wc -l`"
echo -e "Общий объем дисков        \t `fdisk -l | grep "Disk /" | awk '{s += $5} END {print s/1024/1024/1024 "Gb"}'`"