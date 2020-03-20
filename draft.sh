#!/usr/bin/env bash

# start #
[ $# -eq "1" ] && dir=$1 || echo "please supply parent directory"
allsoft="$dir/software"

# temp files and dirs #
[ -d "json-temp" ] || mkdir json-temp
[ -f "current.json" ] || touch current.json

# gather info #
declare -a all
declare -a ver

all=( $(ls $allsoft) ) && echo ${all[@]}
for soft in ${all[@]}; do
  ver=( $(ls -F "$allsoft/$soft" | grep /) )
  curr=`echo TODO` # Check current version from modulefiles
  # cat "$dir/modulefiles/mugqic/$soft/.version" \
  #   | 
done


# create objects #
declare -A obj


# write to json #

if [[ `jq --version | echo $?` -eq 127 ]]; then
  [ "$OSTYPE" == "linux-gnu" ] && `apt-get install -y jq`
  [ "$OSTYPE" == "darwin"* ] && `brew install jq`
  # Add `jq` to catalog
fi

for soft in "${all[@]}"; do 
  echo "processing $soft" 
done



