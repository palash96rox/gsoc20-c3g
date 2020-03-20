#!/usr/bin/env bash


# start #
[ $# -eq "1" ] && dir=$1 || echo "please supply parent directory"
allsoft="$dir/modulefiles/mugqic"


# gather info #
declare -a all
declare -A obj

all=( $(ls $allsoft) ) && len=${#all[@]}; i=0
for soft in ${all[@]}; do ((i++))
  vers=`ls -F "$allsoft/$soft" | tr '\n' ',' | sed -e 's/,$//' -e 's/,/ | /g'`
  curr=`cat "$allsoft/$soft/.version" | grep \" | awk '{print $NF}' | \
    sed -e 's/^"//' -e 's/"$//'`
  obj["$i,name"]=$soft; obj["$i,versions"]=$vers; obj["$i,current"]=$curr
  obj["$i,notes"]="based on information given. needs human intervention."
done


# write to json #
[ -f "current.json" ] || touch current.json
  # check for jq
if [[ `jq --version | echo $?` -eq 127 ]]; then
  [ "$OSTYPE" == "linux-gnu" ] && `apt-get install -y jq`
  [ "$OSTYPE" == "darwin"* ] && `brew install jq`
  # Add `jq` to catalog ~ Maybe not?
fi
  # write to file
i=0; while [ $i -lt $len ]; do
  echo "Processing ${all[$i]}"

((i++)); done