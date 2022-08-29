#! /cygdrive/c/Windows/system32/bash
source './settings.sh'
rm -f $SLPDIR/*
for url in $(cat $URLFile); do
  FILENAME="${SLPDIR}/game"
  if [[ -e $FILENAME.slp || -L $FILENAME.slp ]] ; then
      i=1
      while [[ -e $FILENAME-$i.slp || -L $FILENAME-$i.slp ]] ; do
          let i++
      done
      FILENAME=$FILENAME-$i
  fi
  FILENAME="${FILENAME}.slp"
  wget -O $FILENAME $url
  echo $i
done