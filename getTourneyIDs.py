# getTourneyIDs.py

#arguments
import argparse
import json
parser = argparse.ArgumentParser()
parser.add_argument("--url", required=True)
parser.add_argument("--body", required=True)
args = parser.parse_args()

url = str(vars(args)['url'])
body = str(vars(args)['body'])
body = json.loads(body)

def main():
  import requests
  #import urllib.parse
  responseJSON = requests.post(url, json=body).json()
  idCount = responseJSON['data']['aggregateTournament']['count']
  print(f'idCount = {idCount}')

  idList =  responseJSON['data']['queryTournament']
  idList = [x['id'] for x in idList]
  for i in range(idCount):
    print(f'{i}:\t{idList[i]}')

if __name__ == '__main__':
  main()
