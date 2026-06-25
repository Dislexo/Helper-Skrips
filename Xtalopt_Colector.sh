#!/bin/bash

#Initial settings
filetype="POSCAR"
resultsfile="results.txt"
cutoff=100000 #eV
nmax=100000
singlefile=FALSE
compsplit=FALSE

# --- Flags ---
while [[ $# -gt 0 ]]; do
  case "$1" in
    -f|--filetyp)  filetype="$2";   shift 2 ;;
    -c|--cutoff)   cutoff="$2";     shift 2 ;;
    -1|--asone)    singlefile=TRUE; shift 1 ;;
    -2|--percomp)  compsplit=TRUE;  shift 1 ;;
    -n|--nmax)     nmax="$2";       shift 2 ;;
    -*)            echo "Unknown flag: $1" >&2; exit 1 ;;
  esac
done

echo "colecting: $filetype ranked by Entropy per Atom"

mkdir -p Structures
while IFS= read -r results; do
    Number=$(echo "$results" | awk '{print $1}')
    Comp=$(echo "$results" | awk '{print $4}')
    E_a_A=$(echo "$results" | awk '{print $6}')
    SG=$(echo "$results" | awk '{print $9}')
    above_hull=$(echo "$results" | awk '{print $8}')
    if [ $Number == $nmax ] ; then echo "nmax reached" ;exit 0; fi
    if awk "BEGIN {exit !($above_hull > $cutoff)}" ;then
      echo "cutoff reached"; exit 0; fi

    filein=$(echo "$results" | awk '{print $2}')
    filein="*00${filein%%x*}x*00${filein##*x}/$filetype"
    #echo "Coppying Sructure: $Number $above_hull $E_a_A $SG"

    if [[ $singlefile == TRUE ]]; then fileout=ranked.POSCARS
    elif [[ $compsplit == TRUE ]]; then
    fileout=./Structures/$Comp.ranked.POSCARS
    echo $results >> "./Structures/$Comp.Results.txt"
    else mkdir -p Structures/$Comp
    fileout="./Structures/$Comp/Structure$Number.vasp"
    echo $results >> "./Structures/$Comp/Results.txt"
    fi
    #coppy poscars with header
    {
    echo "# $Number Energy/Atom: $E_a_A Hull: $above_hull SG: $SG"
    tail -n +2 $filein
    } >> $fileout

done < <(tail -n +2 $resultsfile)
