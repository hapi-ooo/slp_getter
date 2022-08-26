# get_urls.py
# get the urls of slippi files and output them to standard output


url = 'https://gql-gateway-dot-slippi.uc.r.appspot.com/graphql'
# TODO find max number of games per tourney
body = {"operationName":"GameTableComponent","variables":{"id":"0x7","first":318,"offset":0},"query":"fragment participantChiclet on GameParticipant {\n  id\n  port\n  type\n  color\n  nametag\n  character\n  __typename\n}\n\nfragment matchupDisplay on Game {\n  id\n  participants {\n    id\n    port\n    ...participantChiclet\n    __typename\n  }\n  __typename\n}\n\nfragment gameTableGameData on Game {\n  id\n  slpPath\n  station\n  stage\n  startAt\n  ...matchupDisplay\n  __typename\n}\n\nquery GameTableComponent($id: ID!, $first: Int!, $offset: Int!) {\n  getTournament(id: $id) {\n    id\n    games(first: $first, offset: $offset, order: {desc: startAt}) {\n      ...gameTableGameData\n      __typename\n    }\n    gamesAggregate {\n      count\n      __typename\n    }\n    __typename\n  }\n}\n"}

#arguments
import argparse
parser = argparse.ArgumentParser()
parser.add_argument("--P0", default="FOX", required=False)
parser.add_argument("--P1", default="FOX", required=False)
parser.add_argument("--STAGE", default="ALL", required=False)
args = parser.parse_args()

STAGE = str(vars(args)['STAGE'])
P0 = str(vars(args)['P0'])
P1 = str(vars(args)['P1'])

def main():

  import requests
  import urllib.parse
  games = requests.post(url, json=body).json()['data']['getTournament']['games']

  if (STAGE != "ALL"):
    games = list(filter(lambda game: (game['stage'] == STAGE), games))

  def charFilter(p0, p1):
    if (p0['character'] == P0 and p1['character'] == P1):
      return True
    return False
  games = list(filter(lambda game: charFilter(game['participants'][0], game['participants'][1]), games))

  file_url = 'storage.googleapis.com/slippi.appspot.com'

  for g in games:
    game_url = file_url+g['slpPath']
    game_url = urllib.parse.quote(game_url)
    print(game_url)

if __name__ == '__main__':
  main()