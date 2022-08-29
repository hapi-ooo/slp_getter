#! /cygdrive/c/Windows/system32/bash

URL="https://gql-gateway-dot-slippi.uc.r.appspot.com/graphql"
TournamentsPageBody='{"operationName":"TournamentsPage","variables":{"first":0,"offset":0},"query":"query TournamentsPage($first: Int, $offset: Int) {\n  queryTournament(order: {desc: startAt}, first: $first, offset: $offset) {\n    id\n    __typename\n  }\n  aggregateTournament {\n    count\n    __typename\n  }\n}\n"}'

operationName='GameTableComponent'
variables='{"id":"nan","first":0,"offset":0}'
query="fragment participantChiclet on GameParticipant {\n  id\n  port\n  type\n  color\n  nametag\n  character\n  __typename\n}\n\nfragment matchupDisplay on Game {\n  id\n  participants {\n    id\n    port\n    ...participantChiclet\n    __typename\n  }\n  __typename\n}\n\nfragment gameTableGameData on Game {\n  id\n  slpPath\n  station\n  stage\n  startAt\n  ...matchupDisplay\n  __typename\n}\n\nquery GameTableComponent(\$id: ID!, \$first: Int!, \$offset: Int!) {\n  getTournament(id: \$id) {\n    id\n    games(first: \$first, offset: \$offset, order: {desc: startAt}) {\n      ...gameTableGameData\n      __typename\n    }\n    gamesAggregate {\n      count\n      __typename\n    }\n    __typename\n  }\n}\n"
IDFile="./ids.txt"

P0="FOX"
P1="MARTH"
STAGE="BATTLEFIELD"

SLPURL='storage.googleapis.com/slippi.appspot.com'
URLFile='./urls.txt'
SLPDIR='./slp-files'