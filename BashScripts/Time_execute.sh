# в качестве аргумента передается команда, например, 
# bash Time_execute.sh 'find /Users/guranchik/ -name tast -type f'
# bash Time_execute.sh 'sleep 5' 
# cкрипт возвращает время выполнения переданной команды в секундах

beginT=$(date +%s)
$1
endT=$(date +%s)
echo $endT - $beginT | bc