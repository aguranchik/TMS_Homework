x=${1:-3}
echo -e "###### array ${1:-3}x${2:-3} ######\n" >> array.log
while [ $x -gt 0 ]; do
  y=${2:-3}
  while [ $y -gt 0 ]; do
    echo -n "$(( RANDOM % 9 + 1))   " >> array.log
    (( y-- ))
  done
  (( x-- ))
  echo -e "\n" >> array.log
done
echo -e "\n" >> array.log