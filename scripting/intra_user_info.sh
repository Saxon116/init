#!/bin/bash


TOKEN="5076e19da745a10a2284a6592305b407744584784338aa00e5e3a6bd3a7be978"

VALUE=$(curl -sH "Authorization: Bearer $TOKEN" "https://api.intra.42.fr/v2/users/$1" | tr -d '{}')
wallet="wallet"

#curl -X POST --data "grant_type=client_credentials&client_id=05c45c4c5fdc8ac228bb68f5dee9f83ca84ca3d4fe3ab168483d1e4c28d8ca2e&client_secret=d564ea66f71f4fca77d1e169740a89bd036e750c7cb414a6428149885a2923c7" https://api.intra.42.fr/oauth/token
echo
if [ -z "$VALUE" ] || [ -z "$1" ]
then
      echo "Incorrect username or no username specified."
      echo
      echo "usage: ./apiscript.sh intra_username"
      exit 2
fi

echo -n "Name: "
echo $VALUE | grep -Po '"displayname":.*?[^\\]",' | tr -d '",' | cut -f2 -d":"
echo -n "Email: "
echo $VALUE | grep -Po '"email":.*?[^\\]",' | tr -d '",' | cut -f2 -d":"
echo -n "Phone number: "
echo $VALUE | grep -Po '"phone":.*?[^\\]",' | tr -d '",' | cut -f2 -d":"
echo -n "Location: "
echo $VALUE | grep -Po '"location":.*?[^\\]",' | tr -d '",' | cut -f2 -d":" | sed -e "s/$wallet$//"
echo -n "Correction Points: "
echo $VALUE | grep -Po '"correction_point":.*?[^\\]",' | tr -d '",' | grep -oP '(?<=:).*?(?=p)'
echo -n "Wallet: "
echo $VALUE | grep -Po '"wallet":.*?[^\\]",' | head -1 | tr -d '",' | cut -f2 -d":" | cut -f1 -d"g" | awk '{print $1"₳"}'
echo -n "Level: "
echo $VALUE | grep -Po '"level":.*?[^\\]",' | head -1 | tr -d '",' | cut -f2 -d":" | cut -f1 -d"s"
echo
echo "Validated Piscine of "
echo -n $VALUE | grep -Po '"pool_month":.*?[^\\]",' | tr -d '",' | cut -f2 -d":"
echo -n $VALUE | grep -Po '"pool_year":.*?[^\\]",' | tr -d '",' | cut -f2 -d":"

python -mwebbrowser https://cdn.intra.42.fr/users/$1.jpg

#$VALUE | grep -Po '"image_url":.*?[^\\]",' | tr -d '",' | cut -d: -f2-
#grep -Po '"text":.*?[^\\]",'
