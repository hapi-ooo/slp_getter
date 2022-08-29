#! /cygdrive/c/Windows/system32/bash

URL="https://gql-gateway-dot-slippi.uc.r.appspot.com/graphql"
TournamentsPageBody='{"operationName":"TournamentsPage","variables":{"first":0,"offset":0},"query":"query TournamentsPage($first: Int, $offset: Int) {\n  queryTournament(order: {desc: startAt}, first: $first, offset: $offset) {\n    id\n    __typename\n  }\n  aggregateTournament {\n    count\n    __typename\n  }\n}\n"}'