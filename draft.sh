#!/usr/bin/env bash

# start #
[ $# -eq "1" ] && dir=$1 || echo "please supply parent directory"
allsoft="$dir/modulefiles/mugqic"

# temp files and dirs #
[ -d "json-temp" ] || mkdir json-temp
[ -f "current.json" ] || touch current.json

# gather info #
declare -a all
declare -a ver

declare -A obj

all=( $(ls $allsoft) )
for soft in ${all[@]}; do
  ver=( $(ls -F "$allsoft/$soft") )
  curr=$(cat "$allsoft/$soft/.version" | grep \" | awk '{print $NF}')
  # .version format :: set ModulesVersion "<version-num>"
  declare -A temp
  temp[name]=$soft
  temp[versions]=$ver
  temp[current]=$curr
  temp[notes]=""
  obj+=([$soft]=$temp)
  for i in ${temp[@]}; do
    [ `declare -p ${1} 2> /dev/null | grep 'declare \-a'` ] \
      && echo ${!i[@]} || echo $i
  done
  echo ""
done


# write to json #

  # check for jq
if [[ `jq --version | echo $?` -eq 127 ]]; then
  [ "$OSTYPE" == "linux-gnu" ] && `apt-get install -y jq`
  [ "$OSTYPE" == "darwin"* ] && `brew install jq`
  # Add `jq` to catalog
fi

# for soft in "${all[@]}"; do 
#   echo "processing $soft" 
# done
