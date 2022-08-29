# getTourneyGames.py

#arguments
import argparse
import json
from urllib import response
parser = argparse.ArgumentParser()
parser.add_argument("--url", required=True)
parser.add_argument("--body", required=True)
parser.add_argument("--slpurl", required=True)
parser.add_argument("--p0", default="FOX", required=False)
parser.add_argument("--p1", default="FOX", required=False)
parser.add_argument("--stage", default="ALL", required=False)
args = parser.parse_args()

url = str(vars(args)['url'])
body = str(vars(args)['body'])
body = json.loads(body)

stage = str(vars(args)['stage'])
p0 = str(vars(args)['p0'])
p1 = str(vars(args)['p1'])

slpurl = str(vars(args)['slpurl'])

def main():
  import requests
  import urllib.parse
  responseJSON = requests.post(url, json=body).json()
  games = list(responseJSON['data']['getTournament']['games'])

  if (stage != "ALL"):
    games = list(filter(lambda game: (game['stage'] == stage), games))

  def charFilter(player0, player1):
    if (player0['character'] == p0 and player1['character'] == p1):
      return True
    return False
  games = list(filter(lambda game: charFilter(game['participants'][0], game['participants'][1]) or charFilter(game['participants'][1], game['participants'][0]), games))

  for g in games:
    game_url = slpurl+g['slpPath']
    game_url = urllib.parse.quote(game_url)
    print(game_url)

if __name__ == '__main__':
  main()