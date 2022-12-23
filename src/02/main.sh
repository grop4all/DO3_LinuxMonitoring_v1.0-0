#!/bin/bash

text="HOSTNAME = $(hostname)
\nTIMEZONE = $(cat /etc/timezone)
\nUSER = $USER
\nOS = $(cat /etc/issue | cut -d ' ' -f1,2)
\nDATE = $(date)
\nUPTIME = $(uptime -p)
\nUPTIME_SEC = $(cat /proc/uptime | cut -d' ' -f1)
\nip = $(hostname -I)
\nGATEWAY = $(ip route | grep default | cut -d ' ' -f3)
\nRAM_TOTAL = $(free | grep Mem | sed 's/\s\+/,/g' | cut -d ',' -f2 | awk '{printf ("%.3fGB\n",$0/1024/1024)}')
\nRAM_USED = $(free | grep Mem | sed 's/\s\+/,/g' | cut -d ',' -f3 | awk '{printf ("%.3fGB\n",$0/1024/1024)}')
\nRAM_FREE = $(free | grep Mem | sed 's/\s\+/,/g' | cut -d ',' -f4 | awk '{printf ("%.3fGB\n",$0/1024/1024)}')
\nSPACE_ROOT = $(df /root | grep  / | sed 's/\s\+/,/g' | cut -d ',' -f2 | awk '{printf ("%.2fMB\n",$0/1024)}')
\nSPACE_ROOT_USED = $(df /root | grep  / | sed 's/\s\+/,/g' | cut -d ',' -f3 | awk '{printf ("%.2fMB\n",$0/1024)}')
\nSPACE_ROOT_FREE = $(df /root | grep  / | sed 's/\s\+/,/g' | cut -d ',' -f4 | awk '{printf ("%.2fMB\n",$0/1024)}')"
echo -en $text
echo
echo "Сохранить данные, нажмите Y или y"
echo "Чтобы не сохранять нажмите любую клавишу"
read var1
if [ -z "$var1" ] ; then
    exit 0
fi
if [ 'Y' == $var1 -o 'y' == $var1 ] ; then
    val=$(date +"%d_%m_%Y_%H_%M_%S")
    touch $val.txt
    echo -en $text>>$val.txt
fi
