#!/bin/bash

fileIN_A=$1
fileIN_B=$2
fileout=$3

NA=`grep -c "Configuration num" ${fileIN_A}`; 
NB=`grep -c "Configuration num" ${fileIN_B}`;
N=$(($NA+$NB))

echo "fusing files:"
echo $1
echo "${NA} Configurations"
echo $2
echo "${NB} Configurations"
echo ""
echo "fused to:"
echo $fileout
echo "${N} Configuations"

#FILE writing
i=1
rm $fileout
touch $fileout
while IFS= read -r line
do
	if [ $i == 5 ]; then
		printf '%s\n' "$N" >> $fileout
	else
		printf '%s\n' "$line" >> $fileout
	fi
	i=$((i+1))
done < $fileIN_A

echo '**************************************************' >> $fileout
Ni=$NA
Prelines=0
while IFS= read -r line
do
	if [[ "$line" == *"Configuration num."* ]]; then
		Ni=$(($Ni+1))
		printf '%s\n' "     Configuration num.      ${Ni}" >> $fileout
	elif [ "$Ni" == "$NA" ]; then
		Prelines=$(($Prelines+1))
	else
		printf '%s\n' "$line" >> $fileout
	fi
done < $fileIN_B
