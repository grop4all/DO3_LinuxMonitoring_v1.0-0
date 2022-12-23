#!/bin/bash
START_TIME=$(date +%s)
link=$1
echo $0
echo "Total number of folders (including all nested ones) = $(find $link -type d | wc -l)"

echo "TOP 5 folders of maximum size arranged in descending order (path and size): "
./help5.sh $(du -h $link*| sort -nr | head -n 5 | sed 's/\s\+/ /g')

echo Total number of files = $(find $link -type f | wc -l)


echo "Configuration files (with the .conf extension) = $(find $link -name "*.conf" | wc -l)"
echo  "Text files = $(find $link -name "*.txt" | wc -l)"
echo "Executable files = $(find $link -executable -type f | wc -l)"
echo "Log files (with the extension .log) = $(find $link -name "*.log" | wc -l)"
echo "Archive files = $(find -name "*.tar" | wc -l)"
echo "Symbolic links = $(find $link -type l | wc -l)"
echo

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):  "
echo -en "$(find $link -type f -exec du -Sh {} + | sort -rh | head  |awk '{print $2", "$1", "$2}' | sed -e 's/, \(\.\|\/\).*\./ /' )\n"
echo

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
list=($(find $link -type f -executable -exec du -Sh {} + | sort -rh | head  | sed 's/\s\+/ /g'))
files=()
weigth_files=()
for ((i = 0; i < ${#list[*]}; i++))
do
if [ $(($i % 2)) -eq 1 ] ; then
    files+=(${list[$i]})
    fi
done
for ((i = 0; i < ${#list[*]}; i++))
do
if [ $(($i % 2)) -eq 0 ] ; then
    weigth_files+=(${list[$i]})
    fi
done
for index in ${!files[*]} ; do
    echo $(($index + 1)) ${weigth_files[$index]} $(md5sum ${files[$index]}) | awk '{print $1" - "$4", "$2", "$3}'
done

END_TIME=$(date +%s)
difference=$(( $END_TIME - $START_TIME ))
echo "Script execution time (in seconds) = $difference"
#ok
# find . -type f  | awk -F. '{print $NF;}'
# echo $(ls -laRS $link* | head -n 10 | cut -d ' ' f8)
# find /home/nikita/ -type f -exec ls -sh {} \; | sort -rn | head -n 5
# ls -laRsh /home/nikita/* | grep  -E "^.*-[rwx-]{9}.*[^\.]$" | head -5                                              
#