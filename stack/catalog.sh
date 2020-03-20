#!/usr/bin/env bash


# start #
[ $# -eq "1" ] && dir=$1 || echo "please supply parent directory"
allsoft="$dir/modulefiles/mugqic"

# check for jq
if [[ `jq --version | echo $?` -eq 127 ]]; then
  [ "$OSTYPE" == "linux-gnu" ] && `apt-get install -y jq`
  [ "$OSTYPE" == "darwin"* ] && `brew install jq`
  # Add `jq` to catalog ~ Maybe not?
fi

# gather info #
declare -a all
for soft in $(ls $allsoft); do vers=(`ls -F "$allsoft/$soft"`)
  curr=`cat "$allsoft/$soft/.version" | grep \" | awk '{print $NF}' | \
    sed -e 's/^"//' -e 's/"$//'` # Remove enclosing quotes
  json=$( jq -n --arg mod "" --arg amod "" \
    --arg nam "$soft" --arg ver "${vers[*]}" --arg cur "$curr" \
    --arg ins "" --arg upd "" --arg aut "" \
    --arg des "" --arg url "" --arg doc "" \
    --arg note "based on information given. needs human input." \
    '{ name:$nam, versions:$ver, current:$cur,
      installed:$ins, updated:$nam, author:$aut,
      desc:$des, url:$url, docs:$doc,
      modules:$mod, auto_modules:$amod, notes:$note }' )
all+=($json); done

# write to file #
to_write=`echo ${all[*]} | sed 's/} {/}, {/g'`
to_write="[ $to_write ]" && echo $to_write > current.json