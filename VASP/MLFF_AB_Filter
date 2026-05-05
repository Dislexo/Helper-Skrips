#!/bin/bash

fileIN=$1
fileout=$2

NG=`grep -c "Configuration num" ${fileIN}`;

echo "clean file:"
echo $1
echo "${NG} Configurations"

Ecrit=10
E=0
N=0
ECount=3

while IFS= read -r line ; do
    ECount=$(($ECount+1))
	if [[ "$line" == *"Configuration num."* ]]; then
        if awk "BEGIN {exit !($Ecrit > $E)}"; then
            cat "temp.AB" >> "confis"
        else echo "Structure $N is faulty"
            cat "temp.AB" >> "bad.confis"
            N=$(($N-1))
        fi
		N=$(($N+1))
		printf '%s\n' "     Configuration num.      ${N}" > "temp.AB"
	elif [ "$N" == "0" ] ; then
        printf '%s\n' "$line" >> "starting.info"
    elif [[ "$line" == *"Total energy (eV)"* ]] ; then
        ECount=0
        printf '%s\n' "$line" >> "temp.AB"
    elif [  "$ECount" == "2" ] ; then
        E=$line
        printf '%s\n' "$line" >> "temp.AB"
    else printf '%s\n' "$line" >> "temp.AB"
	fi
done < $fileIN
cat "temp.AB" >> "confis"

i=0
while IFS= read -r line
do
	if [ $i == 4 ]; then
		printf '%s\n' "     $N" >> $fileout
	else
		printf '%s\n' "$line" >> $fileout
	fi
	i=$((i+1))
done < "starting.info"
cat "confis" >> $fileout
rm starting.info temp.AB confis

echo " "
echo "cleaned to:"
echo $fileout
echo "$N Configuations"
