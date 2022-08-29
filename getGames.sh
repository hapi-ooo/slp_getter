#! /cygdrive/c/Windows/system32/bash
source './settings.sh'
rm -f $URLFile
touch $URLFile
mkdir -p $SLPDIR
rm -f $SLPDIR/*
for id in $(cat $IDFile) ; do
  data=$( jq '.id = $newVal' --arg newVal "$id" <<<"$variables")
  JSON_STRING=$( jq -c -n \
    --arg op "$operationName" \
    --argjson data "$data" \
    --arg q "$query" \
    '{"operationName": ($op), "variables": ($data), "query": $q}' )
  JSON_STRING=$( sed 's/\\\\/\\/g' <<< "$JSON_STRING" )
  JSON_STRING=$( sed 's/\x27/\x22/g' <<< "$JSON_STRING" )
  python getTourneyGames.py --stage "$STAGE" --p0 "$P0" --p1 "$P1" --url "$URL" --body "$JSON_STRING" --slpurl "$SLPURL" >> $URLFile
done
dos2unix $URLFile