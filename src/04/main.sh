#!/bin/bash
NORMAL='\033[0m'
BLACK='\033[0;30m'     #  ${BLACK}    # чёрный цвет знаков
RED='\033[0;31m'       #  ${RED}      # красный цвет знаков
GREEN='\033[0;32m'     #  ${GREEN}    # зелёный цвет знаков
YELLOW='\033[0;33m'     #  ${YELLOW}    # желтый цвет знаков
BLUE='\033[0;34m'       #  ${BLUE}      # синий цвет знаков
MAGENTA='\033[0;35m'     #  ${MAGENTA}    # фиолетовый цвет знаков
CYAN='\033[0;36m'       #  ${CYAN}      # цвет морской волны знаков (это синий!!!!!!)
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
fl=()
default=(1 2 3 4)
listofcolor=(white red green blue purple black)
count=0
for val in 1 2 3 4
do
    buff=$(cat conf | sed -n "$val"p | cut -c 20)
    echo $buff
    if [ -z $buff ] ; then
        buff=${default[$count]}
        fl=(${fl[*]} $buff)
    else
        fl=(${fl[*]} $buff)
    fi
    count=$(($count + 1))
done
echo ${fl[*]}
BGcolor1=${fl[0]}
color2=${fl[1]}
BGcolor3=${fl[2]}
color4=${fl[3]}
if [ ${fl[0]} -eq ${fl[1]} -o ${fl[2]} -eq ${fl[3]} ] ; then
    echo -e "Недопустимо совпадение цвета столца и цвета шрифта cхема\n (число)-цвет фона,(число)-цвет шрифта,\n(число)-цвет фона,(число)-цвет шрифта\n пример 1 2 3 4"
    exit 1
fi
for val in ${fl[*]}
do
    if [[ !($val =~ [1-6]) ]] ; then
    echo "Все аргуметы имеют значение от 1 до 6"
    exit 1
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
echo
if [[ $fl == $default ]] ; then
    echo -e "Column 1 background = default (white)
Column 1 font color = default (red)
Column 2 background = default (green)
Column 2 font color = default (blue)"
    else
    echo "Column 1 background = ${fl[0]} (${listofcolor[${fl[0]}-1]})
Column 1 font color = ${fl[1]} (${listofcolor[${fl[1]}-1]})
Column 2 background = ${fl[2]} (${listofcolor[${fl[2]}-1]})
Column 2 font color = ${fl[3]} (${listofcolor[${fl[3]}-1]})"
fi