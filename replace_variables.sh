#!/bin/bash

# Replace --***-- with $***(environment variables)
ORIGINAL_FILE=$1
REPLACED_FILE=$2

cp ./$ORIGINAL_FILE ./$REPLACED_FILE
cat $REPLACED_FILE | while read line
do
  if [[ $line =~ --([A-Z_]+)-- ]] ; then
    KEY=${BASH_REMATCH[1]}
    eval VALUE='$'${KEY}
    sed -i -e "s!${BASH_REMATCH[0]}!$VALUE!g" $REPLACED_FILE
  fi
done
