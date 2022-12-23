#!/bin/bash
NORMAL='\033[0m'

BLACK='\033[0;30m'     #  ${BLACK}    # чёрный цвет знаков
RED='\033[0;31m'       #  ${RED}      # красный цвет знаков
GREEN='\033[0;32m'     #  ${GREEN}    # зелёный цвет знаков
YELLOW='\033[0;33m'     #  ${YELLOW}    # желтый цвет знаков
BLUE='\033[0;34m'       #  ${BLUE}      # синий цвет знаков
MAGENTA='\033[0;35m'     #  ${MAGENTA}    # фиолетовый цвет знаков
CYAN='\033[0;36m'       #  ${CYAN}      # цвет морской волны знаков
GRAY='\033[0;37m'       #  ${GRAY}      # серый цвет знаков
PURPLE='\033[35m'
WHITE='\033[1;37m'
BGWHITE='\033[47m'
BGPURPLE='\033[45m'
BGBLACK='\033[40m'     #  ${BGBLACK}
BGRED='\033[41m'       #  ${BGRED}
BGGREEN='\033[42m'     #  ${BGGREEN}
BGBROWN='\033[43m'     #  ${BGBROWN}
BGBLUE='\033[44m'     #  ${BGBLUE}
BGMAGENTA='\033[45m'     #  ${BGMAGENTA}
BGCYAN='\033[46m'     #  ${BGCYAN}
BGGRAY='\033[47m'     #  ${BGGRAY}
BGDEF='\033[49m'      #  ${BGDEF}
BGcolor1=$1
color2=$2
BGcolor3=$3
color4=$4
if [ $# -ne 4 ] ; then
    echo "Необходимо четыре параметра от 1 до 6"
    exit 0
fi
if [ $1 -eq $2 -o $3 -eq $4 ] ; then
    echo -e "Недопустимо совпадение цвета столца и цвета шрифта cхема\n (число)-цвет фона,(число)-цвет шрифта,\n(число)-цвет фона,(число)-цвет шрифта\n пример 1 2 3 4"
    exit 0
fi
for val in $@ 
do
    if [[ !($val =~ [1-6]) ]] ; then
    echo "Все аргуметы имеют значение от 1 до 6"
    exit 0
    fi
done
var=$BGcolor1
case $var in 
    1 ) var=$BGWHITE ;;
    2 ) var=$BGRED ;;
    3 ) var=$BGGREEN ;;
    4 ) var=$BGCYAN ;;
    5 ) var=$BGPURPLE ;;
    6 ) var=$BGBLACK ;; 
esac
BGcolor1=$var

var=$BGcolor3
case $var in 
    1 ) var=$BGWHITE ;;
    2 ) var=$BGRED ;;
    3 ) var=$BGGREEN ;;
    4 ) var=$BGCYAN ;;
    5 ) var=$BGPURPLE ;;
    6 ) var=$BGBLACK ;; 
esac
BGcolor3=$var
var=$color2
case $var in 
    1 ) var=$WHITE ;;
    2 ) var=$RED ;;
    3 ) var=$GREEN ;;
    4 ) var=$CYAN ;;
    5 ) var=$PURPLE ;;
    6 ) var=$BLACK ;; 
    esac
color2=$var
var=$color4
case $var in 
    1 ) var=$WHITE ;;
    2 ) var=$RED ;;
    3 ) var=$GREEN ;;
    4 ) var=$CYAN ;;
    5 ) var=$PURPLE ;;
    6 ) var=$BLACK ;; 
    esac
color4=$var
l=$color2$BGcolor1
r=$color4$BGcolor3
echo -e "${color2}${BGcolor1}HOSTNAME${NORMAL}=${color4}${BGcolor3}$(hostname)${NORMAL}"
echo -e "${color2}${BGcolor1}TIMEZONE${NORMAL}=${color4}${BGcolor3}$(cat /etc/timezone)${NORMAL}"
echo -e "${color2}${BGcolor1}USER${NORMAL} ${color4}${BGcolor3}$USER${NORMAL}"
echo -e "${color2}${BGcolor1}OS${NORMAL}=${r}$(cat /etc/issue | cut -d ' ' -f1,2)${NORMAL}"
echo -e "${l}DATE${NORMAL}=${r}$(date)${NORMAL}"
echo -e "${l}UPTIME${NORMAL}=${r}$(uptime -p)${NORMAL}"
echo -e "${l}UPTIME_SEC${NORMAL}=${r}$(cat /proc/uptime | cut -d' ' -f1)${NORMAL}"
echo -e "${l}ip${NORMAL}=${r}$(hostname -I)${NORMAL}"
echo -e "${l}GATEWAY${NORMAL}=${r}$(ip route | grep default | cut -d ' ' -f3)${NORMAL}"
echo -e "${l}RAM_TOTAL${NORMAL}=${r}$(free | grep Mem | sed 's/\s\+/,/g' | cut -d ',' -f2 | awk '{printf ("%.3fGB\n",$0/1024/1024)}')${NORMAL}"
echo -e "${l}RAM_USED${NORMAL}=${r}$(free | grep Mem | sed 's/\s\+/,/g' | cut -d ',' -f3 | awk '{printf ("%.3fGB\n",$0/1024/1024)}')${NORMAL}"
echo -e "${l}RAM_FREE${NORMAL}=${r}$(free | grep Mem | sed 's/\s\+/,/g' | cut -d ',' -f4 | awk '{printf ("%.3fGB\n",$0/1024/1024)}')${NORMAL}"
echo -e "${l}SPACE_ROOT${NORMAL}=${r}$(df /root | grep  / | sed 's/\s\+/,/g' | cut -d ',' -f2 | awk '{printf ("%.2fMB\n",$0/1024)}')${NORMAL}"
echo -e "${l}SPACE_ROOT_USED${NORMAL}=${r}$(df /root | grep  / | sed 's/\s\+/,/g' | cut -d ',' -f3 | awk '{printf ("%.2fMB\n",$0/1024)}')${NORMAL}"
echo -e "${l}SPACE_ROOT_FREE${NORMAL}=${r}$(df /root | grep  / | sed 's/\s\+/,/g' | cut -d ',' -f4 | awk '{printf ("%.2fMB\n",$0/1024)}')${NORMAL}"
