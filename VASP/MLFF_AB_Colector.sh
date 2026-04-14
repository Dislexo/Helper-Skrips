#!/bin/bash
#run in target folder same depth as the calculation folders

n=1 #starting index
Fileend="ML_ABN"
Prefix="Xtalopt" 
Folder="CalcFold"

while [ -d "../$Folder${n}" ]; do #wihile directory exists
echo "$Folder${n}"
cp "../$folder${n}/${Filename}" "$Prefix${n}.${Fileend}"
n=$((n+1))
done
