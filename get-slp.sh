#! /cygdrive/c/Windows/system32/bash
URLFILE="urls.txt"
P0="FOX"
P1="FOX"
STAGE="ALL"
OUTPATH="./slp-files/${P0}/${P1}/${STAGE}"
mkdir -p $OUTPATH
rm -f $OUTPATH/*
python get_urls.py --STAGE=$STAGE > $URLFILE
dos2unix $URLFILE
for url in $(cat $URLFILE); do
  FILENAME="${OUTPATH}/game"
  if [[ -e $FILENAME.slp || -L $FILENAME.slp ]] ; then
      i=0
      while [[ -e $FILENAME-$i.slp || -L $FILENAME-$i.slp ]] ; do
          let i++
      done
      FILENAME=$FILENAME-$i
  fi
  FILENAME="${FILENAME}.slp"
  wget -O $FILENAME $url
done