
cyan='\033[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\033[1;32m'
white='\e[1;37m'
red='\033[1;31m'
yellow='\e[0;33m'
BlueF='\e[1;34m' #Biru
RESET="\033[00m" #normal
orange='\033[33m'
white="`tput setaf 7`"

clear
echo "$okegreen[$orange * $okegreen]$cyan Choose OS:"
echo "$okegreen[$orange 1 $okegreen]$cyan Mac OS:"
echo "$okegreen[$orange 2 $okegreen]$cyan Linux OS:"
echo ""
read -rp "[ * ] " os

if [[ os -eq 1 ]]; then
    read -rp '[ * ] Enter your ip: ' ip
    if [[ "$ip" =~ ^[0-9]+$ ]]; then
        echo ""
    else
        echo "$okegreen[$orange * $okegreen]$red Wrong input"
        sleep 0.5
        ./hosts_checker.sh
    fi
elif [[ os -eq 2 ]]; then
    InT3R=`netstat -r | grep "default" | awk {'print $8'}` 2>/dev/null
    ip=`ifconfig $InT3R | egrep -w "inet" | awk '{print $2}'`
else
    echo "$okegreen[$orange * $okegreen]$red Wrong input"
    sleep 0.5
    ./hosts_checker.sh
fi

network_id="${ip%.*}."
count=0
last_alive_host=""

echo "$okegreen"
read -rp "Enter Number of Hosts you want to scan: " input

if [[ "$input" =~ ^[0-9]+$ ]]
then
	echo "$okegreen"
    echo "Your ip is: $orange$ip$okegreen"
    echo "You will scan $orange$input$okegreen input"
    echo ""
    while [ "$count" -le $input ]
    do 
        count=$(($count+1))
        current_ip=$network_id$count
        if ping -c 1 $current_ip &> /dev/null
            then
                echo "$orange$current_ip${okegreen} - ${okegreen}Active host${okegreen}"
                last_alive_host=$current_ip
            else
                echo "$orange$current_ip${okegreen} - ${red}Inactive host${okegreen}"
        fi
    done
else
	echo "$red"
    read -p "Wrong input, please run the tool again." m
    sleep 0.5
    ./hosts_checker.sh
fi
