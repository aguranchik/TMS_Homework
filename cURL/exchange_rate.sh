#!/bin/bash
str=$(curl -s https://myfin.by/bank/kursy_valjut_nbrb)
ex_rate(){
    echo $str |  grep 'a href="/bank/kursy_valjut_nbrb/' | sed 's:<a href="/bank/kursy_valjut_nbrb/:\n(&):g' | sed '1d' | sed 's:data-key="[0-9]*"><td>:(&)\n:g' | sed '$d' | sed '/^$/d' | grep -i $1 | awk -F"</td><td>" '{print $2}'
}

menu(){
  select currency
  do
    # if [[ $currency == "Exit" ]]
    # then
    #   exit_state=1
    #   break
    # elif [[ $@ == *"$currency"* ]]
    # then
    #   echo "Exchange rate $currency: " $(ex_rate $currency)
    #   break       
    # else
    #   echo "Input ERROR"
    #   break
    # fi
    case $currency in
      Exit)
        exit_state=1
        break
        ;;
      [A-Z]*)
        echo "Exchange rate $currency: " $(ex_rate $currency)
        break
        ;;
      *)
        echo "Input ERROR"
        break
        ;;
    esac
  done
}

PS3="Select currency: "
exit_state=0
while [ $exit_state -eq 0 ]
do
  clear
  menu USD EUR RUB UAH PLN Exit
  sleep 3
done
  